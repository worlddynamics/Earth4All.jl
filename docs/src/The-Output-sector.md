# Output 

## Summary
We describe the Output sector of the Earth4All model, by referring to the Output view of the Vensim model implementation.

## The Output sector equations

### The public sector equations

The off-balance-sheet government investment in the public sector (as a share of GDP) is a specific constant until 2022, and then is increased by another specific constant.

$$\mathtt{OBSGIPUS}(t)=0.01+I_{t>2022}\cdot\mathtt{USPUS2022},$$
where $\mathtt{USPUS2022}=0.01$.

The cost of capacity is proportional to its value in 1980.

$$\mathtt{COCA}(t)=\mathtt{CC1980}\cdot\mathtt{OWECC}(t),$$
where $\mathtt{CC1980}=1$,

$$\mathtt{OWECC}(t)=1+I_{t>2022}\cdot\mathtt{OWECCM}\cdot\left(\frac{\mathtt{OW}(t)}{\mathtt{OW2022}}-1\right),$$
$\mathtt{OWECCM}=0.2$, and $\mathtt{OW2022}=1.35$ (that is, the effect of the observed warming on the cost of capacity depends on how much the observed warming changes with respect to its value in 2022).

The capacity initiation in the public sector is the sum of the government investment in public capacity and the off-balance-sheet government investment in the public sector, divided by the cost of capacity.

$$\mathtt{CIPUS}(t)=\mathrm{max}\left(\frac{\mathtt{GIPC}(t)+\mathtt{OBSGIPUS}(t)\cdot\mathtt{GDP}(t)}{\mathtt{COCA}(t)}, 0\right).$$

The effect of the observed warming on the life of capacity depends on how much the observed warming changes with respect to its value in 2022.

$$\mathtt{OWELC}(t)=1+I_{t>2022}\cdot\mathtt{OWELCM}\cdot\left(\frac{\mathtt{OW}(t)}{\mathtt{OW2022}}-1\right),$$
where $\mathtt{OWELCM}=-0.1$. The life of capacity of the public sector in 1980 is just the above value multiplied by $15$.

$$\mathtt{LCPUS1980}(t)=15\cdot\mathtt{OWECC}(t).$$
Actually, this is also the value of the life of capacity of the public sector after 1980.

$$\mathtt{LCPUS}(t)=\mathtt{LCPUS1980}(t).$$

The capacity under construction of the public sector in 1980 is equal to the capacity of the public sector in 1980 divided by the above value, and then multiplied by the construction time in the public sector and by an extra multiplier of the capacity under construction (in order to avoid initial transient in investment share of GDP).

$$\mathtt{CUCPUS1980}(t)=\frac{\mathtt{CAPPUS1980}}{\mathtt{LCPUS1980}(t)}\cdot\mathtt{CTPUS}\cdot\mathtt{EMCUC},$$
where $\mathtt{EMCUC}=1.7$, $\mathtt{CAPPUS1980}=5350$, and $\mathtt{CTPUS}=1.5$. The variation in the capacity under construction of the public sector is equal to the difference between the capacity initiation in the public sector and the capacity addition in the public sector.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{CUCPUS}(t)=\mathtt{CIPUS}(t)-\mathtt{CAPUS}(t),$$
where the capacity addition is equal to the ratio between the capacity under construction of the public sector and the construction time in the public sector, that is,

$$\mathtt{CAPUS}(t)=\frac{\mathtt{CUCPUS}(t)}{\mathtt{CTPUS}}.$$
The above differential equation is accompanied by the following initialization equation: $\mathtt{CUCPUS}(1980)=909.5$. The variation of the capacity of the public sector is equal to the difference between  the capacity addition of the public sector and the capacity discard of the public sector.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{CPUS}(t)=\mathtt{CAPUS}(t)-\mathtt{CDPUS}(t),$$
where the capacity discard is equal to the ratio between the capacity of the public sector and the life of capacity of the public sector, that is,

$$\mathtt{CDPUS}(t)=\frac{\mathtt{CPUS}(t)}{\mathtt{LCPUS}(t)}.$$
The above differential equation is accompanied by the following initialization equation: $\mathtt{CPUS}(1980)=\mathtt{CAPPUS1980}$.

### The private sector equations

The available capital is equal to the total savings plus the foreign capital inflow.

$$\mathtt{AVCA}(t)=\mathtt{TS}(t)+\mathtt{FCI},$$
where $\mathtt{FCI}=0$. The investment of new capacity of the private sector is equal to a fraction of the above value.

$$\mathtt{INCPIS}(t)=\mathtt{AVCA}(t)\cdot\mathtt{FACNC}(t).$$

The off-balance-sheet government investment in the private sector (as a share of GDP) is zero until 2022, and then is equal to a specific constant.

