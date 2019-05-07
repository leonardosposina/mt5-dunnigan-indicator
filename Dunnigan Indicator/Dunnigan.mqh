//+------------------------------------------------------------------+
//|                                                     Dunnigan.mqh |
//|                                Copyright 2019, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+

#property copyright "Copyright 2019, Leonardo Sposina."
#property link      "https://www.mql5.com/en/users/leonardo_splinter/seller"
#property version   "1.1"

enum ENUM_DUNNIGAN_SIGNAL {
  NEUTRAL,
  BUY,
  SELL
};

class Dunnigan {

  private:

    double buffer[];
    string label;

  public:

    Dunnigan(int bufferIndex, string title, int arrowIcon, int shift);
 
    void setValue(int index, double value);
    void showComment(void);
    void resetBuffer(void);

    static ENUM_DUNNIGAN_SIGNAL lastSignal;

};

Dunnigan::Dunnigan(int bufferIndex, string title, int arrowIcon, int shift) {
  this.label = title;
  SetIndexBuffer(bufferIndex, this.buffer, INDICATOR_DATA);
  PlotIndexSetInteger(bufferIndex, PLOT_ARROW, arrowIcon);
  PlotIndexSetInteger(bufferIndex, PLOT_ARROW_SHIFT, shift);
  PlotIndexSetString(bufferIndex, PLOT_LABEL, this.label);
}

void Dunnigan::setValue(int index, double value) {
  this.buffer[index] = value;
}

void Dunnigan::showComment(void) {
  Comment(this.label);
}

void Dunnigan::resetBuffer(void) {
  ArrayInitialize(this.buffer, EMPTY_VALUE);
}
