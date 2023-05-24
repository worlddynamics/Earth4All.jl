# The Earth4All model
###  Summary
We describe the sectors of the Earth4All model, as they can be derived by the Vensim implementation, which is slightly different from the appendix of [Dixson2022].

###  The sectors of the model

The model consists of the following sectors (the description are taken from [Dixson2022]).

- **Population**. This sector generates total population from fertility and mortality processes, potential workforce size, and the number of pensioners.

- **Output**. This sector generates GDP, consumption, investment, government spending, and jobs. The economy is seen as a sum of a private sector and a public sector.

- **Public sector**. This sector generates public spending from tax revenue, the net effect of debt transactions, and the distribution of the budget on governmental goods and services (including on technological advance and the five turnarounds).

- **Labor and market**. This sector generates the unemployment rate worker share of output, and the workforce participation rate, based on the capital output ratio.

- **Demand**. This sector generates income distribution between owners, workers, and the public sector.

- **Inventory**. This sector generates capacity utilization and the inflation rate.

- **Finance**. This sector generates the interest rates.

- **Energy**. This sector generates fossil fuel-based and renewable energy production, greenhouse gas emissions from fossil fuel use, and the cost of energy.

- **Food and land use**. This sector generates crop production, environmental impacts of agriculture, and the cost of food.

- **Well-being trust and tension**. This sector generates the societal ability to react to a challenge (like climate change) as a function of social trust and social tension, and it generates global indicators measuring both environmental and societal sustainability (including the Average Well-being Index). This sector corresponds to two distinct sectors in [Dixson2022].

- **Climate**. This sector is not explicitly mentioned in [Dixson2022].

- **Other performance indicators**. This sector is not explicitly mentioned in [Dixson2022].

A figure representing the causal relationships between the sectors of the model is given in [Randers2022]: these relationships are summarized in the following figures, where the labels of the edges denote variable acronyms as specified in the next tables.

<div align="center"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/climate.png" alt="Relationships among sectors in E4A" width="300" height="300"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/demand.png" alt="Relationships among sectors in E4A" width="300" height="300"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/energy.png" alt="Relationships among sectors in E4A" width="300" height="300"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/finance.png" alt="Relationships among sectors in E4A" width="300" height="300"></div>
<div align="center"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/foodland.png" alt="Relationships among sectors in E4A" width="300" height="300"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/inventory.png" alt="Relationships among sectors in E4A" width="300" height="300"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/labourmarket.png" alt="Relationships among sectors in E4A" width="300" height="300"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/other.png" alt="Relationships among sectors in E4A" width="300" height="300"></div>
<div align="center"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/output.png" alt="Relationships among sectors in E4A" width="300" height="300"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/population.png" alt="Relationships among sectors in E4A" width="300" height="300"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/public.png" alt="Relationships among sectors in E4A" width="300" height="300"><img src="https://github.com/natema/worlddynamicswiki/blob/main/imgs/dependencies/wellbeing.png" alt="Relationships among sectors in E4A" width="300" height="300"></div>

### The variables of the Earth4All model

The Earth4All model contains $564$ variables. In the following table, for each of them, we specify the name used in the Vensim implementation, the acronym used in the WorldDynamics implementation, and the initial value (when this value is necessary for correctly defining a differential equation).

