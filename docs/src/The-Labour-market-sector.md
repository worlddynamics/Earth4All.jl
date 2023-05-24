# Labour market 
## Summary
In this memorandum, we will describe the Labour market sector of the Earth4All model, by referring to the Labour market view of the Vensim model implementation.

## The Labour market equations

### The wage rate equations

Nominal wage is the amount of 'money received either in cash or in-kind in a day for standard daily working hours' or 'earnings of a low-paid labour who works on an hourly basis.' The erosion rate of the wage rate depends on the inflation rate according to the fraction if inflation compensated. The bigger is this fraction the smaller is the erosion rate.

$$\mathtt{WRER}(t) = \mathtt{IR}(t)\cdot(1-\mathtt{FIC}),$$
where $\mathtt{FIC}=1$. The wage rate erosion is then equal to the wage rate multiplied by the erosion rate of the wage rate.

$$\mathtt{WRE}(t) = \mathtt{WARA}(t)\cdot\mathtt{WRER}(t).$$
The variation in the wage rate is equal to the change in the wage rate minus the erosion in the wage rate.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{WARA}(t) = \mathtt{CWRA}(t)-\mathtt{WRE}(t).$$
This differential equation is accompanied by the following initialization equation: $\mathtt{WARA}(1980)=3.6715$. This value is computed as the labour productivity in 1980 (that is, the total output cost in 1980 divided by the labour use in 1980) multiplied by the worker share of output in 1980. On the other hand, the change in the wage rate is equal to the wage rate multiplied by the rate of change of the worker share of output computed as the linear interpolation of a table of historical data.

$$\mathtt{CWRA}(t) = \mathtt{WARA}(t)\cdot\mathtt{ROCWSO}(t),$$
where

$$\mathtt{ROCSO}(t) = \mathrm{withlookup}\left(\frac{\mathtt{PURA}(t)}{\mathtt{AUR}},[(0,0.06),(0.5,0.02),(1,0),(1.5,-0.007),(2,-0.01)]\right)$$
and $\mathtt{AUR}=0.05$.

The labour productivity is equal to the total price of the output divided by the labour use.
LAPR ~ (OUTP * PRUN) / LAUS
$$\mathtt{LAPR}(t) = \frac{\mathtt{OUTP}(t)\cdot\mathtt{PRUN}}{\mathtt{LAUS}(t)},$$
where $\mathtt{PRUN}=1$ (this value is indeed computed as the cost per unit in 1980 multiplied by one plus the margin in 1980). The wage share is, hence, the ratio between the wage rate and the labour productivity.

$$\mathtt{WASH}(t) = \frac{\mathtt{WARA}(t)}{\mathtt{LAPR}(t)}.$$

### The hours worked equations

The normal number of hours worked depends on the GDP per person by a multiplier factor.

$$\mathtt{HWMGDPP}(t) = 1+\mathtt{TENHW}\left(\frac{\mathtt{GDPP}(t)}{\mathtt{GDPP1980}}-1\right),$$
where $\mathtt{TENHW}=-0.03$ (since the number of hours worked falls linearly from $2000$ hours per year, at $6000$\$ yearly salary per person, to $1500$ hours per year, at $48000$\$ yearly salary per person) and $\mathtt{GDPP1980}=6.4$ (which is the GDP per person in 1980). Note that the greater is the GDP per person with respect to its value in 1980, the smaller is the effect of the GDP per person on the normal number of hours worked. The normal number of hours worked is equal to the number of hours worked in 1980 times the above multiplier: this goal is reached gradually during a certain time necessary to adjust the number of hours worked.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{NHW}(t) = \frac{\mathtt{NHW}(1980)\cdot\mathtt{HWMGDPP}(t)-\mathtt{NHW}(t)}{\mathtt{TAHW}},$$
where $\mathtt{TAHW}=5$ and $\mathtt{NHW}(1980)=2$ (since the unit measure is kilo-hours), which is also the initialization equation of the above differential equation. The average number of hours worked is then equal to the normal number of hours worked divided by the number of persons per full-time job.

$$\mathtt{AHW}(t) = \frac{\mathtt{NHW}(t)}{\mathtt{PFTJ}},$$
where $\mathtt{PFTJ}=1$. The average number of hours worked in 1980 is simply the above formula evaluated at time 1980.

