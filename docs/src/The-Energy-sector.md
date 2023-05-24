### Summary
We describe the Energy sector of the Earth4All model, by referring to the Energy view of the Vensim model implementation.

### The Energy sector endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| 4 TWh-el per Mtoe | `FTWEPMt` |  |
| ACcumulated sun and wind capacity from 1980 GW | `ACSWCF1980` | 10.0 |
| Addition of fossil el capacity GW/y | `AFEC` |  |
| Addition of renewable el capacity GW/y | `AREC` |  |
| Addition of sun and wind capacity GW/y | `ASWC` |  |
| CAPEX fossil el GDollar/y | `CAPEXFEG` |  |
| CAPEX of renewable el Dollar/W | `CAPEXRED` |  |
| CAPEX of renewable el GDollar/W | `CAPEXREG` |  |
| CO2 EMissions per person tCO2/p/y | `CO2EMPP` |  |
| CO2 from energy and industry GtCO2/y | `CO2EI` |  |
| CO2 from energy production GtCO2/y | `CO2EP` |  |
| CO2 from non-fossil industrial processes GtCO2/y | `CO2NFIP` |  |
| Cost index for sun and wind capacity | `CISWC` |  |
| Cost of CCS GDollar/y | `CCCSG` |  |
| Cost of electricity GDollar/y | `CEL` |  |
| Cost of energy as share of GDP | `CESGDP` |  |
| Cost of energy GDollar/y | `CE` |  |
| Cost of fossil electricity GDollar/y | `CFE` |  |
| Cost of fossil fuels for non-el-use GDollar/y | `CFFFNEU` |  |
| Cost of grid GDollar/y | `CG` |  |
| Cost of new electrification GDollar/y | `CNE` |  |
| Cost of renewable electricity GDollar/y | `CRE` |  |
| Demand for electricity before NE TWh/y | `DEBNE` |  |
| Demand for electricity TWh/y | `DE` |  |
| Demand for fossil electricity TWh/y | `DFE` |  |
| Demand for fossil fuels for non-el-use before NE Mtoe/y | `DFFNEUBNE` |  |
| Demand for fossil fuels for non-el-use Mtoe/y | `DFFFNEU` |  |
| Desired fossil el capacity change GW/y | `DFECC` |  |
| Desired fossil el capacity GW | `DFEC` |  |
| Desired renewable el capacity change GW | `DRECC` |  |
| Desired renewable el capacity GW | `DREC` |  |
| Desired renewable electricity share | `DRES` |  |
| Desired supply of renewable electricity TWh/y | `DSRE` |  |
| Discard of fossil el capacity GW/y | `DIFEC` |  |
| Discard renewable el capacity GW/y | `DIREC` |  |
| ELectricity balance | `ELB` |  |
| Electricity production TWh/y | `EP` |  |
| Energy use Mtoe/y | `EU` |  |
| Energy use per person toe/p/y | `EUPP` |  |
| Extra cost of Energy Turnaround as share of GDP | `ECETSGDP` |  |
| Extra energy productivity index in 2022 | `EEPI2022` | 1.0 |
| Extra increase in demand for electricity from NE TWh/y | `EIDEFNE` |  |
| Extra reduction in demand for non-el fossil fuel from NE Mtoe/y | `ERDNEFFFNE` |  |
| FCUTeoLOFC | `FCUTLOFC` |  |
| Fossil capacity up-time kh/y | `FCUT` |  |
| Fossil el capacity GW | `FEC` | 980.0 |
| Fossil electricity production TWh/y | `FEP` |  |
| Fossil fuels for electricity Mtoe/y | `FFE` |  |
| Fraction fossil plus nuclear electricity | `FFPNE` |  |
| Fraction new electrification | `FNE` |  |
| Fraction of CO2-sources with CCS | `FCO2SCCS` |  |
| Green hydrogen MtH2/y | `GHMH2` |  |
| Green hydrogen Mtoe/y | `GHMt` |  |
| IIASA Fossil energy production EJ/yr | `IIASAFEP` |  |
| IIASA Renewable energy production EJ/yr | `IIASAREP` |  |
| Increase in extra energy productivity index 1/y | `IEEPI` |  |
| Installed CCS capacity GtCO2/y | `ICCSC` |  |
| Life of fossil el capacity | `LFEC` |  |
| Low carbon el production TWh/y | `LCEP` |  |
| Non-fossil CO2 per person tCO2/p/y | `NFCO2PP` |  |
| Nuclear capacity GW | `NC` |  |
| Nuclear electricity production TWh/y | `NEP` |  |
| Number of dubling in sun and wind capacity | `NDSWC` |  |
| OPEX fossil el GDollar/y | `OPEXFEG` |  |
| OPEX renewable el GDollar/y | `OPEXREG` |  |
| Ratio of Energy cost to Trad Energy cost | `RECTEC` |  |
| Renewable electricity capacity GW | `REC` | 300.0 |
| Renewable electricity production TWh/y | `REP` |  |
| Renewable heat production Mtoe/y | `RHP` |  |
| tCO2 per toe | `TCO2PT` |  |
| Traditional cost of electricity GDollar/y | `TCEG` |  |
| Traditional cost of energy as share of GDP | `TCENSGDP` |  |
| Traditional cost of energy GDollar/y | `TCEN` |  |
| Traditional cost of fossil fuels for non-el-use GDollar/y | `TCFFFNEUG` |  |
| Traditional grid cost GDollar/y | `TGC` |  |
| Traditional per person use of electricity before EE MWh/p/y | `TPPUEBEE` |  |
| Traditional per person use of fossil fuels for non-el-use before EE toe/p/y | `TPPUFFNEUBEE` |  |
| TWh-el per EJ - engineering equivalent | `TWEPEJEE` |  |
| Use of fossil fuels Mtoe/y | `UFF` |  |

