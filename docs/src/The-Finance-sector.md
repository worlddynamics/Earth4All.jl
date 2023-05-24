
### Summary
We describe the Finance sector of the Earth4All model, by referring to the Finance view of the Vensim model implementation.

### The Finance sector endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| 10-year Government Interest Rate 1/y | `TGIR` |  |
| 3m Interest Rate 1/y | `TIR` |  |
| Central Bank Signal Rate 1/y | `CBSR` | 0.02 |
| Change in Signal Rate 1/y | `CSR` |  |
| Corporate Borrowing Cost 1/y | `CBC` |  |
| Corporate Borrowing Cost in 1980 1/y | `CBC1980` |  |
| Cost of Capital for Secured Debt 1/y | `CCSD` | 0.175 |
| Expected Long Term Inflation 1/y | `ELTI` | 0.02 |
| Government Borrowing Cost 1/y | `GBC` |  |
| Indicated Signal Rate 1/y | `ISR` |  |
| Normal Corporate Credit Risk 1/y | `NCCR` |  |
| Perceived Inflation CB 1/y | `PI` | 0.02 |
| Perceived Unemployment CB | `PU` | 0.0327 |
| Working Borrowing Cost 1/y | `WBC` |  |

### The Finance sector parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| Financial Sector Response Time y | `FSRT` | 1.0 |
| Inflation Expectation Formation Time y | `IEFT` | 10.0 |
| Inflation Perception Time CB y | `IPT` | 1.0 |
| Inflation Target 1/y | `IT` | 0.02 |
| Normal Bank Operating Margin 1/y | `NBOM` | 0.015 |
| Normal Basic Bank Margin 1/y | `NBBM` | 0.005 |
| Normal Signal Rate 1/y | `NSR` | 0.02 |
| sGReoCR<0: Growth Rate effect on Credit Risk | `GRCR` | 0.0 |
| Signal Rate Adjustment Time y | `SRAT` | 1.0 |
| sINeoSR>0: INflation effect on Signal Rate | `INSR` | 0.7 |
| sUNeoSR<0: UNemployment effect on Signal Rate | `UNSR` | -1.5 |
| Unemployment Perception Time CB y | `UPT` | 1.0 |
| Unemployment Target | `UT` | 0.05 |

### The Finance sector exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| Inflation Rate 1/y | `IR` | Inventory |
| Output Growth Rate 1/y | `OGR` | Output |
| UNemployment RAte | `UNRA` | Labour market |
