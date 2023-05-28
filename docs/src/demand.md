# Demand 
## Summary
We describe the Demand sector of the Earth4All model, by referring to the Demand view of the Vensim model implementation.

## Equations

### The extra taxes equations

The extra general taxes from 2022 are the sum of three fractions of the national income: a general, an empowerment, and a pension fraction.

$$\mathtt{EGTF2022}(t) = I_{t>2022}(t)\cdot(\mathtt{EGTRF2022}+\mathtt{EETF2022}+\mathtt{EPTF2022})\cdot\mathtt{NI}(t),$$
where $\mathtt{EGTRF2022}=0.01$, $\mathtt{EETF2022}=0.02$, and $\mathtt{EPTF2022}=0.02$. Apart from the extra general taxes, starting from 2022 there will be the extra taxes due to the turnarounds proposed by the authors of the model. These taxes are equal to the extra cost of the turnarounds multiplied by the fraction of this extra cost which has to be sustained by extra taxes.

$$\mathtt{ETTAF2022}(t) = I_{t>2022}(t)\cdot\mathtt{ECTAF2022}(t)\cdot\mathtt{FETACPET},$$
where $\mathtt{FETACPET}=0.5$. The goal for the extra taxes from 2022 is then the sum of the extra general taxes and the extra taxes due to the turnarounds from 2022.

$$\mathtt{GETF2022}(t) = \mathtt{EGTF2022}(t)\cdot\mathtt{ETTAF2022}(t).$$

This goal is reached gradually, depending on the the time necessary to implement new taxes. Hence, the extra taxes from 2022 are defined by the following equation.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{ETF2022}(t) = \frac{\mathtt{GETF2022}(t)-\mathtt{ETF2022}(t)}{\mathtt{TINT}},$$
where $\mathtt{TINT}=5$. The above differential equation is accompanied by the following initialization value: $\mathtt{ETF2022}(1980) = 0$ (indeed, no extra taxes will be created before 2022).

### The government gross income and budget fraction to workers equations

The taxes on the income of workers is proportional to the national income multiplied by the worker share of the output.

$$\mathtt{ITW}(t) = \mathtt{BITRW}\cdot\mathtt{NI}(t)\cdot\mathtt{WSO}(t),$$
where $\mathtt{BITRW}=0.2$. Hence, the taxes coming from the workers are equal to the taxes on the income of workers plus the fraction of the extra taxes from 2022 paid by workers.

$$\mathtt{WT}(t) = \mathtt{ITW}(t)+\mathtt{ETF2022}(t)\cdot(1-\mathtt{FETPO}),$$
where $\mathtt{FETPO}=0.8$. The goal for the fraction of the government budget assigned to workers is the sum of the fraction transferred in 1980 and the extra transfer from 2022.

$$\mathtt{GFGBW}(t) = \mathtt{FT1980}+I_{t>2022}(t)\cdot\mathtt{ETGBW},$$
where $\mathtt{FT1980}=0.3$ and $\mathtt{ETGBW}=0.2$. This goal is reached gradually, depending on the the time necessary to implement new taxes. Hence, the fraction of the government budget assigned to workers is defined by the following equation.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{FGBW}(t) = \frac{\mathtt{GFGBW}(t)-\mathtt{FGBW}(t)}{\mathtt{TINT}}.$$
The above differential equation is accompanied by the following initialization value: $\mathtt{FGBW}(1980) = 0.3$ (since no extra taxes will be created before 2022).

The goal for the extra income coming from commons (that is, resources belonging to the whole of the community), as a share share of the national income, is set equal to $0.02$. This goal is reached linearly starting from 2022 and in as many years as specified by the period fro introducing a policy. 

$$\mathtt{IC2022}(t) = \mathtt{NI}(t)\cdot I_{t>2022}(t)\cdot\mathrm{ramp}\left(\frac{\mathtt{GEIC}}{\mathtt{IPP}(t)}, 2022, 2020+\mathtt{IPP}(t)\right),$$
where $\mathtt{GEIC}=0.02$.

