### Summary
We describe the Other performance indicators sector of the Earth4All model, by referring to the Other performance indicators view of the Vensim model implementation.

### The Other performance indicators sector endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| Cost of Food and Energy TAs GDollar/y | `CFETA` |  |
| Cost of TAs GDollar/y | `CTA` |  |
| Fraction Below 15 kDollar/p/y | `FB15` |  |
| Inequity Effect on Logistic k | `IEL` |  |
| Logistic K | `LK` |  |
| Past GDP per Person kDollar/y | `PGDPP` | 5.952 |
| Population Below 15 kDollar/p/y Mp | `PB15` |  |
| Rate of Growth in GDP per Person 1/y | `RGGDPP` |  |

### The Other performance indicators sector parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| Normal K | `NK` | 0.3 |
| sINEeoLOK<0: INequity Effect on LOgistic K | `INELOK` | -0.5 |
| Time to Establish Growth Rate y | `TEGR` | 4.0 |

### The Other performance indicators sector exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| Cost of Energy GDollar/y | `CE` | Energy |
| COst of FOod GDollar/y | `COFO` | Food and land |
| GDP per Person kDollar/p/y | `GDPP` | Population |
| INEQuality | `INEQ` | Demand |
| POPulation Mp | `POP` | Population |
