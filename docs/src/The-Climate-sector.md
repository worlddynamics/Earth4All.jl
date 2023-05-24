### Summary
We describe the Climate sector of the Earth4All model, by referring to the Climate view of the Vensim model implementation.

### The Climate sector endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| ALbedo | `AL` |  |
| ALbedo in 1980 | `AL1980` |  |
| CH4 BreakDown GtCH4/y | `CH4BD` |  |
| CH4 conc in 1980 ppm | `CH4C1980` |  |
| CH4 concentration in atm ppm | `CH4CA` |  |
| CH4 emissions GtCH4/y | `CH4E` |  |
| CH4 forcing per ppm W/m2/ppm | `CH4FPP` |  |
| CH4 in Atmosphere GtCH4 | `CH4A` | 2.5 |
| CO2 absorption GtCO2/y | `CO2AB` |  |
| CO2 concentration in atm ppm | `CO2CA` |  |
| CO2 emissions GtCO2/y | `CO2E` |  |
| CO2 forcing per ppm W/m2/ppm | `CO2FPP` |  |
| CO2 from CH4 GtCO2/y | `CO2FCH4` |  |
| CO2 in Atmosphere GtCO2 | `CO2A` | 2600.0 |
| CO2 per GDP (kgCO2/Dollar) | `CO2GDP` |  |
| Cost of air capture GDollar/y | `CAC` |  |
| Direct Air Capture of CO2 GtCO2/y | `DACCO2` |  |
| Extra cooling from ice melt ZJ/y | `ECIM` |  |
| Extra heat in surface ZJ | `EHS` | 0.0 |
| Extra Warming from forcing ZJ/y | `EWFF` |  |
| Forcing from CH4  W/m2 | `FCH4` |  |
| Forcing from CO2  W/m2 | `FCO2` |  |
| Forcing from N2O  W/m2 | `FN2O` |  |
| Forcing from other gases  W/m2 | `FOG` |  |
| GHG emissions GtCO2e/y | `GHGE` |  |
| Heat to deep ocean ZJ/y | `HDO` |  |
| Heat to space ZJ/y | `HTS` |  |
| Ice and snow cover excluding Greenland and Antarctica Mkm2 | `ISCEGA` | 12.0 |
| Ice and snow cover Mha | `ISC` |  |
| kg CH4 emission per kg crop | `KCH4EKC` |  |
| kg N2O emission per kg fertilizer | `KN2OEKF` |  |
| Life of extra CO2 in atmosphere y | `LECO2A` |  |
| Man-made CH4 emissions GtCH4/y | `MMCH4E` |  |
| Man-made Forcing  W/m2 | `MMF` |  |
| Man-made N2O emissions GtN2O/y | `MMN2OE` |  |
| Melting Mha/y | `MEL` |  |
| Melting rate deep ice 1/y | `MRDI` |  |
| Melting rate surface 1/y | `MRS` |  |
| N2O BreakDown GtN2O/y | `N2OBD` |  |
| N2O conc in 1980 ppm | `N2OC1980` |  |
| N2O concentration in atm ppm | `N2OCA` |  |
| N2O emissions GtN2O/y | `N2OE` |  |
| N2O forcing per ppm W/m2/ppm | `N2OFPP` |  |
| N2O in Atmosphere GtN2O | `N2OA` | 1.052 |
| Natural CH4 emissions GtCH4/y | `NCH4E` |  |
| Natural N2O emissions GtN2O/y | `NN2OE` |  |
| OBserved WArming deg C | `OBWA` |  |
| OWeoLoCO2 | `OWLCO2` |  |
| Perceived warming deg C | `PWA` | 0.4 |
| Risk of extreme heat event | `REHE` |  |
| Total man-made forcing W/m2 | `TMMF` |  |
| Transfer rate for heat going to abyss 1/y | `TRHGA` |  |
| Transfer rate for heat going to space 1/y | `TRHGS` |  |
| Water Vapour Concentration g/kg | `WVC` |  |
| Water Vapour Feedback W/m2 | `WVF` |  |