The government gross income is then equal to the sum of four variables: the worker and owner taxes, the owner and worker sales taxes, and the income from commons.

$$\mathtt{GGI}(t) = \mathtt{WT}(t)+\mathtt{OT}(t)+\mathtt{STW}(t)+\mathtt{STO}(t)+\mathtt{IC2022}(t).$$
As share of the national income, the government gross income has just to be divided by the national income.

$$\mathtt{GGIS}(t) = \frac{\mathtt{GGI}(t)}{\mathtt{NI}(t)}.$$

### The government cash inflow equations

The transfer payments are equal to the government gross income times the fraction of the government budget devoted to workers.

$$\mathtt{TP}(t) = \mathtt{GGI}(t)\cdot\mathtt{FGBW}(t).$$

The government net income is thus equal to the government gross income minus the above transfer payments plus the total sales taxes.

$$\mathtt{GNI}(t) = \mathtt{GGI}(t)-\mathtt{TP}(t)+\mathtt{ST}(t).$$
As share of the national income, the government net income has just to be divided by the national income.

$$\mathtt{GNISNI}(t) = \frac{\mathtt{GNI}(t)}{\mathtt{NI}(t)}.$$
The basic measure of a nation's debt burden is the total amount of outstanding government debt divided by the size of the economy, as measured by the national income. Hence, the maximum government debt is equal to the national income multiplied by the maximum government debt burden.

$$\mathtt{MGD}(t) = \mathtt{NI}(t)\cdot\mathtt{MGDB},$$
where $\mathtt{MGDB}=1$. The variation in the government debt is equal to the government new debt minus the sum of the debt cancellation and the government payback.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{GD}(t) = \mathtt{GND}(t)-\mathtt{CANCD}(t)-\mathtt{GP}(t).$$
The above differential equation is accompanied by the following initialization value: $\mathtt{GD}(1980) = 28087\cdot\mathtt{MATGF}$ (which is equal to one year's national income, that is, $28160$, somewhat reduced in order to avoid transient). The contribution of the government new debt is the difference between the maximum government debt and the current government debt divided by the government drawdown period: to this contribution a stimulus (that is, a fraction of the national income) starting from 2022 is also added.

$$\mathtt{GND}(t) = \mathrm{max}\left(0,\frac{\mathtt{MGD}(t)-\mathtt{GD}(t))}{\mathtt{GDDP}}\right)+I_{t>2022}(t)\cdot\mathtt{GSF2022}\cdot\mathtt{NI}(t),$$
where $\mathtt{GDDP}=10$ and $\mathtt{MGDB}=1$. On the the other hand, the debt cancellation is an exceptional event which happens during 2022 and is equal to a fraction of the government debt.

$$\mathtt{CANCD}(t) = I_{t\geq2022}(t)\cdot I_{t<2023}(t)\cdot\mathtt{GD}(t)\cdot\mathtt{FGDC2022},$$
where $\mathtt{FGDC2022}=0.1$. Finally, the government payback is equal to the government debt divided by the government payback period.

$$\mathtt{GP}(t) = \frac{\mathtt{GD}(t)}{\mathtt{GPP}},$$
where $\mathtt{GPP}=200$. The government debt burden is just the government debt as share of the national income equal.

$$\mathtt{GDB}(t) = \frac{\mathtt{GD}(t)}{\mathtt{NI}(t)}.$$

The government interest cost is equal to the government debt multiplied by the government borrowing cost.

$$\mathtt{GIC}(t) = \mathtt{GD}(t)\cdot\mathtt{GBC}(t).$$

The global government finance is, hence, the sum of the government interest cost and the government payback as share of the national income.

$$\mathtt{GFSNI}(t) = \frac{\mathtt{GIC}(t)+\mathtt{GP}(t)}{\mathtt{NI}(t)}.$$

The cash flow from the government to the banks is equal to the government interest cost plus the government payback minus the government new debt.