$$\mathtt{AHW1980}(t) = \frac{\mathtt{NHW}(1980)}{\mathtt{PFTJ80}},$$
where $\mathtt{PFTJ80}=1$. Moreover, the average gross income per worker is equal to the wage rate multiplied by the average number of hours worked.

$$\mathtt{AGIW}(t) = \mathtt{WARA}(t)\cdot\mathtt{AHW}(t).$$

### The worker share of output equations

The variation of the worker share of output is equal to its change minus the long-term erosion of the worker share of output.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{WSO}(t) = \mathtt{CWSO}(t)-\mathtt{LTEWSO}(t).$$
This differential equation is accompanied by the following initialization equation: $\mathtt{WSO}(1980)=0.5$. The long-term erosion is equal to the worker share of output multiplied by the real wage erosion rate.

$$\mathtt{LTEWSO}(t) = \mathtt{WSO}(t)\cdot\mathtt{RWER},$$
where $\mathtt{RWER}=0.015$. On the other hand, the change of the worker share of output is equal to its value multiplied by its rate of change. 

$$\mathtt{CWSO}(t) = \mathtt{WSO}(t)\cdot\mathtt{ROCWSO}(t).$$

### The capital labour ratio equations

The effect of the GDP per person on the rate of change of the capital labour ratio is determined by a constant factor.

$$\mathtt{GDPPEROCCLR}(t) = \mathrm{max}\left(0, 1+\mathtt{GDPPEROCCLRM}\left(\frac{\mathtt{GDPP}(t)}{\mathtt{GDPP1980}}-1\right)\right),$$
where $\mathtt{GDPPEROCCLRM}=-0.1$. Once again, the greater is the GDP per person with respect to its value in 1980, the smaller is the effect of the GDP per person on the rate of change of the capital labour ratio. The rate of change of the capital labour ratio is equal to its value in 1980 times the above multiplier.

$$\mathtt{ROCECLR}(t) = \mathtt{ROCECLR80}\cdot\mathtt{GDPPEROCCLR}(t),$$
where $\mathtt{ROCECLR80}=0.02$. The variation of the embedded capital labour rate is equal to its change, which is determined by the above rate of change.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{ECLR}(t) = \mathtt{CECLR}(t),$$
where

$$\mathtt{CECLR}(t) = \mathtt{ROCECLR}\cdot\mathtt{ECLR}(t).$$
The above differential equation is accompanied by the following initialization equation: $\mathtt{ECLR}(1980)=41$ (which is equal to the capacity divided by the available work seekers  in 1980 and it was changed from $44.7$ to get suitable amplitude for new lower savings slope).

### The labour participation equations

The extra normal labour participation rate starting from 2022 linearly reaches a goal value during the period for introducing a policy.

$$\mathtt{ENLPR2022}(t) = \mathrm{ramp}\left(\frac{\mathtt{GENLPR}}{\mathtt{IPP}}, 2022, 2022+\mathtt{IPP}(t)\right),$$
where $\mathtt{GENLPR}=0$. The normal labour participation rate depends on how much the worker share of output changes with respect to its value in 1980 and from the extra normal labour participation rate starting from 2022.

$$\mathtt{NLPR}(t) = \mathtt{NLPR80}\cdot\left(1+\mathtt{WSOELPR}\cdot\left(\frac{\mathtt{WSO}(t)}{\mathtt{WSO}(1980)}-1\right)\right)+\mathtt{ENLPR2022}(t),$$
where $\mathtt{WSOELPR}=0.2$.

The perceived surplus workforce depends on the ratio between the perceived unemployment rate and the acceptable unemployment rate.

$$\mathtt{PSW}(t) = \mathtt{AUR}\cdot\left(1+\mathtt{PUELPR}\cdot\left(\frac{\mathtt{PURA}(t)}{\mathtt{AUR}}-1\right)\right),$$
where $\mathtt{PUELPR}=0.05$.

The indicated labour participation rate is then equal to the normal labour participation rate minus the perceived surplus workforce.

$$\mathtt{ILPR}(t) = \mathtt{NLPR}(t)-\mathtt{PSW}(t).$$
The labour participation rate reaches the above value during the time necessary for enter or leave the labour market.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{LPR}(t) = \frac{\mathtt{ILPR}(t)-\mathtt{LPR}(t)}{\mathtt{TELLM}},$$
where $\mathtt{TELLM}=5$. This differential equation is accompanied by the following initialization equation: $\mathtt{LPR}(1980)=0.8$ (which is the value indicated labour participation rate in 1980).