### The Climate sector parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| ALbedo global average | `ALGAV` | 0.3 |
| ALbedo Ice and snow | `ALIS` | 0.7 |
| Amount of ice in 1980 MKm3 | `AI1980` | 55.0 |
| CH4 in atm in 1980 GtCH4 | `CH4A1980` | 2.5 |
| CO2 in atmosphere in 1850 GtCO2 | `CO2A1850` | 2200.0 |
| Direct Air Capture of CO2 in 2100 GtCO2/y | `DACCO22100` | 8.0 |
| Extra Heat in 1980 ZJ | `EH1980` | 0.0 |
| Extra rate of decline in CH4 per kg crop after 2022 1/y | `ERDCH4KC2022` | 0.01 |
| Extra rate of decline in N2O per kg fertilizer from 2022 | `ERDN2OKF2022` | 0.01 |
| GLobal SUrface Mkm2 | `GLSU` | 510.0 |
| GtCH4 per ppm | `GCH4PP` | 5.0 |
| GtCO2 per ppm | `GCO2PP` | 7.9 |
| GtN2O per ppm | `GN2OPP` | 5.0 |
| Heat required to melt ice kJ/kg | `HRMI` | 333.0 |
| Ice and snow cover excluding Greenland and Antarctica in 1980 Mkm2 | `ISCEGA1980` | 12.0 |
| kg CH4 per kg crop in 1980 | `KCH4KC1980` | 0.05 |
| kg N2O per kg fertilizer in 1980  | `KN2OKF1980` | 0.11 |
| Life of CH4 in atmosphere y | `LCH4A` | 7.5 |
| Life of extra CO2 in atmosphere in 1980 y | `LECO2A1980` | 60.0 |
| Life of N2O in atmosphere y | `LN2OA` | 95.0 |
| Mass of ATmosphere Zt | `MAT` | 5.0 |
| Melting rate surface in 1980 1/y | `MRS1980` | 0.0015 |
| N2O in atm in 1980 GtN2O | `N2OA1980` | 1.052 |
| OBserved WArming in 2022 deg C | `OBWA2022` | 1.35 |
| Perception delay y | `PD` | 5.0 |
| Rate of decline in CH4 per kg crop 1/y | `RDCH4KC` | 0.01 |
| Rate of decline in N2O per kg fertilizer 1/y | `RDN2OKF` | 0.01 |
| sOWeoLoCO2>0 | `SOWLCO2` | 1.0 |
| sOWeoWV>0 | `OWWV` | 0.18 |
| Surface vs deep rate | `SVDR` | 4.0 |
| sWVeoWVF>0 | `WVWVF` | 3.0 |
| tCO2 per tCH4 | `TCO2PTCH4` | 2.75 |
| tCO2e/tCH4 | `TCO2ETCH4` | 23.0 |
| tCO2e/tCO2 | `TCO2ETCO2` | 1.0 |
| tCO2e/tN2O | `TCO2ETN2O` | 7.0 |
| Ton per m3 ice | `TPM3I` | 0.95 |
| Transfer rate surface-abyss in 1980 1/y | `TRSA1980` | 0.01 |
| Transfer rate surface-space in 1980 1/y | `TRSS1980` | 0.01 |
| Warming from Extra Heat deg/ZJ | `WFEH` | 0.0006 |
| Warming in 1980 deg C | `WA1980` | 0.4 |
| Water Vapour Concentration in 1980 g/kg | `WVC1980` | 2.0 |
| Water Vapour Feedback in 1980 W/m2 | `WVF1980` | 0.9 |

### The Climate sector exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| CO2 from Energy and Industry GtCO2/y | `CO2EI` | Energy |
| CO2 Emissions from LULUC GtCO2/y | `CO2ELULUC` | Food and land |
| CRop SUpply (after 20% waste) Mt-crop/y | `CRSU` | Food and land |
| FErtilizer USe Mt/y | `FEUS` | Food and land |
| GDP GDollar/y | `GDP` | Inventory |
| Introduction Period for Policy y | `IPP` | Wellbeing |