$$\mathtt{CFGB}(t) = \mathtt{GIC}(t)+\mathtt{GP}(t)-\mathtt{GND}(t).$$

The government cash inflow is then equal to the government net income minus the cash flow from the government to the banks.

$$\mathtt{GCIN}(t) = \mathtt{GNI}(t)-\mathtt{CFGB}(t).$$
The cash inflow value is reached by the permanent government cash inflow during the time to adjust the budget.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{PGCIN}(t) = \frac{\mathtt{GCIN}(t)-\mathtt{PGCIN}(t)}{\mathtt{TAB}},$$
where $\mathtt{TAB}=1$.

### The government spending and share of GDP equations

The government purchases are equal to a specific fraction of the permanent government cash inflow.

$$\mathtt{GPU}(t) = \mathtt{PGCIN}(t)\cdot\mathtt{GCF},$$
where $\mathtt{GCF}=0.75$. The government investment in public capacity is then equal to the difference between the permanent government cash inflow and the government purchases.

$$\mathtt{GIPC}(t) = \mathtt{PGCIN}(t)-\mathtt{GPU}(t).$$
Equivalently, the total government spending is the sum the government purchases and the government investment in public capacity.

$$\mathtt{GS}(t) = \mathtt{GPU}(t)+\mathtt{GIPC}(t).$$
As a share of the national income, this is the government share of GDP.

$$\mathtt{GSGDP}(t) = \frac{\mathtt{GS}(t)}{\mathtt{NI}(t)}.$$
### The owner and worker taxes equations

The basic rate of the taxes on the income of owners (as a share of the national income) is equal to the rate in 1980 plus the desired rate in 2022 (which is reached linearly starting from 1980) plus the desired final rate (which is reached linearly starting from 2022).

$$\mathtt{BITRO}(t) = \mathrm{min}(1, \mathtt{ITRO1980})+\mathrm{ramp}\left(\frac{\mathtt{ITRO2022}-\mathtt{ITRO1980}}{42}, 1980, 2022\right)+\mathrm{ramp}\left(\frac{\mathtt{GITRO}-\mathtt{ITRO2022}}{78}, 2022, 2100\right),$$
where $\mathtt{ITRO1980}=0.4$, $\mathtt{ITRO2022}=0.3$, and $\mathtt{GITRO}=0.3$. The taxes on the income of owners is then equal to the basic rate of the taxes on the income of owners multiplied by the national income and by the owner share of the output (that is, one minus the worker share of the output).

$$\mathtt{ITO}(t) = \mathtt{BITRO}(t)\cdot\mathtt{NI}(t)\cdot(1-\mathtt{WSO}(t)).$$

The total taxes paid by owners is equal to the taxes on the income plus the fraction of the extra taxes from 2022 paid by owners.
$$\mathtt{OT}(t) = \mathtt{ITO}(t)+\mathtt{ETF2022}(t)\cdot\mathtt{FETPO}.$$

The total income from workers is equal to the national income multiplied by the worker share of the output.

$$\mathtt{WI}(t) = \mathtt{NI}(t)\cdot\mathtt{WSO}(t).$$
Hence, the worker tax rate is just the ratio between the worker taxes and the worker income.

$$\mathtt{WTR}(t) = \frac{\mathtt{WT}(t)}{\mathtt{WI}(t)}.$$

The total income from owners is equal to the national income multiplied by the owner share of the output (that is, one minus the worker share of the output).

$$\mathtt{OI}(t) = \mathtt{NI}(t)\cdot(1-\mathtt{WSO}(t)).$$
Hence, the owner tax rate is just the ratio between the owner taxes and the owner income.

$$\mathtt{OTR}(t) = \frac{\mathtt{OT}(t)}{\mathtt{OI}(t)}.$$

### The owner consumption and saving equations

The owner saving fraction is equal to its value in 1980 times a factor that depends on the effective GDP per person. In particular, the equation specifying the owner saving fraction is the following one.