### The Energy sector parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| 8 khours per year | `EKHPY` | 8.0 |
| Adjustment factor to make cost match 1980 - 2022 | `AFMCM` | 1.35 |
| Biomass energy Mtoe/y | `BEM` | 0.0 |
| CAPEX fossil el Dollar/W | `CAPEXFED` | 0.7 |
| CAPEX of renewable el in 1980 Dollar/W | `CAPEXRE1980` | 7.0 |
| Cost of CCS Dollar/tCO2 | `CCCSt` | 95.0 |
| Cost of nuclear el Dollar/kWh | `CNED` | 0.033 |
| Cost reduction per dubling of sun and wind capacity | `CRDSWC` | 0.2 |
| Efficiency of fossil power plant TWh-el/TWh-heat | `EFPP` | 0.345 |
| Extra cost per reduced use og non-el FF Dollar/toe | `ECRUNEFF` | 10.0 |
| Extra ROC in energy productivity after 2022 1/y | `EROCEPA2022` | 0.004 |
| Extra use of electricity per reduced use of non-el FF MWh/toe | `EUEPRUNEFF` | 3.0 |
| Fossil el cap construction time y | `FECCT` | 3.0 |
| Fraction new electrification in 1980 | `FNE1980` | 0.0 |
| Fraction new electrification in 2022 | `FNE2022` | 0.03 |
| Fraction of CO2-sources with CCS in 2022 | `FCO2SCCS2022` | 0.0 |
| Fraction of renewable electricity to hydrogen | `FREH` | 0.0 |
| Goal for fraction new electrification | `GFNE` | 1.0 |
| Goal for renewable el fraction | `GREF` | 1.0 |
| Goal fraction of CO2-sources with CCS | `GFCO2SCCS` | 0.9 |
| kWh electricity per kg of hydrogen | `KWEPKGH2` | 40.0 |
| Life of renewable el capacity y | `LREC` | 40.0 |
| Max non-fossil CO2 per person tCO2/p/y | `MNFCO2PP` | 0.5 |
| Mtoe per EJ - calorific equivalent | `MTPEJCE` | 24.0 |
| Normal increase in energy efficiency 1/y | `NIEE` | 0.01 |
| Normal life of fossil el capacity y | `NLFEC` | 40.0 |
| Nuclear capacity up-time kh/y | `NCUT` | 8.0 |
| OPEX fossil el Dollar/kWh | `OPEXFED` | 0.02 |
| OPEX renewable el Dollar/kWh | `OPEXRED` | 0.001 |
| Renewable capacity up-time kh/y | `RCUT` | 3.0 |
| Renewable el contruction time y | `RECT` | 3.0 |
| Renewable el fraction in 1980 | `REFF1980` | 0.065 |
| Renewable el fraction in 2022 | `REFF2022` | 0.23 |
| ROC in tCO2 per toe 1/y | `ROCTCO2PT` | -0.003 |
| sFCUTeoLOFC>0 | `sFCUTLOFC` | 0.5 |
| Sun and wind capacity in 1980 GW | `SWC1980` | 10.0 |
| toe per tH2 | `TPTH2` | 10.0 |
| Traditional cost of electricity Dollar/kWh | `TCE` | 0.03 |
| Traditional cost of fossil fuels for non-el use Dollar/toe | `TCFFFNEU` | 240.0 |
| Transmission cost Dollar/kWh | `TC` | 0.02 |
| TWh-heat per EJ - calorific equivalent | `TWHPEJCE` | 278.0 |

### The Energy sector exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| Cost of Air Capture GDollar/y | `CAC` | Climate |
| GDP Gdollar/y | `GDP` | Inventory |
| GDP per Person kDollar/p/y | `GDPP` | Population |
| Introduction Period for Policy y | `IPP` | Wellbeing |
| POPulation Mp | `POP` | Population |