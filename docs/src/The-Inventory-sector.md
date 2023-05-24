### Summary
We describe the Inventory sector of the Earth4All model, by referring to the Inventory view of the Vensim model implementation.

### The Inventory equations

#### The pink noise in sales equation

The pink noise in sales is defined as a normal distribution with mean equal to $1$ and standard deviation equal to $0$.

$$\mathtt{PNIS}(t)=1.$$

#### The effective purchasing power equations

The effective purchasing power gradually reaches the total purchasing power during the period to adjust the demand.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{EPP}(t)=\frac{\mathtt{TPP}(t)-\mathtt{EPP}(t)}{\mathtt{DAT}},$$
where $\mathtt{DAT}=1.2$. The above differential equation is accompanied by the following initialization equation: $\mathtt{EPP}(1980)=28087$ (this value is computed as the optimal output in 1980 multiplied the price per unit and the shift worked index in 1980). Note that this formulation is different from the Vensim formulation, in which the effective purchasing power is the value of the smooth function with input $\mathtt{TPP}(t)$ and $\mathtt{DAT}$ (which corresponds to the above differential equation) *multiplied by* $1+\mathtt{DEPU}(t)$, where

$$\mathtt{DEPU}(t)=I_{t\geq2020}(t)\cdot I_{t<2025}(t)\cdot\mathtt{PH}$$
and $\mathtt{PH}=0$. Since $\mathtt{PH}=0$, the two formulations are equivalent. However, it is interesting to see how the Vensim formulation can be, in general, written in the `WorldDynamics.jl` framework.

#### The inventory and GDP equations

The variation of the inventory is equal to the output minus the delivery.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{INV}(t)=\mathtt{OUTP}(t)-\mathtt{DEL}(t).$$
This differential equation is accompanied by the following initialization equation: $\mathtt{INV}(1980)=11234.8$ (this value is computed as the optimal output in 1980 multiplied by the shift worked index in 1980 and the desired inventory coverage). The output is equal to the optimal real output multiplied by the ratio between the shifts worked index and its value in 1980.

$$\mathtt{OUTP}(t)=\mathtt{ORO}(t)-\frac{\mathtt{SWI}(t)}{\mathtt{SWI1980}},$$
where $\mathtt{SWI1980}=1$. The GDP is equal to the above value multiplied by the price per unit.

$$\mathtt{GDP}(t)=\mathtt{OUTP}(t)\cdot\mathtt{PPU},$$
where $\mathtt{PPU}=1$.

#### The delivery and national income equations

The deliveries are equal to the ratio between the effective purchasing power and the price per unit divided by the ratio between the delay delivery index and its value in 1980 and multiplied by the pink noise in sales from 1984.

$$\mathtt{DEL}(t)=\frac{\frac{\mathtt{EPP}(t)}{\mathtt{PPU}}}{\frac{\mathtt{DELDI}(t)}{\mathtt{DDI1980}}}\cdot I_{t>1984}\cdot\mathtt{PNIS}(t),$$
where $\mathtt{DDI1980}=1$. The sales are equal to the product between the deliveries and the price per unit.

$$\mathtt{SA}(t)=\mathtt{DEL}(t)\cdot\mathtt{PPU}.$$
The national income is equal to the sales.

$$\mathtt{NI}(t)=\mathtt{SA}(t).$$

The variation of the delay delivery index is equal to its change.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{DELDI}(t)=\mathtt{CDDI}(t).$$
This differential equation is accompanied by the following initialization equation: $\mathtt{DELDI}(1980)=1$. The change of the delay delivery index is equal to its rate of change multiplied by its value.

$$\mathtt{CDDI}(t)=\mathtt{ROCDDI}(t)\cdot\mathtt{DELDI}.$$

#### The price and shifts worked index equations

The recent sales gradually reach the deliveries during the sales averaging time.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{RS}(t)=\frac{\mathtt{DEL}(t)-\mathtt{RS}(t)}{\mathtt{SAT}},$$
where $\mathtt{SAT}=1$. The inventory coverage is the ratio between the inventory and the recent sales.

$$\mathtt{IC}(t)=\frac{\mathtt{INV}(t)}{\mathtt{RS}(t)}.$$
The perceived relative inventory gradually reaches the ratio between the inventory coverage and the desired inventory coverage during the time to perceive the inventory coverage.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{PRI}(t)=\frac{\frac{\mathtt{IC}(t)}{\mathtt{DIC}}-\mathtt{PRI}(t)}{\mathtt{ICPT}},$$
where $\mathtt{DIC}=4$ and $\mathtt{ICPT}=0.25$. The rate of change of the delay delivery index depends on how much the perceived relative inventory changes with respect to the sufficient relative inventory.