$$\mathtt{OSF}(t) = \mathtt{OSF1980}\cdot\left(1+\mathtt{GDPOSR}*\left(\frac{\mathtt{EGDPP}(t)}{\mathtt{GDPP1980}}-1\right)\right),$$
where $\mathtt{OSF1980}=0.9$ and $\mathtt{GDPOSR}=-0.06$. Hence, the more the effective GDP per person increases with respect to the value of the GDP per person in 1980, the smaller is the owner saving fraction. This relationship is depicted in the following figure.

<div align="center"><img src="https://github.com/worlddynamics/worlddynamicswiki/blob/main/imgs/graphics/OSFvsEGDPP.png" alt="Relationship between the owner saving fraction and the effective GDP per person" width="300" height="300"></div>

The owner consumption fraction is just equal to $1$ minus the owner saving fraction.

$$\mathtt{OCF}(t) = 1- \mathtt{OSF}(t)$$

The owner operating income after taxes is simply the owner income minus the owner taxes.

$$\mathtt{OOIAT}(t) = \mathtt{OI}(t)-\mathtt{OT}(t).$$

The owner cash inflow is equal to the owner operating income after taxes.

$$\mathtt{OCIN}(t) = \mathtt{OOIAT}(t).$$
The permanent owner cash inflow reaches the owner cash inflow within the time to adjust the owner consumption.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{POCI}(t) = \frac{\mathtt{OCIN}(t)-\mathtt{POCI}(t)}{\mathtt{TAOC}},$$
where $\mathtt{TAOC}=1$. Hence, the owner consumption is equal to the permanent owner cash inflow multiplied by the owner consumption fraction.

$$\mathtt{OC}(t) = \mathtt{POCI}(t)\cdot\mathtt{OCF}(t).$$
The owner savings are just equal to the permanent owner cash inflow minus the owner consumption.

$$\mathtt{OS}(t) = \mathtt{POCI}(t)-\mathtt{OC}(t).$$

### The worker consumption and saving equations

The worker income after taxes is simply the worker income minus the worker taxes plus the transfer payments.

$$\mathtt{WIAT}(t) = \mathtt{WI}(t)-\mathtt{WT}(t)+\mathtt{TP}(t).$$
The max debt of workers is a fraction of the worker income, determined by the maximum worker debt burden.

$$\mathtt{MWD}(t) = \mathtt{WI}(t)\cdot\mathtt{MWDB},$$
where $\mathtt{MWDB}=1$. The variation in the debt of workers is equal to the workers new debt minus the workers payback.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{WD}(t) = \mathtt{WND}(t)-\mathtt{WP}(t).$$
The above differential equation is accompanied by the following initialization value: $\mathtt{WD}(1980) = 18992\cdot\mathtt{MATGF}$ (which is equal to one year's income after tax, that is, $22140$, somewhat reduced to avoid initial transient). The contribution of the workers new debt is the difference between the maximum workers debt and the current workers debt divided by the workers drawdown period.

$$\mathtt{WND}(t) = \mathrm{max}\left(0,\frac{\mathtt{MWD}(t)-\mathtt{WD}(t))}{\mathtt{WDP}}\right),$$
where $\mathtt{WDP}=10$. On the the other hand, the workers payback is equal to the workers debt divided by the workers payback period.

$$\mathtt{WP}(t) = \frac{\mathtt{WD}(t)}{\mathtt{WPP}},$$
where $\mathtt{WPP}=20$. The workers debt burden is just the workers debt as share of the worker income after taxes.

$$\mathtt{WDB}(t) = \frac{\mathtt{WD}(t)}{\mathtt{WIAT}(t)}.$$

The workers interest cost is equal to the workers debt multiplied by the workers borrowing cost.

$$\mathtt{WIC}(t) = \mathtt{WD}(t)\cdot\mathtt{WBC}(t).$$

The cash flow from the workers to the banks is equal to the workers interest cost plus the workers payback minus the workers new debt.

$$\mathtt{CFWB}(t) = \mathtt{WIC}(t)+\mathtt{WP}(t)-\mathtt{WND}(t).$$