The working age population is simply the population whose age is between 20 year and the pension age.

$$\mathtt{WAP}(t) = \mathtt{A20PA}(t).$$
Hence, the available workforce is equal to the above value multiplied by the labour participation rate.

$$\mathtt{AVWO}(t) = \mathtt{WAP}(t)\cdot\mathtt{LPR}(t).$$

### The wage effect equations

The indicated wage effect on the optimal capital labour ratio depends on how much the worker share of output changes with respect to its value in 1980.

$$\mathtt{IWEOCLR}(t) = 1+\mathtt{WSOECLR}\cdot\left(\frac{\mathtt{WSO}(t)}{\mathtt{WSO}(1980)}-1\right),$$
where $\mathtt{WSOECLR}=1.05$. The wage effect on optimal capital labour ratio reaches gradually the above value during a period for change tooling.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{WEOCLR}(t) = \frac{\mathtt{IWEOCLR}(t)-\mathtt{WEOCLR}(t)}{\mathtt{TCT}(t)},$$
where

$$\mathtt{TCT}(t)=\frac{\mathtt{TYLD}}{3}$$
and $\mathtt{TYLD}=2.3$. This differential equation is accompanied by the following initialization equation: $\mathtt{WEOCLR}(1980)=1$ (which is the value indicated wage effect on the optimal capital labour ratio in 1980).

### The workforce equations

The optimal capital labour ratio is equal to the embedded capital labour ratio multiplied by the wage effect on the optimal capital labour ratio.

$$\mathtt{OCLR}(t) = \mathtt{ECLR}(t)\cdot\mathtt{WEOCLR}(t).$$
The optimal workforce is then equal to the capacity divided by the above value and multiplied by the number of persons per full-time job.

$$\mathtt{OPWO}(t) = \frac{\mathtt{CAP}(t)}{\mathtt{OCLR}(t)}\cdot\mathtt{PFTJ}(t).$$

The variation of the workforce is equal to its change.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{WF}(t) = \mathtt{CHWO}(t).$$
This differential equation is accompanied by the following initialization equation: $\mathtt{WF}(1980)=1530$. On the other hand, the change of workforce is equal to the optimal workforce minus the workforce divided by the delay for hiring and/or firing (in other words, the workforce reaches the optimal workforce during this delay). 

$$\mathtt{CHWO}(t) = \frac{\mathtt{OPWO}(t)-\mathtt{WF}(t)}{\mathtt{HFD}(t)},$$
where

$$\mathtt{HFD}(t)=\frac{\mathtt{TYLD}}{3}.$$

### The labour use equations

The labour use is the workforce multiplied by the average number of hours worked.

$$\mathtt{LAUS}(t) = \frac{\mathtt{WF}(t)}{\mathtt{AHW}(t)}.$$
The labour use in 1980 is simply the above formula evaluated at time 1980.

$$\mathtt{LAUS80}(t) = \frac{\mathtt{WF}(1980)}{\mathtt{AHW1980}(t)}.$$

### The unemployment equations

The number of unemployed is equal to the available workforce minus the workforce.

$$\mathtt{UNEM}(t) = \mathrm{max}(0,\mathtt{AVWO}(t)-\mathtt{WF}(t)).$$
Thus, the unemployment rate is just the above value divided by the available workforce.

$$\mathtt{UR}(t) = \frac{\mathtt{UNEM}(t)}{\mathtt{AVWO}(t)}.$$
The perceived unemployment rate reaches gradually the above value during a period for perceiving the unemployment.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{PURA}(t) = \frac{\mathtt{UR}(t)-\mathtt{PURA}(t)}{\mathtt{UPT}(t)},$$
where

$$\mathtt{UPT}(t)=\frac{\mathtt{TYLD}}{3}.$$

The participation is equal to the labour participation rate multiplied by complement of the perceived unemployment rate.

$$\mathtt{PART}(t) = \mathtt{LPR}(t)(1-\mathtt{PURA}(t)).$$

