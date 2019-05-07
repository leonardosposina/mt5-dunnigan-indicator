//+------------------------------------------------------------------+
//|                                           Dunnigan Indicator.mq5 |
//|                                Copyright 2019, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+

#include "Dunnigan.mqh"

enum ENUM_COUNT_DAYS {
  today           = 0,  // today
  past_one_day    = 1,  // today + yesterday
  past_two_days   = 2,  // today + past 2 days
  past_three_days = 3,  // today + past 3 days
  past_four_days  = 4,  // today + past 4 days
  past_five_days  = 5,  // today + past 5 days
  past_six_days   = 6,  // today + past 6 days
};

input ENUM_COUNT_DAYS Starting_Calculation_Period = past_one_day; // Starting calculation period

ENUM_DUNNIGAN_SIGNAL Dunnigan::lastSignal = NEUTRAL;

Dunnigan* dunniganBuy;
Dunnigan* dunniganSell;

int firstCandleShiftIndex;
datetime calculatedTimestamp;
int currentCandleIndex = 0;

int OnInit() {
  const uint ICON_ARROW_UP = 225;
  const uint ICON_ARROW_DOWN = 226;
  const int ICON_SHIFT = 6;
  
  dunniganBuy = new Dunnigan(0, "Dunnigan - Buy signal", ICON_ARROW_UP, ICON_SHIFT);
  dunniganSell = new Dunnigan(1, "Dunnigan - Sell signal", ICON_ARROW_DOWN, -ICON_SHIFT);

  calculatedTimestamp = createPastTimestampWithoutHour(Starting_Calculation_Period);

  return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
  Comment("");
  delete dunniganBuy;
  delete dunniganSell;
  ChartRedraw();
}

int OnCalculate(
  const int rates_total,
  const int prev_calculated,
  const datetime &time[],
  const double &open[],
  const double &high[],
  const double &low[],
  const double &close[],
  const long &tick_volume[],
  const long &volume[],
  const int &spread[]
) {

  firstCandleShiftIndex = iBarShift(_Symbol, _Period, calculatedTimestamp);

  if (firstCandleShiftIndex <= 0) 
    return(rates_total);
    
  if (isNewCandle(rates_total)) {
    dunniganBuy.resetBuffer();
    dunniganSell.resetBuffer();
  }

  for (int i = rates_total - firstCandleShiftIndex; i < rates_total; i++) {
    
    Comment("");
    
    if (Dunnigan::lastSignal != BUY) {
      if (isBuySignal(i, low, high, open, close) && isTickVolumeHigher(i, tick_volume)) {
        dunniganBuy.setValue(i, high[i - 1]);
        dunniganBuy.showComment();
        Dunnigan::lastSignal = BUY;
      }
    }
    
    if (Dunnigan::lastSignal != SELL) {
      if (isSellSignal(i, low, high, open, close) && isTickVolumeHigher(i, tick_volume)) {
        dunniganSell.setValue(i, low[i - 1]);
        dunniganSell.showComment();
        Dunnigan::lastSignal = SELL;
      }
    }
  }

  return(rates_total);
}

bool isNewCandle(int ratesTotal) {
  bool result = false;
  
  if (currentCandleIndex != ratesTotal) {
    currentCandleIndex = ratesTotal;
    result = true;
  }
    
  return result;
}

datetime createPastTimestampWithoutHour(int pastDays) {
  MqlDateTime timestamp;
  TimeToStruct(TimeCurrent(), timestamp);
  timestamp.day = timestamp.day - pastDays;
  timestamp.hour = 0;
  timestamp.min = 0;
  timestamp.sec = 0;
  
  return StructToTime(timestamp);
}

bool isBuySignal (int i, const double &min[], const double &max[], const double &open[], const double &close[]) {
  return (
    min[i] > min[i - 1] && 
    max[i] > max[i - 1] &&
    close[i] > max[i -1]
  );
}

bool isSellSignal (int i, const double &min[], const double &max[], const double &open[], const double &close[]) {
  return (
    min[i] < min[i - 1] &&
    max[i] < max[i - 1] &&
    close[i] < min[i - 1]
  );
}

bool isTickVolumeHigher(int index, const long &volume[]) {
  return (volume[index] > volume[index - 1]);
}