This value can be expressed as a share of the workers income after taxes, which defines the workers finance cost.

$$\mathtt{WFCSI}(t) = \frac{\mathtt{CFWB}(t)}{\mathtt{WIAT}(t)}.$$

The workers cash inflow is the workers income after taxes minus the cash flow from the workers to the banks.

$$\mathtt{WCIN}(t) = \mathtt{WIAT}(t)-\mathtt{CFWB}(t).$$
The cash inflow value is reached by the permanent worker cash inflow during the time to adjust the worker consumption.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{PWCIN}(t) = \frac{\mathtt{WCIN}(t)-\mathtt{PWCIN}(t)}{\mathtt{TAWC}},$$
where $\mathtt{TAWC}=1$. The worker disposable income is the permanent worker cash inflow divided by the workforce.

$$\mathtt{WDI}(t) = \frac{\mathtt{PWCIN}(t)}{\mathtt{WF}}.$$

The worker consumption demand is a specific fraction of the permanent worker cash inflow.

$$\mathtt{WCD}(t) = \mathtt{PWCIN}(t)\cdot\mathtt{WCF},$$
where $\mathtt{WCD}=0.9$. The workers savings is, hence, the permanent worker cash inflow minus the worker consumption demand.

$$\mathtt{WS}(t) = \mathtt{PWCIN}(t)-\mathtt{WCD}.$$

### The sales taxes equations

The sales taxes from workers is a specific fraction of the workers consumption demand.

$$\mathtt{STW}(t) = \mathtt{WCD}(t)\cdot\mathtt{STR},$$
where $\mathtt{STR}=0.03$. Similarly, the sales taxes from owners is a specific fraction of the owner consumption.

$$\mathtt{STO}(t) = \mathtt{OC}(t)\cdot\mathtt{STR}.$$
The total sales taxes are then equal to the sum of the worker and the owner sales taxes.

$$\mathtt{ST}(t) = \mathtt{STW}(t)+\mathtt{STO}(t).$$

### The total consumption, purchasing, and savings equation

The total purchasing power is equal to the sum of the worker cash inflow, the government cash inflow, and the owner cash inflow minus the total sales taxes.

$$\mathtt{TPP}(t) = \mathtt{WCIN}(t)+\mathtt{GCIN}(t)+\mathtt{OCIN}(t)-\mathtt{ST}(t).$$
The total savings is equal to the sum of the owner and the worker savings.

$$\mathtt{TS}(t) = \mathtt{OS}(t)+\mathtt{WS}(t).$$
This value can be expressed as a share of the national income.

$$\mathtt{SSGDP}(t) = \frac{\mathtt{TS}(t)}{\mathtt{NI}(t)}.$$

Finally, the total consumption demand is equal to the difference between the worker consumption demand and the worker sales taxes plus the difference between the owner consumption demand and the owner sales taxes.

$$\mathtt{CD}(t) = (\mathtt{WCD}(t)-\mathtt{STW}(t))+(\mathtt{OC}(t)-\mathtt{STO}(t)).$$
This value can be expressed as a share of the national income.

$$\mathtt{CSGDP}(t) = \frac{\mathtt{CD}(t)}{\mathtt{NI}(t)}.$$
And the same value can be computed per person.

$$\mathtt{CPP}(t) = \frac{\mathtt{CD}(t)}{\mathtt{POP}(t)}.$$

The system also includes a control variable which is the sum of the consumption share of GDP, the government share of GDP, and the savings share of GDP, and which should be always equal to $1$.

$$\mathtt{CONTR}(t) = \mathtt{CSGDP}(t)+\mathtt{GSGDP}(t))+\mathtt{GSGDP}(t)+\mathtt{SSGDP}(t).$$

### The bank cash inflow equations

The bank cash inflow from lending is equal to the sum of the cash flow from workers to banks and the cash flow from government to banks.

$$\mathtt{BCIL}(t) = \mathtt{CFWB}(t)+\mathtt{CFGB}(t).$$
This value can be espressed as a share of the national income.