$$\mathtt{ROCDDI}(t)=0+\mathtt{INVEODDI}\cdot\left(\frac{\mathtt{PRI}(t)}{\mathtt{SRI}}-1\right),$$
where $\mathtt{INVEODDI}=-0.6$ and $\mathtt{SRI}=1$.

The inflation rate, instead, depends on how much the perceived relative inventory changes with respect to the minimum relative inventory without inflation.

$$\mathtt{IR}(t)=\mathtt{INVEOIN}\cdot\left(\frac{\mathtt{PRI}(t)}{\mathtt{MRIWI}}-1\right),$$
where $\mathtt{INVEOIN}=-0.26$ and $\mathtt{MRIWI}=1.07$.

The desired shifts worked index depends on how much the perceived relative inventory changes with respect to the desired relative inventory.

$$\mathtt{DSWI}(t)=1+\mathtt{INVEOSWI}\cdot\left(\frac{\mathtt{PRI}(t)}{\mathtt{DRI}}-1\right),$$
where $\mathtt{INVEOSWI}=-0.6$ and $\mathtt{DRI}=1$. The shifts worked index gradually reaches this value during the time to adjust the shifts.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{SSWI}(t)=\frac{\mathtt{DSWI}(t)-\mathtt{SSWI}(t)}{\mathtt{TAS}},$$
where $\mathtt{TAS}=0.24$. This differential equation is accompanied by the following initialization equation: $\mathtt{SSWI}(1980)=\mathtt{DSWI}(1980)=1$.

The variation of the price index is equal to its change.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{PRIN}(t)=\mathtt{CPI}(t).$$
This differential equation is accompanied by the following initialization equation: $\mathtt{PRIN}(1980)=1$. The change of the price index is equal to its value multiplied by teh inflation rate. 

$$\mathtt{CPI}(t)=\mathtt{PRIN}(t)\cdot\mathtt{IR}(t).$$

### The Inventory sector endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim). Note that the `PNIS` variable is set equal to 1, since in the original model the standard deviation of the noise is 0.

| Vensim name | Name | Initial value |
| --- | --- | --- |
| Change in DDI | `CDDI` |  |
| Change in Price Index 1/y | `CPI` |  |
| DELiveries Delay - Index | `DELDI` | 1.0 |
| DELiveries Gu/y | `DEL` |  |
| Desired Shifts Worked - Index (1) | `DSWI` |  |
| Effective Purchasing Power G/y | `EPP` | 28087.0 |
| GDP G/y | `GDP` |  |
| Inflation Rate 1/y | `IR` |  |
| Inventory Coverage y | `IC` |  |
| INVentory Gu | `INV` | 11234.8 |
| National Income G/y | `NI` |  |
| Output Gu/y | `OG` |  |
| Perceived Relative Inventory | `PRI` | 1.0 |
| Pink Noise In Sales | `PNIS` |  |
| Price Index in 1980 (=1) | `PI` | 1.0 |
| Recent Sales Gu/y | `RS` | 28087.0 |
| ROC in DDI 1/y | `ROC` |  |
| SAles G/y | `SA` |  |
| ShiftS Worked - Index | `SSWI` | 1.0 |

### The Inventory sector parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| DDI in 1980 y | `DDI` | 1.0 |
| Demand Adjustment Time y | `DAT` | 1.2 |
| Desired Inventory Coverage y | `DIC` | 0.4 |
| Desired Relative Inventory | `DRI` | 1.0 |
| Inventory Coverage Perception Time y | `ICPT` | 0.25 |
| Minimum Relative Inventory Without Inflation | `MRIWI` | 1.07 |
| Price Per Unit /u | `PPU` | 1.0 |
| Sales Averaging Time y | `SAT` | 1.0 |
| sINVeoDDI < 0: INVentory Effect On Delivery Delay Index | `INVEODDI` | -0.6 |
| sINVeoIN < 0: INVentory Effect On INflation | `INVEOIN` | -0.26 |
| sINVeoSWI < 0: INVentory Effect On Shifts Worked Index | `INVEOSWI` | -0.6 |
| Sufficient Relative Inventory | `SRI` | 1.0 |
| SWI in 1980 | `SWI` | 1.0 |
| Time to Adjust Shifts y | `TAS` | 0.24 |

### The Inventory sector exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| Optimal Real Output Gu/y | `ORO` | Output |
| Total Purchasing Power G/y | `TPP` | Demand |
