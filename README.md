## MetaTrader 5 > Indicator > Dunnigan

![Dunningan Indicator](docs/splash.gif)

### Description

This is a trend indicator based on a strategy created by William Dunnigan that emit signals to buy or sell on any timeframe and can assist in decision making for trading on stock market or Forex.

The signals are fired according to the following rules:

- **Buy Signal** = Fired at the **first candlestick** in which *close price* is higher than the *higher price* of the last candlestick. The *higher and lower prices* of the current candlestick must be higher than the corresponding ones of the last candlestick as well.

![Dunningan UpBar](docs/dunnigan-upbar.png)

- **Sell Signal** = Fired at the **first candlestick** in which *close price* is lower than the *lower price* of the last candlestick. The *higher and lower prices* of the current candlestick must be lower than the corresponding ones of the last candlestick as well.

![Dunningan DownBar](docs/dunnigan-downbar.png)

```Important! Both signals are confirmed by the increase in the tick volume before firing.```

### Settings

![Inputs](docs/inputs.png)

#### Inputs

- **Starting calculation period**: This is the starting calculation period for the Dunnigan signals, and the options are "today", "today + yesterday", "today + past 2 days", "today + past 3 days", "today + past 4 days", "today + past 5 days" and "today + past 6 days".

![Colors](docs/colors.png)

#### Colors

- Dunnigan signal arrows color and width.

----

### Instructions

1. Copy this project folder to your **MetaEditor** indicator folder.
2. Select the .mq5 file and click *'Compile'* button on **MetaEditor**.
3. On **MetaTrader**, insert this compiled indicator into the chart you want.

----

### References

- [MQL5 Documentation](https://www.mql5.com/en/docs)

### MQL5 Market

- [My MQL5 Published Products](https://www.mql5.com/en/users/leonardo_splinter/seller)