$$\mathtt{BICISNI}(t) = \frac{\mathtt{BCIL}(t)}{\mathtt{NI}(t)}.$$

### The inequality index equations

The demand inequality is equal to the ratio between the owner operating income after taxes and the worker income after taxes.

$$\mathtt{INEQ}(t) = \frac{\mathtt{OOIAT}(t)}{\mathtt{WIAT}(t)}.$$
The demand inequality index is equal to the ratio betwwen the inequality and its value in 1980.

$$\mathtt{INEQI}(t) = \frac{\mathtt{INEQ}(t)}{\mathtt{INEQ1980}(t)},$$
where $\mathtt{INEQ1980}=0.61$.

## Endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| Bank cash inflow as share of NI | `BCISNI` |  |
| Bank cash inflow form lending GDollar/y | `BCIL` |  |
| Basic income tax rate owners | `BITRO` |  |
| Cancellation of debt GDollar/y | `CANCD` |  |
| Cash flow from government to banks GDollar/y | `CFGB` |  |
| Cash flow from workers to banks GDollar/y | `CFWB` |  |
| Consumption as share of GDP | `CSGDP` |  |
| Consumption demand GDollar/y | `CD` |  |
| Consumption per person GDollar/y | `CPP` |  |
| Control variable (C+G+S)/NI = 1 | `CONTR` |  |
| Extra general tax from 2022 | `EGTF2022` |  |
| Extra taxes for TAs from 2022 GDollar/y | `ETTAF2022` |  |
| Extra taxes from 2022 GDollar/y | `ETF2022` | 0.0 |
| Fraction of government budget to workers | `FGBW` | 0.3 |
| Goal for extra taxes from 2022 GDollar/y | `GETF2022` |  |
| Goal for fraction of government budget to workers | `GFGBW` |  |
| Governament net income as share of NI | `GNISNI` |  |
| Governament net income GDollar/y | `GNI` | 6531.07 |
| Government cash inflow GDollar/y | `GCIN` |  |
| Government debt burden y | `GDB` |  |
| Government debt GDollar | `GD` | 17975.7 |
| Government finance as share of NI | `GFSNI` |  |
| Government gross income (as share of NI) | `GGIS` |  |
| Government gross income GDollar/y | `GGI` |  |
| Government interest cost GDollar/y | `GIC` |  |
| Government investments in public capacity GDollar/y | `GIPC` |  |
| Government new debt GDollar/y | `GND` |  |
| Government payback GDollar/y | `GP` |  |
| Government purchases GDollar/y | `GPU` |  |
| Government share of GDP | `GSGDP` |  |
| Government spendings GDollar/y | `GS` |  |
| Income from commons in 2022 GDollar/y | `IC2022` |  |
| Income tax owners | `ITO` |  |
| Income tax workers | `ITW` |  |
| Inequality | `INEQ` |  |
| Inequality index (1980 = 1) | `INEQI` |  |
| Max government debt GDollar | `MGD` |  |
| Max workers debt GDollar | `MWD` |  |
| Owner cash inflow GDollar/y | `OCIN` |  |
| Owner consumption fraction | `OCF` |  |
| Owner consumption GDollar/y | `OC` |  |
| Owner income GDollar/y | `OI` |  |
| Owner operating income after taxes GDollar/y | `OOIAT` |  |
| Owner savings fraction | `OSF` |  |
| Owner savings GDollar/y | `OS` |  |
| Owner tax rate | `OTR` |  |
| Owner taxes GDollar/y | `OT` |  |
| Permanent government cash inflow GDollar/y | `PGCIN` | 5400.0 |
| Permanent owner cash inflow GDollar/y | `POCI` | 7081.0 |
| Permanent worker cash INflow GDollar/y | `PWCIN` | 13000.0 |
| Sales tax GDollar/y | `ST` |  |
| Sales tax owners GDollar/y | `STO` |  |
| Sales tax workers GDollar/y | `STW` |  |
| Savings share of GDP | `SSGDP` |  |
| Total purchasing power GDollar/y | `TPP` |  |
| Total savings GDollar/y | `TS` |  |
| Transfer payments GDollar/y | `TP` |  |
| Worker cash INflow GDollar/y | `WCIN` |  |
| Worker consumption demand GDollar/y | `WCD` |  |
| Worker debt burden y | `WDB` |  |
| Worker disposable income kDollar/p/y | `WDI` |  |
| Worker finance cost as share of income | `WFCSI` |  |
| Worker income after taxes GDollar/y | `WIAT` |  |
| Worker income GDollar/y | `WI` |  |
| Worker interest cost GDollar/y | `WIC` |  |
| Worker savings GDollar/y | `WS` |  |
| Worker tax rate | `WTR` |  |
| Worker taxes GDollar/y | `WT` |  |
| Workers debt GDollar | `WD` | 7406.88 |
| Workers debt in 1980 GDollar | `WD1980` |  |
| Workers new debt GDollar/y | `WND` |  |
| Workers payback GDollar/y | `WP` |  |

## Parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| Basic income tax rate workers | `BITRW` | 0.2 |
| Extra empowerment tax from 2022 (share of NI) | `EETF2022` | 0.02 |
| Extra general tax rate from 2022 | `EGTRF2022` | 0.01 |
| Extra pension tax from 2022 (share of NI) | `EPTF2022` | 0.02 |
| Extra transfer or government budget to workers | `ETGBW` | 0.2 |
| Fraction of extra TA cost paid by extra taxes | `FETACPET` | 0.5 |
| Fraction of extra TA paid by owners | `FETPO` | 0.8 |
| Fraction of government debt cancelled in 2022 1/y | `FGDC2022` | 0.1 |
| Fraction transferred in 1980 | `FT1980` | 0.3 |
| Goal for extra income from commons (share of NI) | `GEIC` | 0.02 |
| Goal for income tax rate owners | `GITRO` | 0.3 |
| Government consumption fraction | `GCF` | 0.75 |
| Government DrawDown period y | `GDDP` | 10.0 |
| Government Payback period y | `GPP` | 200.0 |
| Government stimulus from 2022 (share of NI) | `GSF2022` | 0.0 |
| Income tax rate owners in 1980 | `ITRO1980` | 0.4 |
| Income tax rate owners in 2022 | `ITRO2022` | 0.3 |
| Inequality in 1980 | `INEQ1980` | 0.61 |
| Max government debt burden y | `MGDB` | 1.0 |
| Max workers debt burden y | `MWDB` | 1.0 |
| Mult to avoid transient in worker finance | `MATWF` | 0.39 |
| Owner savings fraction in 1980 | `OSF1980` | 0.9 |
| Sales tax rate | `STR` | 0.03 |
| sGDPeoOSR<0 | `GDPOSR` | -0.06 |
| Time to adjust budget y | `TAB` | 1.0 |
| Time to adjust owner consumption y | `TAOC` | 1.0 |
| Time to adjust worker consumption y | `TAWC` | 1.0 |
| Time to implement new taxes y | `TINT` | 5.0 |
| Worker consumption fraction | `WCF` | 0.9 |
| Worker drawdown period y | `WDP` | 10.0 |
| Worker payback period y | `WPP` | 20.0 |

## Exogenous variables

| Vensim name | Name | Initial value |
| --- | --- | --- |
| Extra Cost of TAs From 2022 | `ECTAF2022` | Public |
| Effective GDP per Person kDollar/p/y | `EGDPP` | Population |
| Government Borrowing Cost 1/y | `GBC` | Finance |
| Introduction Period for Policy y | `IPP` | Wellbeing |
| National Income GDollar/y | `NI` | Inventory |
| POPulation Mp | `POP` | Population |
| Worker Borrowing Cost 1/y | `WBC` | Finance |
| Work Force Mp | `WF` | Labour and market |
| Worker Share Output  | `WSO` | Labour and market |