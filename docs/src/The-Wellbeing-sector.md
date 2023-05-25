#  Wellbeing 
## Summary
We describe the Wellbeing sector of the Earth4All model, by referring to the Wellbeing view of the Vensim model implementation.

## Endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| Average WellBeing from Disposable Income | `AWBDI` |  |
| Average WellBeing from Global Warming | `AWBGW` |  |
| Average WellBeing from INequality | `AWBIN` |  |
| Average WellBeing from Progress | `AWBP` |  |
| Average WellBeing from Public Spending | `AWBPS` |  |
| Awerage WellBeing Index | `AWBI` |  |
| Indicated Reform Delay y | `IRD` |  |
| Indicated Social Trust | `IST` |  |
| Inequity Effect on Social Trust | `IEST` |  |
| Introduction Period for Policy y | `IPP` |  |
| Observed Rate of Progress 1/y | `ORP` | 0.0 |
| Past Average WellBeing Index | `PAWBI` | 0.65 |
| Public Spending as Share of GDP | `PSSGDP` |  |
| Public Spending Effect on Social TRust | `PSESTR` |  |
| Reform Delay | `RD` | 30.0 |
| Social TEnsion | `STE` | 1.3 |
| Social TEnsion Effect on Reform Delay | `STEERD` |  |
| Social Trust | `STR` | 0.6 |
| Social TRust Effect on Reform Delay | `STRERD` |  |
| WellBeing Effect of Participation | `WBEP` |  |

## Parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| Acceptable Inequality | `AI` | 0.6 |
| Acceptable Progress 1/y | `AP` | 0.02 |
| Average WellBeing Perception Delay y | `AWBPD` | 9.0 |
| Diminishing Return Disposable Income | `DRDI` | 0.5 |
| Diminishing Return Public Spending | `DRPS` | 0.7 |
| Exogenous Introduction Period Flag | `EIPF` | 0.0 |
| Exogenous Introduction Period y | `EIP` | 30.0 |
| Min WellBeing from Global Warming | `MWBGW` | 0.2 |
| Normal Reform Delay y | `NRD` | 30.0 |
| Satisfactory Public Spending | `SPS` | 0.3 |
| sGWeoAW<0: Global Warming Effect on Average WellBeing from Global Warming Flag | `GWEAWBGWF` | -0.58 |
| sIIeoAW<0: Inequality Effect on Average WellBeing from Inequality Flag | `IEAWBIF` | -0.6 |
| sLPeoAWP>0: PArtecipation Effect on Average WellBeing Flag | `PAEAWBF` | 0.5 |
| sPPReoSTE<0: Progress Effect on Social Tension Flag | `PESTF` | -15.0 |
| sROPeoAW>0: PRogress Effect on Average WellBeing Flag | `PREAWBF` | 6.0 |
| sSTEeoRD>0: Social Tension Effect on Reform Delay Flag | `STEERDF` | 1.0 |
| sSTReoRD<0: Social Trust Effect on Reform Delay Flag | `STRERDF` | -1.0 |
| Threshold Disposable Income kdollar/p/y | `TDI` | 15.0 |
| Threshold Inequality | `TI` | 0.5 |
| Threshold Participation | `TP` | 0.8 |
| Threshold Progress Rate 1/y | `TPR` | 0.02 |
| Threshold Public Spending kdollar/p/y | `TPS` | 3.0 |
| Threshold Warming deg C | `TW` | 1.0 |
| Time to Change Reform Delay y | `TCRD` | 10.0 |
| Time to Establish Social Trust y | `TEST` | 10.0 |

## Exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| GDP per Person kdollar/p/y | `GDPP` | Population |
| INEQuality | `INEQ` | Demand |
| Labour Participation Rate | `LPR` | Labour market |
| Public Spending per Person kdollar/p/y | `PSP` | Public |
| Perceived WArming deg C | `PWA` | Climate |
| Worker Disposable Income kdollar/p/y | `WDI` | Demand |