$$\mathtt{OBSGIPIS}(t)=I_{t>2022}\cdot\mathtt{USPIS2022},$$
where $\mathtt{USPIS2022}=0.01$.

The capacity initiation in the private sector is the sum of the investment of new capacity of the private sector and the off-balance-sheet government investment in the private sector, divided by the cost of capacity.

$$\mathtt{CIPIS}(t)=\mathrm{max}\left(\frac{\mathtt{INCPIS}(t)+\mathtt{OBSGIPIS}(t)\cdot\mathtt{GDP}(t)}{\mathtt{COCA}(t)}, 0\right).$$

The capacity under construction of the private sector in 1980 is equal to the capacity of the public sector in 1980 divided by the life of capacity of the private sector, and then multiplied by the construction time in the private sector and by the extra multiplier of the capacity under construction (in order to avoid initial transient in investment share of GDP).

$$\mathtt{CUCPIS1980}(t)=\frac{\mathtt{CAPPIS1980}}{\mathtt{LCPIS1980}}\cdot\mathtt{CTPIS}\cdot\mathtt{EMCUC},$$
where $\mathtt{LCPIS1980}=15$, $\mathtt{CAPPIS1980}=59250$, and $\mathtt{CTPIS}=1.5$. The variation in the capacity under construction of the private sector is equal to the difference between the capacity initiation in the private sector and the capacity addition in the private sector.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{CUCPIS}(t)=\mathtt{CIPIS}(t)-\mathtt{CAPIS}(t),$$
where the capacity addition is equal to the ratio between the capacity under construction of the private sector and the construction time in the private sector, that is,

$$\mathtt{CAPIS}(t)=\frac{\mathtt{CUCPIS}(t)}{\mathtt{CTPIS}}.$$
The above differential equation is accompanied by the following initialization equation: $\mathtt{CUCPIS}(1980)=10072.5$. The variation of the capacity of the private sector is equal to the difference between  the capacity addition of the private sector and the capacity discard of the private sector.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{CPIS}(t)=\mathtt{CAPIS}(t)-\mathtt{CDPIS}(t),$$
where the capacity discard is equal to the ratio between the capacity of the private sector and the life of capacity of the private sector, that is,

$$\mathtt{CDPIS}(t)=\frac{\mathtt{CPIS}(t)}{\mathtt{LCPIS}(t)}.$$
The above differential equation is accompanied by the following initialization equation: $\mathtt{CPIS}(1980)=\mathtt{CAPPIS1980}$.

### The embedded total factor productivity equations

The capacity renewal rate (of the private sector) is equal to the capacity addition of the private sector divided by the capacity of the private sector.

$$\mathtt{CRR}(t)=\frac{\mathtt{CAPIS}(t)}{\mathtt{CPIS}(t)}.$$

The variation of the embedded total factor productivity is equal to the effect of the capacity renewal.

$$\frac{\mathrm{d}}{\mathrm{d}t}\mathtt{ETFP}(t)=\mathtt{ECR}(t),$$
where the effect of the capacity renewal is equal to the difference between the indicated total factor productivity and the embedded total factor productivity multiplied by the capacity renewal rate, that is,

$$\mathtt{ECR}(t)=(\mathtt{ITFP}(t)-\mathtt{ETFP}(t))\cdot\mathtt{CRR}(t)$$
(in other words, the embedded total factor productivity gradually reaches the indicated total factor productivity according to the capacity renewal rate). The above differential equation is accompanied by the following initialization equation: $\mathtt{ETFP}(1980)=1$.