| Vensim name | Name | Initial value in 1980 |
| --- | --- | --- |
| 10-yr Govmnt Interest Rate 1/y | `TGIR(t)` |  |
| 3m Interest Rate 1/y | `TIR(t)` |  |
| 4 TWh-el per Mtoe | `FTWEPMt(t)` |  |
| Acceptable Loss of Forestry Land (1) | `ALFL(t)` |  |
| ACcumulated sun and wind capacity from 1980 GW | `ACSWCF1980(t)` | 10.0 |
| Addition of fossil el capacity GW/y | `AFEC(t)` |  |
| Addition of renewable el capacity GW/y | `AREC(t)` |  |
| Addition of sun and wind capacity GW/y | `ASWC(t)` |  |
| Aged 0-20 years Mp | `A0020(t)` | 2170.0 |
| Aged 20-40 years Mp | `A2040(t)` | 1100.0 |
| Aged 20-Pension Age Mp | `A20PA(t)` |  |
| Aged 40-60 Mp | `A4060(t)` | 768.0 |
| Aged 60 + Mp | `A60PL(t)` | 382.0 |
| ALbedo (1) | `AL(t)` |  |
| ALbedo in 1980 (1) | `AL1980(t)` |  |
| Amount of Fertilizer Saved in Reg Ag kgN/ha/y | `AFSRA(t)` |  |
| AVailable CApital Gdollar/y | `AVCA(t)` |  |
| AVailable WOrkforce Mp | `AVWO(t)` |  |
| Average Crop Yield t-crop/ha/y | `ACY(t)` |  |
| Average Gross Income per Worker kdollar/p/y | `AGIW(t)` |  |
| Average Hours Worked in 1980 kh/y | `AHW1980(t)` |  |
| Average Hours Worked kh/y | `AHW(t)` |  |
| Average WellBeing from Disposable Income (1) | `AWBDI(t)` |  |
| Average WellBeing from Global Warming (1) | `AWBGW(t)` |  |
| Average WellBeing from INequality (1) | `AWBIN(t)` |  |
| Average WellBeing from Progress (1) | `AWBP(t)` |  |
| Average WellBeing from Public Spending (1) | `AWBPS(t)` |  |
| Average WellBeing Index (1) | `AWBI(t)` |  |
| Bank Cash Inflow as Share of NI (1) | `BCISNI(t)` |  |
| Bank Cash Inflow from Lending GDollar/y | `BCIL(t)` |  |
| BArren LAnd Mha | `BALA(t)` | 3000.0 |
| Basic Income Tax Rate Owners (1) | `BITRO(t)` |  |
| BIofuels USe Mtoe/y | `BIUS(t)` |  |
| Birth Rate 1/y | `BIRTHR(t)` |  |
| Births Mp/y | `BIRTHS(t)` |  |
| CANCellation of Debt GDollar/y | `CANCD(t)` |  |
| Capacity Addition PIS Gcu/y | `CAPIS(t)` |  |
| Capacity Addition PUS Gcu/y | `CAPUS(t)` |  |
| Capacity Discard PIS Gcu/y | `CDPIS(t)` |  |
| Capacity Discard PUS Gcu/y | `CDPUS(t)` |  |
| CAPacity Gcu | `CAP(t)` |  |
| Capacity Initiation PIS Gcu/y | `CIPIS(t)` |  |
| Capacity Initiation PUS Gcu/y | `CIPUS(t)` |  |
| Capacity PIS Gcu | `CPIS(t)` | 59250.0 |
| Capacity PUS Gcu | `CPUS(t)` | 5350.0 |
| Capacity Renewal Rate 1/y | `CRR(t)` |  |
| Capacity Under Construction PIS Gcu | `CUCPIS(t)` | 10072.5 |
| Capacity Under Construction PUS Gcu | `CUCPUS(t)` | 909.5 |
| CAPEX fossil el GDollar/y | `CAPEXFEG(t)` |  |
| CAPEX renewable el dollar/W | `CAPEXRED(t)` |  |
| CAPEX renewable el Gdollar/y | `CAPEXREG(t)` |  |
| Cash Flow from Govmnt to Banks GDollar/y | `CFGB(t)` |  |
| Cash Flow from Workers to Banks GDollar/y | `CFWB(t)` |  |
| CBC Effect on Flow to Capacity Addion (1) | `CBCEFCA(t)` |  |
| Central Bank Signal Rate 1/y | `CBSR(t)` | 0.02 |
| CH4 BreakDown GtCH4/y | `CH4BD(t)` |  |
| CH4 conc in 1980 ppm | `CH4C1980(t)` |  |
| CH4 concentration in atm ppm | `CH4CA(t)` |  |
| CH4 emissions GtCH4/y | `CH4E(t)` |  |
| CH4 forcing per ppm W/m2/ppm | `CH4FPP(t)` |  |
| CH4 in Atmosphere GtCH4 | `CH4A(t)` | 2.5 |
| Change in DDI 1/y | `CDDI(t)` |  |
| Change in Embedded CLR kcu/ftj/y | `CECLR(t)` |  |
| Change in Price Index 1/y | `CPI(t)` |  |
| Change in Signal Rate 1/yy | `CSR(t)` |  |
| Change in Soil Quality in Conv Ag t-crop/ha/y/y | `CSQCA(t)` |  |
| Change in TFP 1/y | `CTFP(t)` |  |
| Change in Wage RAte dollar/ph/y | `CWRA(t)` |  |
| CHange in WOrkforce Mp/y | `CHWO(t)` |  |
| Change in WSO 1/y | `CWSO(t)` |  |
| CO2 absorption GtCO2/y | `CO2AB(t)` |  |
| CO2 Absorption in Forestry Land GtCO2/y | `CO2AFL(t)` |  |
| CO2 Absorption in Forestry Land tCO2/ha/y | `CO2AFLH(t)` |  |
| CO2 concentration in atm ppm | `CO2CA(t)` |  |
| CO2 Effect on Land Yield (1) | `CO2ELY(t)` |  |
| CO2 Emissions from LULUC GtCO2/y | `CO2ELULUC(t)` |  |
| CO2 emissions GtCO2/y | `CO2E(t)` |  |
| CO2 EMissions per person tCO2/y | `CO2EMPP(t)` |  |
| CO2 forcing per ppm W/m2/ppm | `CO2FPP(t)` |  |
| CO2 from CH4 GtCO2/y | `CO2FCH4(t)` |  |
| CO2 from energy and industry GtCO2/y | `CO2EI(t)` |  |
| CO2 from energy production GtCO2/y | `CO2EP(t)` |  |
| CO2 from non-fossil industrial processes GtCO2/y | `CO2NFIP(t)` |  |
| CO2 in Atmosphere GtCO2 | `CO2A(t)` | 2600.0 |
| CO2 per GDP (kgCO2/Dollar) | `CO2GDP(t)` |  |
| CO2 Release from Forest Cut GtCO2/y | `CO2RFC(t)` |  |
| Consumption Demand GDollar/y | `CD(t)` |  |
| Consumption Per Person GDollar/y | `CPP(t)` |  |
| Consumption Share of GDP (1) | `CSGDP(t)` |  |
| CONTRol: (C+G+S)/NI = 1 | `CONTR(t)` |  |
| Corporate Borrowing Cost 1/y | `CBC(t)` |  |
| Corporate Borrowing Cost in 1980 1/y | `CBC1980(t)` |  |
| Cost Index for Regenerative Agriculture (1) | `CIRA(t)` |  |
| Cost index for sun and wind capacity (1) | `CISWC(t)` |  |
| Cost of air capture GDollar/y | `CAC(t)` |  |
| COst of CApacity dollar/cu | `COCA(t)` |  |
| Cost of Capital for Secured Debt 1/y | `CCSD(t)` | 0.04 |
| Cost of CCS GDollar/y | `CCCSG(t)` |  |
| Cost of electricity GDollar/y | `CEL(t)` |  |
| Cost of energy as share of GDP (1) | `CESGDP(t)` |  |
| Cost of energy GDollar/y | `CE(t)` |  |
| Cost of Extra Fertility Reduction (share of GDP) | `CEFR(t)` |  |
| COst of FErtilizer Gdollar/y | `COFE(t)` |  |
| Cost of Food and Energy TAs GDollar/y | `CFETA(t)` |  |
| COst of FOod Gdollar/y | `COFO(t)` |  |
| Cost of fossil electricity GDollar/y | `CFE(t)` |  |
| Cost of Fossil Fuel For Non-El Use Gdollar/y | `CFFFNEU(t)` |  |
| Cost of grid GDollar/y | `CG(t)` |  |
| Cost of new electrification GDollar/y | `CNE(t)` |  |
| Cost of Nuclear ELectricity Gdollar/y | `CNEL(t)` |  |
| Cost of Regenerative Agriculture Gdollar/y | `CRA(t)` |  |
| Cost of renewable electricity GDollar/y | `CRE(t)` |  |
| Cost of TAs GDollar/y | `CTA(t)` |  |
| CRop BAlance (1) | `CRBA(t)` |  |
| CRop DEmand Mt-crop/y | `CRDE(t)` |  |
| CRop SUpply (after 20 % waste) Mt-crop/y | `CRSU(t)` |  |
| Crop Supply Reg Ag Mt-crop/y | `CSRA(t)` |  |
| CRop USe Mt/y | `CRUS(t)` |  |
| CRop USe per Person t-crop/p/y | `CRUSP(t)` |  |
| Crop Waste Reduction (1) | `CWR(t)` |  |
| CRopland EXpansion Mha/y | `CREX(t)` |  |
| Cropland Expansion Multiplier (1) | `CEM(t)` |  |
| CRopland EXpansion Rate 1/y | `CREXR(t)` |  |
| CRopland LOss Mha/y | `CRLO(t)` |  |
| CRopLAnd Mha | `CRLA(t)` | 1450.0 |
| CRops for BIofuel Mt-crop/y | `CRBI(t)` |  |
| Death Rate 1/y | `DEATHR(t)` |  |
| Deaths Mp/y | `DEATHS(t)` |  |
| DELiveries Gu/y | `DEL(t)` |  |
| DELivery Delay - Index (1) | `DELDI(t)` | 1.0 |
| Demand for electricity before NE TWh/y | `DEBNE(t)` |  |
| Demand for electricity TWh/y | `DE(t)` |  |
| Demand for fossil electricity TWh/y | `DFE(t)` |  |
| Demand for fossil fuel for non-el use before NE Mtoe/y | `DFFNEUBNE(t)` |  |
| Demand for fossil fuel for non-el use Mtoe/y | `DFFFNEU(t)` |  |
| Demand for Red Meat Mt-red-meat/y | `DRM(t)` |  |
| Demand for Red Meat per Person kg-red-meat/p/y | `DRMP(t)` |  |
| Dependency Ratio p/p | `DR(t)` |  |
| Desired Crop Supply Conv Ag Mt-crop/y | `DCSCA(t)` |  |
| Desired Crop Supply Mt-crop/y | `DCS(t)` |  |
| Desired Crop Yield in Conv Ag t-crop/ha/y | `DCYCA(t)` |  |
| Desired fossil el capacity change GW/y | `DFECC(t)` |  |
| Desired fossil el capacity GW | `DFEC(t)` |  |
| Desired No of Children 1 | `DNC(t)` |  |
| Desired renewable el capacity change GW | `DRECC(t)` |  |
| Desired renewable el capacity GW | `DREC(t)` |  |
| Desired renewable electricity share (1) | `DRES(t)` |  |
| Desired Shifts Worked - Index (1) | `DSWI(t)` |  |
| Desired supply of renewable electricity TWh/y | `DSRE(t)` |  |
| Direct Air Capture of CO2 GtCO2/y | `DACCO2(t)` |  |
| DIscard of Fossil El Capacity GW/y | `DIFEC(t)` |  |
| Discard of renewable el capacity GW/y | `DIREC(t)` |  |
| Domestic Rate of Technological Advance 1/y | `DRTA(t)` |  |
| ED Effect on Flow to Capacity Addition (1) | `EDEFCA(t)` |  |
| Effect of Capacity Renewal 1/y | `ECR(t)` |  |
| Effective GDP per Person kDollar/p/y | `EGDPP(t)` | 6.4 |
| Effective Purchasing Power Gdollar/y | `EPP(t)` | 28087.0 |
| ELectricity balance (1) | `ELB(t)` |  |
| Electricity production TWh/y | `EP(t)` |  |
| Embedded CLR kcu/ftj | `ECLR(t)` | 41.0 |
| Embedded TFP (1) | `ETFP(t)` | 1.0 |
| Energy use Mtoe/y | `EU(t)` |  |
| Energy use per person toe/p/y | `EUPP(t)` |  |
| Excess DEmand (1) | `EDE(t)` |  |
| Excess Demand Effect on Life of Capacity (1) | `EDELC(t)` |  |
| Expected Long Term Inflation 1/y | `ELTI(t)` | 0.02 |
| Extra CO2 Absorption in Reg Ag GtCO2/y | `ECO2ARA(t)` |  |
| Extra cooling from ice melt ZJ/y | `ECIM(t)` |  |
| Extra cost of Energy Turnaround as share of GDP (1) | `ECETSGDP(t)` |  |
| Extra Cost of Food Turnaround as Share of GDP (1) | `ECFTSGDP(t)` |  |
| Extra Cost of Food Turnaround Gdollar/y | `ECFT(t)` |  |
| Extra Cost of Reg Ag dollar/ha/y | `ECRA(t)` |  |
| Extra Cost of TAs as share of GDP (1) | `ECTAGDP(t)` |  |
| Extra Cost of TAs From 2022 GDollar/y | `ECTAF2022(t)` |  |
| Extra energy productivity index 2022=1 | `EEPI2022(t)` | 1.0 |
| Extra Fertility Reduction (1) | `EFR(t)` |  |
| Extra General Tax From 2022 Gdollar/y | `EGTF2022(t)` |  |
| Extra heat in surface ZJ | `EHS(t)` | 0.0 |
| Extra increase in demand for electricity from NE TWh/y | `EIDEFNE(t)` |  |
| Extra Normal LPR from 2022 (1) | `ENLPR2022(t)` |  |
| Extra Pension Age y | `EPA(t)` | 0.0 |
| Extra reduction in demand for non-el fossil fuel from NE Mtoe/y | `ERDNEFFFNE(t)` |  |
| Extra Taxes for TAs From 2022 GDollar/y | `ETTAF2022(t)` |  |
| Extra Taxes From 2022 GDollar/y | `ETF2022(t)` | 0.0 |
| Extra Warming from forcing ZJ/y | `EWFF(t)` |  |
| FCUTeoLOFC (1) | `FCUTLOFC(t)` |  |
| FEed for Red Meat Mt-crop/y | `FERM(t)` |  |
| Fertility Multiplier (1) | `FM(t)` |  |
| Fertilizer Cost Reduction Gdollar/y | `FCR(t)` |  |
| Fertilizer Effect on Erosion Rate (1) | `FEER(t)` |  |
| Fertilizer Productivity Index (1980=1) | `FPI(t)` |  |
| Fertilizer Use in Conv Ag kgN/ha/y | `FUCA(t)` |  |
| FErtilizer USe Mt/y | `FEUS(t)` |  |
| FErtilizer USe per Person kg/p/y | `FUP(t)` |  |
| FFLReoOGRR | `FFLREOGRR(t)` |  |
| FOod FOotprint | `FOFO(t)` |  |
| Food Footprint Index (1980=1) | `FFI(t)` |  |
| Food Sector Productivity Index (1980=1) | `FSPI(t)` |  |
| Forcing from CH4 W/m2 | `FCH4(t)` |  |
| Forcing from CO2 W/m2 | `FCO2(t)` |  |
| Forcing from N2O W/m2 | `FN2O(t)` |  |
| Forcing from other gases W/m2 | `FOG(t)` |  |
| Forest Absorption Multipler (1) | `FAM(t)` |  |
| FOrestry LAnd Mha | `FOLA(t)` | 1100.0 |
| Fossil capacity up-time kh/y | `FCUT(t)` |  |
| Fossil electricity capacity GW | `FEC(t)` | 980.0 |
| Fossil Electricity Production TWh/y | `FEP(t)` |  |
| Fossil fuels for electricity Mtoe/y | `FFE(t)` |  |
| FRACA Mult from GDPpP - Line (1) | `FRACAMGDPPL(t)` |  |
| FRACA Mult from GDPpP - Table (1) | `FRACAMGDPPT(t)` |  |
| Fraction Below 15 kDollar/p/y (1) | `FB15(t)` |  |
| Fraction Forestry Land Remaining (1) | `FFLR(t)` |  |
| Fraction fossil plus nuclear electricity (1) | `FFPNE(t)` |  |
| Fraction new electrification (1) | `FNE(t)` |  |
| Fraction New Red Meat (1) | `FNRM(t)` |  |
| Fraction of Available Capital to New Capacity (1) | `FACNC(t)` | 1.0515 |
| Fraction of CO2-sources with CCS (1) | `FCO2SCCS(t)` |  |
| Fraction of Govmnt Budget to Workers (1) | `FGBW(t)` | 0.3 |
| Fraction Regenerative Agriculture (1) | `FRA(t)` |  |
| GDP Gdollar/y | `GDP(t)` |  |
| GDP per Person kDollar/p/y | `GDPP(t)` |  |
| GDPppeoROCCLR | `GDPPEROCCLR(t)` |  |
| GHG emissions GtCO2e/y | `GHGE(t)` |  |
| Goal for Extra Taxes From 2022 GDollar/y | `GETF2022(t)` |  |
| Goal for Fraction of Govmnt Budget to Workers (1) | `GFGBW(t)` |  |
| Govmnt Borrowing Cost 1/y | `GBC(t)` |  |
| Govmnt Cash INflow GDollar/y | `GCIN(t)` |  |
| Govmnt Debt Burden y | `GDB(t)` |  |
| Govmnt Debt Gdollar | `GD(t)` | 17975.68 |
| Govmnt Finance as Share of NI (1) | `GFSNI(t)` |  |
| Govmnt Gross Income (as Share of NI) | `GGIS(t)` |  |
| Govmnt Gross Income GDollar/y | `GGI(t)` |  |
| Govmnt Interest Cost GDollar/y | `GIC(t)` |  |
| Govmnt Investment in Public Capacity GDollar/y | `GIPC(t)` |  |
| Govmnt Net Income as Share of NI (1) | `GNISNI(t)` |  |
| Govmnt Net Income GDollar/y | `GNI(t)` | 6531.07 |
| Govmnt New Debt GDollar/y | `GND(t)` |  |
| Govmnt Payback GDollar/y | `GP(t)` |  |
| Govmnt PUrchases GDollar/y | `GPU(t)` |  |
| Govmnt Share of GDP (1) | `GSGDP(t)` |  |
| Govmnt Spending as Share of GDP | `GSSGDP(t)` |  |
| Govmnt Spending GDollar/y | `GS(t)` |  |
| GRazing LAnd Mha | `GRLA(t)` | 3300.0 |
| Grazing Land Yied in 1980 kg-red-meat/ha/y | `GLY80(t)` |  |
| Grazing Land Yield kg-red-meat/ha/y | `GLY(t)` |  |
| Green hydrogen MtH2/y | `GHMH2(t)` |  |
| Green hydrogen Mtoe/y | `GHMt(t)` |  |
| Heat to deep ocean ZJ/y | `HDO(t)` |  |
| Heat to space ZJ/y | `HTS(t)` |  |
| Hiring/Firing Delay y | `HFD(t)` |  |
| Hours Worked Mult from GDPpP (1) | `HWMGDPP(t)` |  |
| Ice and snow cover excl G&A Mkm2 | `ISCEGA(t)` | 12.0 |
| Ice and snow cover Mha | `ISC(t)` |  |
| IIASA Fossil energy production EJ/yr | `IIASAFEP(t)` |  |
| IIASA Renewable energy production EJ/yr | `IIASAREP(t)` |  |
| Imported ROTA 1/y | `IROTA(t)` |  |
| Income from Commons from 2022 GDollar/y | `IC2022(t)` |  |
| Income Tax Owners (1) | `ITO(t)` |  |
| Income Tax Workers (1) | `ITW(t)` |  |
| Increase in extra energy productivity index 1/y | `IEEPI(t)` |  |
| Indicated Labour Participation Rate (1) | `ILPR(t)` |  |
| Indicated Reform Delay y | `IRD(t)` |  |
| Indicated Signal Rate 1/y | `ISR(t)` |  |
| Indicated Social Trust (1) | `IST(t)` |  |
| Indicated TFP (1) | `ITFP(t)` |  |
| Indicated Urban Land Mha | `IUL(t)` |  |
| Indicated Wage Effect on Optimal CLR (1) | `IWEOCLR(t)` |  |
| INEQuality (1) | `INEQ(t)` |  |
| INEQuality Index (1980=1) | `INEQI(t)` |  |
| Inequity Effect on Logistic k (1) | `IEL(t)` |  |
| Inequity Effect on Social Trust (1) | `IEST(t)` |  |
| Inflation Rate 1/y | `IR(t)` |  |
| Infrastructure Purchases Ratio y | `IPR(t)` |  |
| Installed CCS capacity GtCO2/y | `ICCSC(t)` |  |
| Introduction Period for Policy y | `IPP(t)` |  |
| Inventory Coverage y | `IC(t)` |  |
| INVentory Gu | `INV(t)` | 11234.8 |
| Investment in New Capacity PIS Gdollar/y | `INCPIS(t)` |  |
| Investment Share of GDP (1) | `ISGDP(t)` |  |
| kg CH4 emission per kg crop | `KCH4EKC(t)` |  |
| kg N2O emission per kg fertiliser | `KN2OEKF(t)` |  |
| Labour Participation Rate (1) | `LPR(t)` | 0.8 |
| LAbour PRoductivity dollar/ph | `LAPR(t)` |  |
| LAbour USe Gph/y | `LAUS(t)` | 3060.0 |
| LAbour USe in 1980 Gph/y | `LAUS80(t)` |  |
| Land ERosion Multiplier (1) | `LERM(t)` |  |
| Land Erosion Rate 1/y | `LER(t)` |  |
| LE at 60 y | `LE60(t)` |  |
| Life Expectancy Multipler (1) | `LEM(t)` |  |
| Life Expectancy y | `LE(t)` | 67.0 |
| Life of Capacity PIS y | `LCPIS(t)` |  |
| Life of Capacity PUS in 1980 y | `LCPUS1980(t)` |  |
| Life of Capacity PUS y | `LCPUS(t)` |  |
| Life of extra CO2 in atm y | `LECO2A(t)` |  |
| Life of fossil el capacity y | `LFEC(t)` |  |
| Logistic K (1) | `LK(t)` |  |
| Long-Term Erosion of WSO 1/y | `LTEWSO(t)` |  |
| LOss of CRopland Mha/y | `LOCR(t)` |  |
| Loss of Forest Land Mha/y | `LFL(t)` |  |
| Low-carbon el production TWh/y | `LCEP(t)` |  |
| Man-made CH4 emissions GtCH4/y | `MMCH4E(t)` |  |
| Man-made Forcing W/m2 | `MMF(t)` |  |
| Man-made N2O emissions GtN2O/y | `MMN2OE(t)` |  |
| Max Govmnt Debt GDollar | `MGD(t)` |  |
| Max Workers Debt GDollar | `MWD(t)` |  |
| Melting Mha/y | `MEL(t)` |  |
| Melting rate deep ice 1/y | `MRDI(t)` |  |
| Melting rate surface 1/y | `MRS(t)` |  |
| N2O BreakDown GtN2O/y | `N2OBD(t)` |  |
| N2O conc in 1980 ppm | `N2OC1980(t)` |  |
| N2O concentration in atm ppm | `N2OCA(t)` |  |
| N2O emissions GtN2O/y | `N2OE(t)` |  |
| N2O forcing per ppm W/m2/ppm | `N2OFPP(t)` |  |
| N2O in Atmosphere GtN2O | `N2OA(t)` | 1.052 |
| National Income Gdollar/y | `NI(t)` |  |
| Natural CH4 emissions GtCH4/y | `NCH4E(t)` |  |
| Natural N2O emissions GtN2O/y | `NN2OE(t)` |  |
| New Forestry Land Mha/y | `NFL(t)` |  |
| New Grazing Land Mha/y | `NGL(t)` |  |
| Non-fossil CO2 per person tCO2/p/y | `NFCO2PP(t)` |  |
| Normal Corporate Credit Risk 1/y | `NCCR(t)` |  |
| Normal Hours Worked kh/ftj/y | `NHW(t)` | 2.0 |
| Normal LPR (1) | `NLPR(t)` |  |
| Nuclear capacity GW | `NC(t)` |  |
| Nuclear electricity production TWh/y | `NEP(t)` |  |
| Number of Doublings in Reg Ag (1) | `NDRA(t)` |  |
| Number of doublings in sun and wind capacity (1) | `NDSWC(t)` |  |
| Observed Fertility 1 | `OF(t)` |  |
| Observed Rate of Progress 1/y | `ORP(t)` | 0.0 |
| OBserved WArming deg C | `OW(t)` |  |
| Off-Balance Sheet Govmnt Inv in PIS (share of GDP) | `OBSGIPIS(t)` |  |
| Off-Balance-Sheet Govmnt Inv in PUS (share of GDP) | `OBSGIPUS(t)` |  |
| Old Growth Forest Area Mha 1 | `OGFA(t)` | 2600.0 |
| Old Growth Removal Mha/y | `OGRE(t)` |  |
| Old Growth Removal Rate 1/y | `OGRR(t)` |  |
| Old Growth Removal Rate Multiplier (1) | `OGRRM(t)` |  |
| On Pension Mp | `OP(t)` |  |
| OPEX fossil el GDollar/y | `OPEXFEG(t)` |  |
| OPEX renewable el Gdollar/y | `OPEXREG(t)` |  |
| Optimal Capital Labour Ratio kcu/ftj | `OCLR(t)` |  |
| Optimal Ouput - Value Gdollar/y | `OOV(t)` |  |
| Optimal Real Output Gu/y | `ORO(t)` |  |
| OPtimal WOrkforce Mp | `OPWO(t)` |  |
| Output Growth Rate 1/y | `OGR(t)` | 0.06 |
| OUTPut Gu/y | `OUTP(t)` |  |
| Output Last Year Gdollar/y | `OLY(t)` | 26497.1288 |
| OWeoCOC (1) | `OWECC(t)` |  |
| OWeoLOC (1) | `OWELC(t)` |  |
| OWeoLoCO2 | `OWLCO2(t)` |  |
| OWeoTFP | `OWTFP(t)` |  |
| Owner Cash INflow GDollar/y | `OCIN(t)` |  |
| Owner Consumptin Fraction (1) | `OCF(t)` |  |
| Owner Consumption GDollar/y | `OC(t)` |  |
| Owner Income GDollar/y | `OI(t)` |  |
| Owner Operating Income After Tax GDollar/y | `OOIAT(t)` |  |
| Owner Savings Fraction (1) | `OSF(t)` |  |
| Owner Savings GDollar/y | `OS(t)` |  |
| Owner Tax Rate (1) | `OTR(t)` |  |
| Owner Taxes GDollar/y | `OT(t)` |  |
| Participation (1) | `PART(t)` |  |
| Passing 20 Mp/y | `PASS20(t)` |  |
| Passing 40 Mp/y | `PASS40(t)` | 64.0 |
| Passing 60 Mp/y | `PASS60(t)` | 38.0 |
| Past AWI (1) | `PAWBI(t)` | 0.65 |
| Past GDP per Person kDollar/y | `PGDPP(t)` | 5.952 |
| Pension Age y | `PA(t)` | 62.0 |
| Pensioners per Worker p/p | `PW(t)` |  |
| Perceived Crop Balance (1) | `PCB(t)` |  |
| Perceived Excess DEmand (1) | `PEDE(t)` | 1.0 |
| Perceived Inflation CB 1/y | `PI(t)` | 0.02 |
| Perceived Relative Inventory (1) | `PRI(t)` | 1.0 |
| Perceived Surplus Workforce (1) | `PSW(t)` |  |
| Perceived Unemployment CB (1) | `PU(t)` | 0.0327 |
| Perceived Unemployment RAte (1) | `PURA(t)` | 0.05 |
| Perceived WArming deg C | `PWA(t)` | 0.4 |
| Permanent Govmnt Cash INflow GDollar/y | `PGCIN(t)` | 5400.0 |
| Permanent Owner Cash Inflow GDollar/y | `POCI(t)` | 7081.0 |
| Permanent Worker Cash INflow GDollar/y | `PWCIN(t)` | 13000.0 |
| Pink Noise In Sales (1) | `PNIS(t)` |  |
| Population Below 15 kDollar/p/y Mp | `PB15(t)` |  |
| Population Growth Rate 1/y | `PGR(t)` |  |
| Population Mp | `POP(t)` |  |
| Potential Red Meat from Grazing Land Mt-red-meat/y | `PRMGL(t)` |  |
| Price Index (1980=1) | `PI1980(t)` | 1.0 |
| Productivity Loss from Unprofitable Activity (1) | `PLUA(t)` |  |
| Productivity of Public Purchases (1) | `PPP(t)` |  |
| Public SErvices per Person kdollar/p/y | `PSEP(t)` |  |
| Public Spending as Share of GDP | `PSSGDP(t)` |  |
| Public Spending Effect on Social TRust (1) | `PSESTR(t)` |  |
| Public Spending per Person kDollar/p/y | `PSP(t)` |  |
| Rate of Growth in GDP per Person 1/y | `RGGDPP(t)` |  |
| Rate of Technological Advance 1/y | `RTA(t)` |  |
| Ratio of Energy cost to Trad Energy cost (1) | `RECTEC(t)` |  |
| Recent Sales Gu/y | `RS(t)` | 28087.0 |
| Red Meat from Feedlots Mt-red-meat/y | `RMF(t)` |  |
| Red Meat from Grazing Land Mt-red-meat/y | `RMGL(t)` |  |
| Red meat Supply per Person kg-red-meat/p/y | `RMSP(t)` |  |
| Reduction in ROTA from Inequality 1/y | `RROTAI(t)` |  |
| Reduction in TFP from Unprofitable Activity (1) | `RTFPUA(t)` | 0.0 |
| Reform Delay y | `RD(t)` | 30.0 |
| Regenerative Agriculture Area Mha | `RAA(t)` |  |
| Renewable electricity capacity GW | `REC(t)` | 300.0 |
| Renewable electricity production TWh/y | `REP(t)` |  |
| Renewable heat production Mtoe/y | `RHP(t)` |  |
| Risk of extreme heat event (1) | `REHE(t)` |  |
| ROC in DDI 1/y | `ROC(t)` |  |
| ROC in ECLR 1/y | `ROCECLR(t)` |  |
| ROC in Soil Quality in Conv Ag 1/y | `ROCSQCA(t)` |  |
| ROC in WSO - Table 1/y | `ROCWSO(t)` |  |
| SAles Gdollar/y | `SA(t)` |  |
| Sales Tax GDollar/y | `ST(t)` |  |
| Sales Tax Owners GDollar/y | `STO(t)` |  |
| Sales Tax Workers GDollar/y | `STW(t)` |  |
| Savings Share of GDP (1) | `SSGDP(t)` |  |
| ShiftS Worked - Index (1) | `SSWI(t)` | 1.0 |
| Social TEnsion (1) | `STE(t)` | 1.3 |
| Social TEnsion Effect on Reform Delay (1) | `STEERD(t)` |  |
| Social Trust (1) | `STR(t)` | 0.6 |
| Social TRust Effect on Reform Delay (1) | `STRERD(t)` |  |
| Soil Quality Index in Conv Ag (1980=1) | `SQICA(t)` | 1.0 |
| State Capacity (fraction of GDP) | `SC(t)` |  |
| tCO2 per toe | `TCO2PT(t)` |  |
| TFP Excluding Effect of 5TAs (1) | `TFPEE5TA(t)` | 1.0 |
| TFP Including Effect of 5TAs (1) | `TFPIE5TA(t)` |  |
| Time to Change Tooling y | `TCT(t)` |  |
| Total Forest Area Mha | `TFA(t)` |  |
| Total man-made forcing W/m2 | `TMMF(t)` |  |
| Total Purchasing Power GDollar/y | `TPP(t)` |  |
| Total Savings GDollar/y | `TS(t)` |  |
| Traditional cost of electricity GDollar/y | `TCEG(t)` |  |
| Traditional cost of energy as share of GDP (1) | `TCENSGDP(t)` |  |
| Traditional Cost of ENergy Gdollar/y | `TCEN(t)` |  |
| Traditional cost of fossil fuel for non-el use Gdollar/y | `TCFFFNEUG(t)` |  |
| Traditional Fertilizer Use in Conv Ag kgN/ha/y | `TFUCA(t)` |  |
| Traditional grid cost GDollar/y | `TGC(t)` |  |
| Traditional per person use of electricity before EE MWh/p/y | `TPPUEBEE(t)` |  |
| Traditional per person use of fossil fuels for non-el-use before EE toe/p/y | `TPPUFFNEUBEE(t)` |  |
| Traditional Use of Crops Ex Red Meat Mt/y | `TUCERM(t)` |  |
| Traditional Use of Crops Ex Red Meat per Person kg-crop/p/y | `TUCERMP(t)` |  |
| Traditional Use of Crops Mt/y | `TUC(t)` |  |
| Traditional Use of Crops per Person kg-crop/p/y | `TUCP(t)` |  |
| Traditional Use of Feed for Red Meat Mt-crop/y | `TUFRM(t)` |  |
| Traditional Use of Red Meat per Person kg-red-meat/p/y | `TURMP(t)` |  |
| Transfer Payments GDollar/y | `TP(t)` |  |
| Transfer rate for heat going to abyss 1/y | `TRHGA(t)` |  |
| Transfer rate for heat going to space 1/y | `TRHGS(t)` |  |
| TWh-el per EJ - engineering equivalent | `TWEPEJEE(t)` |  |
| UNEMployed Mp | `UNEM(t)` |  |
| Unemployment perception time y | `UPT(t)` |  |
| UNemployment RAte (1) | `UR(t)` |  |
| URban EXpansion Mha/y | `UREX(t)` |  |
| URban LAnd Mha | `URLA(t)` | 215.0 |
| Use of fossil fuels Mtoe/y | `UFF(t)` |  |
| Value of Public Services Supplied GDollar/y | `VPSS(t)` |  |
| Wage Effect on Optimal CLR (1) | `WEOCLR(t)` | 1.0 |
| WAge RAte dollar/ph | `WARA(t)` | 3.6715 |
| Wage Rate Erosion dollar/ph/y | `WRE(t)` |  |
| Wage Rate Erosion Rate 1/y | `WRER(t)` |  |
| WAge Share (1) | `WASH(t)` |  |
| Warming Effect on Land Yield (1) | `WELY(t)` |  |
| Warming Effect on Life Expectancy (1) | `WELE(t)` |  |
| Water Vapor Concentration g/kg | `WVC(t)` |  |
| Water Vapour Feedback W/m2 | `WVF(t)` |  |
| WellBeing Effect of Participation (1) | `WBEP(t)` |  |
| Worker Borrowing Cost 1/y | `WBC(t)` |  |
| Worker Cash INflow GDollar/y | `WCIN(t)` |  |
| Worker consumption demand GDollar/y | `WCD(t)` |  |
| Worker Debt Burden y | `WDB(t)` |  |
| Worker Disposable Income kDollar/p/y | `WDI(t)` |  |
| Worker Finance Cost as Share of Income (1) | `WFCSI(t)` |  |
| Worker Income After Tax GDollar/y | `WIAT(t)` |  |
| Worker Income GDollar/y | `WI(t)` |  |
| Worker Interest Cost GDollar/y | `WIC(t)` |  |
| Worker Savings GDollar/y | `WS(t)` |  |
| Worker Share of Output (1) | `WSO(t)` | 0.5 |
| Worker Tax Rate (1) | `WTR(t)` |  |
| Worker Taxes GDollar/y | `WT(t)` |  |
| Workers Debt GDollar | `WD(t)` | 7406.88 |
| Workers New Debt GDollar/y | `WND(t)` |  |
| Workers Payback GDollar/y | `WP(t)` |  |
| WorkForce Mp | `WF(t)` | 1530.0 |
| Working Age Population Mp | `WAP(t)` |  |
| WSO Effect on Flow to Capacity Addition (1) | `WSOEFCA(t)` |  |
| XExtra Cost of TAs as share of GDP (1) | `XECTAGDP(t)` |  |

