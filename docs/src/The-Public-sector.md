# Public 
## Summary
We describe the Public sector of the Earth4All model, by referring to the Public sector view of the Vensim model implementation.

## Equations

### The rate of technological advance equations

The government spending can be expressed as a share of the GDP.

$$\mathtt{GSSGDP}(t) = \frac{\mathtt{GS}(t)}{\mathtt{GDP}(t)}.$$
The government spending can also be expressed as the spending per person.

$$\mathtt{PSP}(t) = \frac{\mathtt{GS}(t)}{\mathtt{POP}(t)}.$$
The infrastructure purchase ratio is the ratio between the capacity of the public sector and the government purchases.

$$\mathtt{IPR}(t) = \frac{\mathtt{CPUS}(t)}{\mathtt{GP}(t)}.$$
The productivity of the public purchases depends on the logarithm of how much the above infrastructure purchase ratio increased with respect to its value in 1980.
 
$$\mathtt{PPP}(t) = \mathrm{max}\left(0,1+\mathtt{IPRVPSS}\cdot\mathrm{ln}\left(\frac{\mathtt{IPR}(t)}{\mathtt{IPR1980}}\right)\right),$$
where $\mathtt{IPRVPSS}=1$ and $\mathtt{IPR1980}=1.2$. The value of the supplied public services is then equal to the product of the above value times the government purchases.

$$\mathtt{VPSS}(t) = \mathtt{GP}(t)\cdot\mathtt{PPP}(t).$$
This value can be expressed as the value per person.

$$\mathtt{PSEP}(t) = \frac{\mathtt{VPSS}(t)}{\mathtt{POP}(t)}.$$
The state capacity, instead, is the value of the supplied public services expressed as a share of the GDP.

$$\mathtt{SC}(t) = \frac{\mathtt{VPSS}(t)}{\mathtt{GDP}(t)}.$$

The domestic rate of technological advance is equal to its value in 1980 plus the extra domestic rate of technological advance from 2022 multiplied by a factor depending on how much the state capacity increased with respect to its value in 1980.

$$\mathtt{DRTA}(t) = \mathtt{DROTA1980}+I_{t\geq2022}(t)\cdot\mathtt{EDROTA2022}\cdot\left(1+\mathtt{IPRVPSS}\cdot\left(\frac{\mathtt{SC}(t)}{\mathtt{SC1980}}-1\right)\right),$$
where $\mathtt{DROTA1980}=0.01$, $\mathtt{EDROTA2022}=0.003$, and $\mathtt{SC1980}=0.3$.

The imported rate of technological advance is equal, from 2022, to the maximum imported rate of technological advance from 2022 times one minus how much the GDP per person is different from the GDP per person of a technological leader.

$$\mathtt{IROTA}(t) = I_{t\geq2022}(t)\cdot\left(\mathtt{MIROTA2022}\cdot\left(1-1\cdot\left(\frac{\mathtt{GDPP}(t)}{\mathtt{GDPTL}}-1\right)\right)\right),$$
where $\mathtt{MIROTA2022}=0.005$ and $\mathtt{GDPTL}=15$.

### The total factor productivity equations

The extra cost of the turnarounds from 2022 is equal to the cost of the turnarounds minus the cost of the turnarounds in 2022.

$$\mathtt{ECTAF2022}(t) = \mathrm{max}(0,\mathtt{CTA}(t)-\mathtt{CTA2022}),$$
where $\mathtt{CTA2022}=9145$. This value can be expressed as a share of the GDP.

$$\mathtt{ECTAGDP}(t) = \frac{\mathtt{ECTAF2022}(t)}{\mathtt{GDP}(t)}.$$
The productivity loss from unprofitable activity is a fraction of the above value.