## The Labour market endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| AVailable WOrkforce Mp | `AVWO` |  |
| Average Gross Income per Worker kdollar/p/y | `AGIW` |  |
| Average Hours Worked kh/y | `AHW` |  |
| Change in Embedded CLR kcu/ftj/y | `CECLR` |  |
| Change in wage rate dollar/ph/y | `CWR` |  |
| CHange in WOrkforce Mp | `CHWO` |  |
| Change in WSO 1/y | `CWSO` |  |
| Embedded Capital Labour Ratio kcu/ftj | `ECLR` | 41.0 |
| Extra Normal Labour Participation Rate from 2022 | `ENLPR2022` |  |
| GDPppeoROCCLR: GDPP Effect on ROC in CLR | `GDPPEROCCLR` |  |
| Hours Worked Mult from GDPpP | `HWMGDPP` |  |
| Indicated Labour Participation Rate | `ILPR` |  |
| Indicated Wage Effect on Optimal CLR | `IWEOCLR` |  |
| Labour Participation Rate | `LPR` | 0.8 |
| LAbour PRoductivity dollar/ph | `LAPR` | 7.343 |
| LAbour USe Gph/y | `LAUS` | 3060.0 |
| Long-Term Erosion of WSO 1/y | `LTEWSO` |  |
| Normal Hours Worked kh/ftj/y | `NHW` | 2.0 |
| Normal LPR | `NLPR` | 0.85 |
| Optimal Capital Labour Ratio kcu/ftj | `OCLR` |  |
| OPtimal WOrkforce Mp | `OPWO` |  |
| Participation | `PART` |  |
| Perceived Surplus Workforce | `PSW` |  |
| Perceived Unemployment RAte | `PURA` | 0.05 |
| Rate Of Change in ECLR 1/y | `ROCECLR` | 0.02 |
| ROC in WSO - Table 1/y | `ROCWSO` |  |
| UNEMployed Mp | `UNEM` |  |
| UNemployment RAte | `UNRA` |  |
| Wage Effect on Optimal CLR | `WEOCLR` | 1.0 |
| WAge RAte dollar/ph | `WARA` | 3.6715 |
| Wage Rate Erosion dollar/ph/y | `WRE` |  |
| Wage Rate Erosion Rate 1/y | `WRER` |  |
| WAge Share | `WASH` |  |
| Worker Share of Output | `WSO` | 0.5 |
| WorkForce Mp | `WF` | 1530.0 |
| Working Age Population Mp | `WAP` |  |

## The Labour market parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| Acceptable Unemployment Rate | `AUR` | 0.05 |
| Fraction of Inflation Compensated | `FIC` | 1.0 |
| Goal for Extra Normal Labour Participation Rate | `GENLPR` | 0.0 |
| Hiring/Firing Delay y | `HFD` | 0.7667 |
| Persons per Full-Time Job p/ftj | `PFTJ` | 1.0 |
| PRice per UNit dollar/u | `PRUN` | 1.0 |
| Real Wage Erosion Rate 1/y | `RWER` | 0.015 |
| sGDPppeoROCCLR<0: GDPP Effect on ROC in CLR | `GDPPEROCCLRM` | -0.1 |
| sPUNeoLPR>0: Perceived Unemployment Effect on LPR | `PUELPR` | 0.05 |
| sTIeoNHW<0: GDP Effect on Number Hours Worked | `GDPENHW` | -0.03 |
| sWSOeoCLR>0: Worker Share of Output Effect on Capital Ratio Labour | `WSOECLR` | 1.05 |
| sWSOeoLPR>0: Worker Share of Output Effect on Labour Participation Rate | `WSOELPR` | 0.2 |
| Time to Adjust Hours Worked y | `TAHW` | 5.0 |
| Time to Change Tooling y | `TCT` | 0.7667 |
| Time to Enter/Leave Labor Market y | `TELLM` | 5.0 |
| Unemployment Perception Time y | `UPT` | 0.7667 |

## The Labour market exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| Aged 20-Pension Age Mp | `A20PA` | Population |
| CAPAcity | `CAPA` | Output |
| GDP per Person kDollar/p/y | `GDPP` | Population |
| Introduction Period for Policy y | `IPP` | Wellbeing |
| Inflation Rate 1/y | `IR` | Inventory |
| OUTPut Gu/y | `OUTP` | Inventory |