### The parameters of the Earth4All model

The Earth4All model contains $288$ constatnts (called parameters in WorldDynamics). In the following table, for each of them, we specify the name used in the Vensim implementation, the acronym used in the WorldDynamics implementation, and the value.

| Vensim name | Name | Value |
| --- | --- | --- |
| 10-Yr Loop Delay y | `TYLD` | 2.3 |
| 8 khours per year | `EKHPY` | 8.0 |
| Acceptable Inequality | `AI` | 0.6 |
| Acceptable Progress 1/y | `AP` | 0.02 |
| Acceptable Unemployment Rate (1) | `AUR` | 0.05 |
| Adjustment factor to make cost match 1980 - 2022 | `AFMCM` | 1.35 |
| Agriculture as Fraction of GDP | `AFGDP` | 0.05 |
| ALbedo global average | `ALGAV` | 0.3 |
| ALbedo Ice and snow | `ALIS` | 0.7 |
| Amount of ice in 1980 MKm3 | `AI1980` | 55.0 |
| Average WellBeing Perception Delay y | `AWBPD` | 9.0 |
| Basic Income Tax Rate Workers | `BITRW` | 0.2 |
| Biomass energy Mtoe/y | `BEM` | 0.0 |
| CAP PIS in 1980 Gcu | `CAPPIS1980` | 59250.0 |
| CAP PUS in 1980 Gcu | `CAPPUS1980` | 5350.0 |
| CAPEX fossil el Dollar/W | `CAPEXFED` | 0.7 |
| CAPEX of renewable el in 1980 Dollar/W | `CAPEXRE1980` | 7.0 |
| CH4 in atm in 1980 GtCH4 | `CH4A1980` | 2.5 |
| Climate.CO2 concentration in 2022 ppm | `CO2C2022` | 420.0 |
| Climate.Observed Warming in 2022 deg C | `OW2022` | 1.35 |
| CO2 Absorbed in Reg Ag tCO2/ha/y | `CO2ARA` | 1.0 |
| CO2 in atmosphere in 1850 GtCO2 | `CO2A1850` | 2200.0 |
| CO2 Release per Ha of Forest Cut tCO2/ha | `CO2RHFC` | 65.0 |
| Construction time PIS y | `CTPIS` | 1.5 |
| Construction Time PIS y | `CTPIS` | 1.5 |
| Construction Time PUS y | `CTPUS` | 1.5 |
| Cost of Capacity in 1980 dollar/cu | `CC1980` | 1.0 |
| Cost of CCS Dollar/tCO2 | `CCCSt` | 95.0 |
| Cost of CCS Dollar/tCO2 | `CCCSt` | 95.0 |
| Cost of Max Fertility Reduction (share of GDP) | `CMFR` | 0.01 |
| Cost of Nuclear El Dollar/kWh | `CNED` | 0.033 |
| Cost of TAs in 2022 GDollar/y | `CTA2022` | 9145.0 |
| Cost per Ton Fertilizer dollar/t | `CTF` | 500.0 |
| Cost Reduction per Doubling in Regenerative Agriculture | `CRDRA` | 0.05 |
| Cost reduction per dubling of sun and wind capacity | `CRDSWC` | 0.2 |
| Crop Yield in Reg Ag t-crop/ha/y | `CYRA` | 5.0 |
| DDI in 1980 y | `DDI` | 1.0 |
| Demand Adjustment Time y | `DAT` | 1.2 |
| Desired Inventory Coverage y | `DIC` | 0.4 |
| Desired Relative Inventory | `DRI` | 1.0 |
| Desired Reserve Capacity | `DRC` | 0.05 |
| Diminishing Return Disposable Income | `DRDI` | 0.5 |
| Diminishing Return Public Spending | `DRPS` | 0.7 |
| Direct Air Capture of CO2 in 2100 GtCO2/y | `DACCO22100` | 8.0 |
| DNC in 1980 | `DNC80` | 4.3 |
| DNCalfa<0 | `DNCA` | 0.0 |
| DNCgamma | `DNCG` | 0.14 |
| DNCmin | `DNCM` | 1.2 |
| Domestic ROTA in 1980 1/y | `DROTA1980` | 0.01 |
| Efficiency of fossil power plant TWh-el/TWh-heat | `EFPP` | 0.345 |
| Excess Demand in 1980 | `ED1980` | 1.0 |
| Exogenous Introduction Period Flag | `EIPF` | 0.0 |
| Exogenous Introduction Period y | `EIP` | 30.0 |
| Experience Gained Before 2022 Mha | `EGB22` | 5.0 |
| Extra Cost of Reg Ag in 2022 dollar/ha/y | `ECRA22` | 400.0 |
| Extra cost per reduced use og non-el FF Dollar/toe | `ECRUNEFF` | 10.0 |
| Extra Domestic ROTA in 2022 1/y | `EDROTA2022` | 0.003 |
| Extra Empowerment Tax From 2022 (share of NI) | `EETF2022` | 0.02 |
| Extra General Tax Rate From 2022 | `EGTRF2022` | 0.01 |
| Extra Heat in 1980 ZJ | `EH1980` | 0.0 |
| Extra Pension Tax From 2022 (share of NI) | `EPTF2022` | 0.02 |
| Extra rate of decline in CH4 per kg crop after 2022 1/y | `ERDCH4KC2022` | 0.01 |
| Extra rate of decline in N2O per kg fertilizer from 2022 | `ERDN2OKF2022` | 0.01 |
| Extra ROC in energy productivity after 2022 1/y | `EROCEPA2022` | 0.004 |
| Extra ROC in Food Sector Productivity from 2022 1/y | `EROCFSP` | 0.0 |
| Extra Transfer or Govmnt Budget to Workers | `ETGBW` | 0.2 |
| Extra use of electricity per reduced use of non-el FF MWh/toe | `EUEPRUNEFF` | 3.0 |
| Fertile Period | `FP` | 20.0 |
| Financial Sector Response Time y | `FSRT` | 1.0 |
| Food Footprint in 1980 | `FF80` | 88450.0 |
| Foreign Capital Inflow Gdollar/y | `FCI` | 0.0 |
| Fossil el cap construction time y | `FECCT` | 3.0 |
| FRA in 1980 | `FRA1980` | 0.9 |
| FRACA Min | `FRACAM` | 0.65 |
| Fraction Achieving Desired Family Size | `FADFS` | 0.8 |
| Fraction Cleared for Grazing | `FCG` | 0.1 |
| Fraction new electrification in 1980 | `FNE1980` | 0.0 |
| Fraction new electrification in 2022 | `FNE2022` | 0.03 |
| Fraction of CO2-sources with CCS in 2022 | `FCO2SCCS2022` | 0.0 |
| Fraction of Extra TA Cost Paid by Extra Taxes | `FETACPET` | 0.5 |
| Fraction of Extra Ta Paid by Owners | `FETPO` | 0.8 |
| Fraction of Govmnt Debt Cancelled in 2022 1/y | `FGDC2022` | 0.1 |
| Fraction of Inflation Compensated (1) | `FIC` | 1.0 |
| Fraction of renewable electricity to hydrogen | `FREH` | 0.0 |
| Fraction Transferred in 1980 | `FT1980` | 0.3 |
| Fraction Unprofitable Activity in TAs | `FUATA` | 0.3 |
| Fraction Women | `FW` | 0.5 |
| GDP per Person in 1980 | `GDPP1980` | 6.4 |
| GDP per Person in 1980 | `GDPP1980` | 6.4 |
| GDP per Person in 1980 kDollar/p/y | `GDPP1980` | 6.4 |
| GDPpp of Technology Leader kDollar/p/k | `GDPTL` | 15.0 |
| GLobal SUrface Mkm2 | `GLSU` | 510.0 |
| Goal for Crop Waste Reduction | `GCWR` | 0.2 |
| Goal for Extra Fertility Reduction | `GEFR` | 0.2 |
| Goal for Extra Income from Commons (share of NI) | `GEIC` | 0.02 |
| Goal for Extra Normal LPR (1) | `GENLPR` | 0.0 |
| Goal for Extra Pension Age y | `GEPA` | 0.0 |
| Goal for fraction new electrification | `GFNE` | 1.0 |
| Goal for Fraction New Red Meat | `GFNRM` | 0.5 |
| Goal for fraction regenerative agriculture | `GFRA` | 0.5 |
| Goal for Income Tax Rate Owners | `GITRO` | 0.3 |
| Goal for renewable el fraction | `GREF` | 1.0 |
| Goal fraction of CO2-sources with CCS | `GFCO2SCCS` | 0.9 |
| Govmnt Consumption Fraction | `GCF` | 0.75 |
| Govmnt DrawDown Period y | `GDDP` | 10.0 |
| Govmnt Payback Period y | `GPP` | 200.0 |
| Govmnt Stimulus From 2022 (share of NI) | `GSF2022` | 0.0 |
| GtCH4 per ppm | `GCH4PP` | 5.0 |
| GtCO2 per ppm | `GCO2PP` | 7.9 |
| GtN2O per ppm | `GN2OPP` | 5.0 |
| Heat required to melt ice kJ/kg | `HRMI` | 333.0 |
| Ice and snow cover excluding Greenland and Antarctica in 1980 Mkm2 | `ISCEGA1980` | 12.0 |
| Income Tax Rate Owners in 1980 | `ITRO1980` | 0.4 |
| Income Tax Rate Owners in 2022 | `ITRO2022` | 0.3 |
| INEQuality in 1980 | `INEQ1980` | 0.61 |
| Inflation Expectation Formation Time y | `IEFT` | 10.0 |
| Inflation Perception Time CB y | `IPTCB` | 1.0 |
| Inflation Target 1/y | `IT` | 0.02 |
| Infrastructure Purchases Ratio in 1980 y | `IPR1980` | 1.2 |
| Inventory Coverage Perception Time y | `ICPT` | 0.25 |
| Investment planning time y | `IPT` | 1.0 |
| Investment Planning Time y | `IPT` | 1.0 |
| Kappa | `KAPPA` | 0.3 |
| kg CH4 per kg crop in 1980 | `KCH4KC1980` | 0.05 |
| kg N2O per kg fertilizer in 1980  | `KN2OKF1980` | 0.11 |
| Kg-Crop per Kg-Red-Meat | `KCKRM` | 24.0 |
| kWh electricity per kg of hydrogen | `KWEPKGH2` | 40.0 |
| Labour Use in 1980 Gph/y | `LAUS1980` | 3060.0 |
| Lambda | `LAMBDA` | 0.7 |
| Land Erosion Rate in 1980 1/y | `LER80` | 0.004 |
| LEalfa | `LEA` | 0.001 |
| LEgamma | `LEG` | 0.15 |
| LEmax | `LEMAX` | 85.0 |
| Life of Capacity PIS in 1980 y | `LCPIS1980` | 15.0 |
| Life of CH4 in atmosphere y | `LCH4A` | 7.5 |
| Life of extra CO2 in atmosphere in 1980 y | `LECO2A1980` | 60.0 |
| Life of N2O in atmosphere y | `LN2OA` | 95.0 |
| Life of renewable el capacity y | `LREC` | 40.0 |
| Mass of ATmosphere Zt | `MAT` | 5.0 |
| Max Fertility Multiplier | `MFM` | 1.6 |
| Max Forest Absorption Multiplier | `MFAM` | 2.0 |
| Max Govmnt Debt Burden y | `MGDB` | 1.0 |
| Max Life Expectancy Multiplier | `MLEM` | 1.1 |
| Max non-fossil CO2 per person tCO2/p/y | `MNFCO2PP` | 0.5 |
| Max Workers Debt Burden y | `MWDB` | 1.0 |
| Maximum Imported ROTA from 2022 1/y | `MIROTA2022` | 0.005 |
| Melting rate surface in 1980 1/y | `MRS1980` | 0.0015 |
| Min WellBeing from Global Warming | `MWBGW` | 0.2 |
| Minimum Relative Inventory Without Inflation | `MRIWI` | 1.07 |
| Mtoe per EJ - calorific equivalent | `MTPEJCE` | 24.0 |
| N2O in atm in 1980 GtN2O | `N2OA1980` | 1.052 |
| Normal Bank Operating Margin 1/y | `NBOM` | 0.015 |
| Normal Basic Bank Margin 1/y | `NBBM` | 0.005 |
| Normal increase in energy efficiency 1/y | `NIEE` | 0.01 |
| Normal K | `NK` | 0.3 |
| Normal life of fossil el capacity y | `NLFEC` | 40.0 |
| Normal LPR in 1980 (1) | `NLPR80` | 0.85 |
| Normal Reform Delay y | `NRD` | 30.0 |
| Normal Signal Rate 1/y | `NSR` | 0.02 |
| Nuclear capacity up-time kh/y | `NCUT` | 8.0 |
| OBserved WArming in 2022 deg C | `OBWA2022` | 1.35 |
| OBserved WArming in 2022 deg C | `OBWA2022` | 1.35 |
| Observed Warming in 2022 deg C | `OW2022` | 1.35 |
| Observed Warming in 2022 deg C | `OW2022` | 1.35 |
| OGRR in 1980 1/y | `OGRR80` | 0.004 |
| OPEX fossil el Dollar/kWh | `OPEXFED` | 0.02 |
| OPEX renewable el Dollar/kWh | `OPEXRED` | 0.001 |
| Optimal output in 1980 Gu/y | `OO1980` | 28087.0 |
| Owner Savings Fraction in 1980 | `OSF1980` | 0.9 |
| Perception delay y | `PD` | 5.0 |
| Persons per Full-Time Job in 1980 p/ftj | `PFTJ80` | 1.0 |
| Persons per Full-Time Job p/ftj | `PFTJ` | 1.0 |
| Price Per Unit /u | `PPU` | 1.0 |
| Price per Unit dollar/u | `PRUN` | 1.0 |
| PRice per UNit dollar/u | `PRUN` | 1.0 |
| Rate of decline in CH4 per kg crop 1/y | `RDCH4KC` | 0.01 |
| Rate of decline in N2O per kg fertilizer 1/y | `RDN2OKF` | 0.01 |
| Real Wage Erosion Rate 1/y | `RWER` | 0.015 |
| Renewable capacity up-time kh/y | `RCUT` | 3.0 |
| Renewable el contruction time y | `RECT` | 3.0 |
| Renewable el fraction in 1980 | `REFF1980` | 0.065 |
| Renewable el fraction in 2022 | `REFF2022` | 0.23 |
| ROC in ECLR in 1980 1/y | `ROCECLR80` | 0.02 |
| ROC in Fertilizer Productivity 1/y | `ROCFP` | 0.01 |
| ROC in Food Sector Productivity 1/y | `ROCFSP` | 0.002 |
| ROC in tCO2 per toe 1/y | `ROCTCO2PT` | -0.003 |
| Sales Averaging Time y | `SAT` | 1.0 |
| Sales Tax Rate | `STR` | 0.03 |
| Satisfactory Public Spending | `SPS` | 0.3 |
| sCBCeoFRA<0: Corporate Borrowing Cost Effect on FRA | `CBCEFRA` | -0.8 |
| sCO2CeoACY>0: CO2 Concentration Effect on Average Crop Yeld | `CO2CEACY` | 0.3 |
| sEDeoFRA>0: Excess Demand Effect on FRA | `EDEFRA` | 5.0 |
| sEDeoLOC>0: Excess Demand Effect on Life of Capacity | `EDELCM` | 0.5 |
| sFBeoCLE<0: Crob Balance Effect on CropLand Expansion | `CBECLE` | -0.03 |
| sFCUTeoLOFC>0 | `sFCUTLOFC` | 0.5 |
| sFFLReoOGRR<0: Fraction Forestry Land Remaining Effect on Old Growth Removal Rate Multiplier | `FFLREOGRRM` | -5.0 |
| sFUeoLER>0: Fertilizer Use Effect on Land Erosion Rate | `FUELER` | 0.02 |
| sFUeoSQ<0: Fertilizer Use Effect on Soil Quality | `FUESQ` | -0.001 |
| sGDPeoOSR<0 | `GDPOSR` | -0.06 |
| sGDPppeoFRACA<0: GDP per Person Effect on FRACA | `GDPPEFRACA` | -0.2 |
| sGDPppeoROCCLR<0: GDPP Effect on Rate Of Change in Capital Labour Ratio | `GDPPEROCCLRM` | -0.1 |
| sGReoCR<0: Growth Rate effect on Credit Risk | `GRCR` | 0.0 |
| sGWeoAW<0: Global Warming Effect on Average WellBeing from Global Warming Flag | `GWEAWBGWF` | -0.58 |
| Signal Rate Adjustment Time y | `SRAT` | 1.0 |
| sIIEeoROTA<0: Inequality Index Effect on ROTA | `IIEEROTA` | -0.1 |
| sIIeoAW<0: Inequality Effect on Average WellBeing from Inequality Flag | `IEAWBIF` | -0.6 |
| sINEeoLOK<0: INequity Effect on LOgistic K | `INELOK` | -0.5 |
| sINeoSR>0: INflation effect on Signal Rate | `INSR` | 0.7 |
| sINVeoDDI < 0: INVentory Effect On Delivery Delay Index | `INVEODDI` | -0.6 |
| sINVeoIN < 0: INVentory Effect On INflation | `INVEOIN` | -0.26 |
| sINVeoSWI < 0: INVentory Effect On Shifts Worked Index | `INVEOSWI` | -0.6 |
| sIPReoVPSS>0: Infrastructure Purchase Ratio effect on Value of Pubblic Services Supplied | `IPRVPSS` | 1.0 |
| sLEeoPa>0: Life Expectancy Effect on Pension Age | `LEEPA` | 0.75 |
| sLPeoAWP>0: PArtecipation Effect on Average WellBeing Flag | `PAEAWBF` | 0.5 |
| sOWeoACY<0: Observed Warming Effect on Average Crop Yeld | `OWEACY` | -0.3 |
| sOWeoCOC>0: Observed Warming Effect on Cost of Capacity | `OWECCM` | 0.2 |
| sOWeoLE<0: Observed Warming Effect on Life Expectancy | `OWELE` | -0.02 |
| sOWeoLOC<0: Observed Warming Effect on Life of Capacity | `OWELCM` | -0.1 |
| sOWeoLoCO2>0 | `SOWLCO2` | 1.0 |
| sOWeoTFP<0: Observed Warming Effect on Total Factor Productivity | `OWETFP` | -0.1 |
| sOWeoWV>0 | `OWWV` | 0.18 |
| sPPReoSTE<0: Progress Effect on Social Tension Flag | `PESTF` | -15.0 |
| sPUNeoLPR>0: Perceived Unemployment Effect on Labour Participation Rate | `PUELPR` | 0.05 |
| sROPeoAW>0: PRogress Effect on Average WellBeing Flag | `PREAWBF` | 6.0 |
| sSCeoROTA>0: State Capacity effect on Rate Of Technological Advance | `SCROTA` | 0.5 |
| SSP2 Family Action from 2022 Flag | `SSP2FA2022F` | 1.0 |
| SSP2 land management action from 2022? | `SSP2LMA` | 1.0 |
| sSTEeoRD>0: Social Tension Effect on Reform Delay Flag | `STEERDF` | 1.0 |
| sSTReoRD<0: Social Trust Effect on Reform Delay Flag | `STRERDF` | -1.0 |
| State Capacity in 1980 (fraction of GDP) | `SC1980` | 0.3 |
| sTIeoNHW<0: Time Effect on Number Hours Worked | `TENHW` | -0.03 |
| Sufficient Relative Inventory | `SRI` | 1.0 |
| Sun and wind capacity in 1980 GW | `SWC1980` | 10.0 |
| sUNeoSR<0: UNemployment effect on Signal Rate | `UNSR` | -1.5 |
| Surface vs deep rate | `SVDR` | 4.0 |
| Sustainable Fertiliser Use kgN/ha/y | `SFU` | 20.0 |
| SWI in 1980 | `SWI` | 1.0 |
| sWSOeoCLR>0: Worker Share of Output Effect on Capital Labour Ratio  | `WSOECLR` | 1.05 |
| sWSOeoFRA<0: Worker Share of Output Effect on FRA | `WSOEFRA` | -2.5 |
| sWSOeoLPR>0: Worker Share of Output Effect on Labour Participation Rate | `WSOELPR` | 0.2 |
| sWVeoWVF>0 | `WVWVF` | 3.0 |
| tCO2 per tCH4 | `TCO2PTCH4` | 2.75 |
| tCO2e/tCH4 | `TCO2ETCH4` | 23.0 |
| tCO2e/tCO2 | `TCO2ETCO2` | 1.0 |
| tCO2e/tN2O | `TCO2ETN2O` | 7.0 |
| Threshold Disposable Income kdollar/p/y | `TDI` | 15.0 |
| Threshold FFLR | `TFFLR` | 0.2 |
| Threshold Inequality | `TI` | 0.5 |
| Threshold Participation | `TP` | 0.8 |
| Threshold Progress Rate 1/y | `TPR` | 0.02 |
| Threshold Public Spending kdollar/p/y | `TPS` | 3.0 |
| Threshold Warming deg C | `TW` | 1.0 |
| Time to adapt to higher income y | `TAHI` | 10.0 |
| Time to Adjust Budget y | `TAB` | 1.0 |
| Time to Adjust Hours Worked y | `TAHW` | 5.0 |
| Time to Adjust Owner Consumption y | `TAOC` | 1.0 |
| Time to Adjust Shifts y | `TAS` | 0.24 |
| Time to Adjust Worker Consumption y | `TAWC` | 1.0 |
| Time to Change Reform Delay y | `TCRD` | 10.0 |
| Time to Enter/Leave Labor Market y | `TELLM` | 5.0 |
| Time to Establish Growth Rate y | `TEGR` | 4.0 |
| Time to Establish Social Trust y | `TEST` | 10.0 |
| Time to Implement New Taxes y | `TINT` | 5.0 |
| Time to observe excess demand y | `TOED` | 1.0 |
| toe per tH2 | `TPTH2` | 10.0 |
| Ton Crops per Toe Biofuel | `TCTB` | 0.0 |
| Ton per m3 ice | `TPM3I` | 0.95 |
| Traditional cost of electricity Dollar/kWh | `TCE` | 0.03 |
| Traditional cost of fossil fuels for non-el use Dollar/toe | `TCFFFNEU` | 240.0 |
| Transfer rate surface-abyss in 1980 1/y | `TRSA1980` | 0.01 |
| Transfer rate surface-space in 1980 1/y | `TRSS1980` | 0.01 |
| Transmission cost Dollar/kWh | `TC` | 0.02 |
| TWh-heat per EJ - calorific equivalent | `TWHPEJCE` | 278.0 |
| Unconventional Stimulus in PIS from 2022 (share of GDP) | `USPIS2022` | 0.01 |
| Unconventional Stimulus in PUS from 2022 (share of GDP) | `USPUS2022` | 0.01 |
| Unemployment Perception Time CB y | `UPTCB` | 1.0 |
| Unemployment Target | `UT` | 0.05 |
| Urban Development Time y | `UDT` | 10.0 |
| Urban Land per Population ha/p | `ULP` | 0.05 |
| Warming from Extra Heat deg/ZJ | `WFEH` | 0.0006 |
| Warming in 1980 deg C | `WA1980` | 0.4 |
| Water Vapour Concentration in 1980 g/kg | `WVC1980` | 2.0 |
| Water Vapour Feedback in 1980 W/m2 | `WVF1980` | 0.9 |
| Worker Consumption Fraction | `WCF` | 0.9 |
| Worker Drawdown Period y | `WDP` | 10.0 |
| Worker Payback Period y | `WPP` | 20.0 |
| XExtra TA Cost in 2022 (share of GDP) | `XETAC2022` | 0.0 |
| XExtra TA Cost in 2100 (share of GDP) | `XETAC2100` | 0.0 |

[Randers2022]: https://www.clubofrome.org/wp-content/uploads/2022/09/220916_E4A_technical-note.pdf
[Dixson2022]: https://www.clubofrome.org/publication/earth4all-book/