$$\mathtt{PLUA}(t) = \mathtt{ECTAGDP}(t)\cdot\mathtt{FUATA},$$
where $\mathtt{FUATA}=0.3$. The reduction in the total factor productivity from unprofitable activity reaches this productivity loss gradually during a period depending on the investment planning and construction time.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{RTFPUA}(t) = \frac{\mathtt{PLUA}(t)-\mathtt{RTFPUA}(t)}{\mathtt{IPT}+\mathtt{CTPIS}},$$
where where $\mathtt{IPT}=1$ and $\mathtt{CTPIS}=1.5$. This differential equation is accompanied by the follwoing initialization equation: $\mathtt{RTFPUA}(1980)=0$ (since the turnarounds take place from 2022).



## Endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| Change in TFP 1/y | `CTFP` |  |
| Domestic Rate of Technological Advance 1/y | `DRTA` |  |
| Extra Cost of TAs as share of GDP | `ECTAGDP` |  |
| Extra Cost of TAs From 2022 GDollar/y | `ECTAF2022` |  |
| Government Spending as Share of GDP | `GSSGDP` |  |
| Imported ROTA 1/y | `IROTA` |  |
| Indicated TFP | `ITFP` |  |
| Infrastructure Purchases Ratio y | `IPR` |  |
| OWeoTFP | `OWTFP` |  |
| Productivity Loss from Unprofitable Activity | `PLUA` |  |
| Productivity of Public Purchases | `PPP` |  |
| Public SErvices per Person kdollar/p/k | `PSEP` |  |
| Public Spending per Person kDollar/p/k | `PSP` |  |
| Rate of Technological Advance 1/y | `RTA` |  |
| Reduction in ROTA from Inequality 1/y | `RROTAI` |  |
| Reduction in TFP from Unprofitable Activity | `RTFPUA` | 0.0 |
| State Capacity (fraction of GDP) | `SC` |  |
| TFP Excluding Effect of 5TAs | `TFPEE5TA` | 1.0 |
| TFP Including Effect of 5TAs | `TFPIE5TA` |  |
| Value of Public Services Supplied GDollar/y | `VPSS` |  |
| XExtra Cost of TAs as share of GDP | `XECTAGDP` |  |

## Parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| Cost of TAs in 2022 GDollar/y | `CTA2022` | 9145.0 |
| Domestic ROTA in 1980 1/y | `DROTA1980` | 0.01 |
| Extra Domestic ROTA in 2022 1/y | `EDROTA2022` | 0.003 |
| Fraction Unprofitable Activity in TAs | `FUATA` | 0.3 |
| GDPpp of Technology Leader kDollar/p/k | `GDPTL` | 15.0 |
| Infrastructure Purchases Ratio in 1980 y | `IPR1980` | 1.2 |
| Maximum Imported ROTA from 2022 1/y | `MIROTA2022` | 0.005 |
| sIIEeoROTA<0: Inequality Index Effect on ROTA | `IIEEROTA` | -0.1 |
| sIPReoVPSS>0: Infrastructure Purchase Ratio effect on Value of Pubblic Services Supplied | `IPRVPSS` | 1.0 |
| sOWeoTFP<0: Observed Warming Effect on Total Factor Productivity | `OWETFP` | -0.1 |
| sSCeoROTA>0: State Capacity effect on Rate Of Technological Advance | `SCROTA` | 0.5 |
| State Capacity in 1980 (fraction of GDP) | `SC1980` | 0.3 |
| XExtra TA Cost in 2022 (share of GDP) | `XETAC2022` | 0.0 |
| XExtra TA Cost in 2100 (share of GDP) | `XETAC2100` | 0.0 |

## Exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| Capacity PUS Geu | `CPUS` | Output |
| Cost of TAs Gdollar/y | `CTA` | Other performance indicators |
| GDP Gdollar/y | `GDP` | Inventory |
| GDP per Person kDollar/p/k | `GDPP` | Population |
| Government Purchases Gdollar/y | `GP` | Demand |
| Government Spending Gdollar/y | `GS` | Demand |
| INEQuality Index | `INEQI` | Demand |
| OBserved WArming deg C | `OBWA` | Climate |
| POPulation Mp | `POP` | Population |