## The Output sector endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| AVailable CApital Gdollar/y | `AVCA` |  |
| Capacity Addition PIS Gcu/y | `CAPIS` |  |
| Capacity Addition PUS Gcu/y | `CAPUS` |  |
| Capacity Discard PIS Gcu/y | `CDPIS` |  |
| Capacity Discard PUS Gcu/y | `CDPUS` |  |
| CAPacity Gcu | `CAP` |  |
| Capacity Initiation PIS Gcu/y | `CIPIS` |  |
| Capacity Initiation PUS Gcu/y | `CIPUS` |  |
| Capacity PIS Gcu | `CPIS` | 59250.0 |
| Capacity PUS Gcu | `CPUS` | 5350.0 |
| Capacity Renewal Rate 1/y | `CRR` |  |
| Capacity Under Construction PIS Gcu | `CUCPIS` | 10072.5 |
| Capacity Under Construction PUS Gcu | `CUCPUS` | 909.5 |
| CBC Effect on Flow to Capacity Addion | `CBCEFCA` |  |
| COst of CApacity dollar/cu | `COCA` |  |
| ED Effect on Flow to Capacity Addition | `EDEFCA` |  |
| Effect of Capacity Renewal 1/y | `ECR` |  |
| Embedded TFP | `ETFP` | 1.0 |
| Excess DEmand | `EDE` |  |
| Excess Demand Effect on Life of Capacity | `EDELC` |  |
| FRACA Mult from GDPpP - Line | `FRACAMGDPPL` |  |
| FRACA Mult from GDPpP - Table | `FRACAMGDPPT` |  |
| Fraction of Available Capital to New Capacity | `FACNC` | 1.0515 |
| Investment in New Capacity PIS Gdollar/y | `INCPIS` |  |
| Investment Share of GDP | `ISGDP` |  |
| Life of Capacity PIS y | `LCPIS` |  |
| Life of Capacity PUS in 1980 y | `LCPUS1980` |  |
| Life of Capacity PUS y | `LCPUS` |  |
| Observed Warming Effect on Life of Capacity | `OWELC` |  |
| Off-Balance Sheet Govmnt Inv in PIS (share of GDP) | `OBSGIPIS` |  |
| Off-Balance Sheet Govmnt Inv in PUS (share of GDP) | `OBSGIPUS` |  |
| Optimal Ouput - Value Gdollar/y | `OOV` |  |
| Optimal Real Output Gu/y | `ORO` |  |
| Output Growth Rate 1/y | `OGR` | 0.06 |
| Output Last Year Gdollar/y | `OLY` | 26497.1288 |
| OWeoCOC: Observed Warming Effect on Cost of Capacity | `OWECC` |  |
| Perceived Excess DEmand | `PEDE` | 1.0 |
| WSO Effect on Flow to Capacity Addition | `WSOEFCA` |  |

## The Output sector parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| CAP PIS in 1980 Gcu | `CAPPIS1980` | 59250.0 |
| CAP PUS in 1980 Gcu | `CAPPUS1980` | 5350.0 |
| Construction Time PIS y | `CTPIS` | 1.5 |
| Construction Time PUS y | `CTPUS` | 1.5 |
| Cost of Capacity in 1980 dollar/cu | `CC1980` | 1.0 |
| Excess Demand in 1980 | `ED1980` | 1.0 |
| Foreign Capital Inflow Gdollar/y | `FCI` | 0.0 |
| FRA in 1980 | `FRA1980` | 0.9 |
| FRACA Min | `FRACAM` | 0.65 |
| GDP per Person in 1980 | `GDPP1980` | -0.2 |
| Investment Planning Time y | `IPT` | 1.0 |
| Kappa | `KAPPA` | 0.3 |
| Labour Use in 1980 Gph/y | `LAUS1980` | 3060.0 |
| Lambda | `LAMBDA` | 0.7 |
| Life of Capacity PIS in 1980 y | `LCPIS1980` | 15.0 |
| OBserved WArming in 2022 deg C | `OBWA2022` | 1.35 |
| Optimal output in 1980 Gu/y | `OO1980` | 28086.9565 |
| Price per Unit dollar/u | `PRUN` | 1.0 |
| sCBCeoFRA<0: Corporate Borrowing Cost Effect on FRA | `CBCEFRA` | -0.8 |
| sEDeoFRA>0: Excess Demand Effect on FRA | `EDEFRA` | 5.0 |
| sEDeoLOC>0: Excess Demand Effect on Life of Capacity | `EDELCM` | 0.5 |
| sGDPppeoFRACA<0: GDP per Person Effect on FRACA | `GDPPEFRACA` | -0.2 |
| sOWeoCOC>0: Observed Warming Effect on Cost of Capacity | `OWECCM` | 0.2 |
| sOWeoLOC<0: Observed Warming Effect on Life of Capacity | `OWELCM` | -0.1 |
| sWSOeoFRA<0: Worker Share of Output Effect on FRA | `WSOEFRA` | -2.5 |
| Time to observe excess demand y | `TOED` | 1.0 |
| Unconventional Stimulus in PIS from 2022 (share of GDP) | `USPIS2022` | 0.01 |
| Unconventional Stimulus in PUS from 2022 (share of GDP) | `USPUS2022` | 0.01 |

## The Output sector exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| Corporate Borrowing Cost 1/y | `CBC` | Finance |
| Corporate Borrowing Cost in 1980 1/y | `CBC1980` | Finance |
| GDP GDollar/y | `GDP` | Inventory |
| GDP per Person kdollar/p/y | `GDPP` | Population |
| Govmnt Investment in Public Capacity Gdollar/y | `GIPC` | Demand |
| Indicated TFP | `ITFP` | Public |
| LAbour USe Gph/y | `LAUS` | Labour and market |
| OBserved WArming deg C | `OBWA` | Climate |
| TOtal SAvings Gdollar/y | `TOSA` | Demand |
| Total Purchasing Power Gdollar/y | `TPP` | Demand |
| WAge SHare | `WASH` | Labour and market |