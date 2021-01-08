//+------------------------------------------------------------------+
//|                                               DunniganSignal.mqh |
//|                                Copyright 2020, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Leonardo Sposina."
#property link      "https://www.mql5.com/en/users/leonardo_splinter/seller"
#property version   "1.00"

enum ENUM_DUNNIGAN_SIGNAL {
  DUNNIGAN_SIGNAL_NEUTRAL,
  DUNNIGAN_SIGNAL_BUY,
  DUNNIGAN_SIGNAL_SELL
};

class DunniganSignal {
  private:

    static ENUM_DUNNIGAN_SIGNAL lastSignal;

  public:

    static ENUM_DUNNIGAN_SIGNAL check(
      int i,
      const double& low[],
      const double& high[],
      const double& open[],
      const double& close[]
    );

};

static ENUM_DUNNIGAN_SIGNAL DunniganSignal::check(
  int i,
  const double& low[],
  const double& high[],
  const double& open[],
  const double& close[]
) {

  if (
    lastSignal != DUNNIGAN_SIGNAL_BUY &&
    low[i] > low[i - 1] &&
    high[i] > high[i - 1] &&
    close[i] > high[i - 1]
  ) {
    DunniganSignal::lastSignal = DUNNIGAN_SIGNAL_BUY;
    return DUNNIGAN_SIGNAL_BUY;
  }
    
  else if (
    lastSignal != DUNNIGAN_SIGNAL_SELL &&
    low[i] < low[i - 1] &&
    high[i] < high[i - 1] &&
    close[i] < low[i - 1]
  ) {
    DunniganSignal::lastSignal = DUNNIGAN_SIGNAL_SELL;
    return DUNNIGAN_SIGNAL_SELL;
  }

  return DUNNIGAN_SIGNAL_NEUTRAL;
}

ENUM_DUNNIGAN_SIGNAL DunniganSignal::lastSignal = DUNNIGAN_SIGNAL_NEUTRAL;