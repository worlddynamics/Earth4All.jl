### Summary
We describe the Food and land sector of the Earth4All model, by referring to the Food and land view of the Vensim model implementation.

### The Food and land endogenous variables

In the following list, only the initial values that cannot be implicitly computed within the sector are indicated (these values are taken from either the functions or the tables of Vensim).

| Vensim name | Name | Initial value |
| --- | --- | --- |
| Acceptable Loss of Forestry Land | `ALFL` |  |
| Amount of Fertilizer Saved in Reg Ag kgN/ha/y | `AFSRA` |  |
| Average Crop Yield t-crop/ha/y | `ACY` |  |
| BArren LAnd Mha | `BALA` | 3000.0 |
| BIofuels USe Mtoe/y | `BIUS` |  |
| Change in Soil Quality in Conv Ag t-crop/ha/y/y | `CSQCA` |  |
| CO2 Absorption in Forestry Land GtCO2/y | `CO2AFL` |  |
| CO2 Absorption in Forestry Land per Ha tCO2/ha/y | `CO2AFLH` |  |
| CO2 Effect on Land Yield | `CO2ELY` |  |
| CO2 Emissions from LULUC GtCO2/y | `CO2ELULUC` |  |
| CO2 Release from Forest Cut GtCO2/y | `CO2RFC` |  |
| Cost Index for Regenerative Agriculture | `CIRA` |  |
| COst of FErtilizer Gdollar/y | `COFE` |  |
| COst of FOod Gdollar/y | `COFO` |  |
| Cost of Regenerative Agriculture Gdollar/y | `CRA` |  |
| CRop BAlance | `CRBA` |  |
| CRop DEmand Mt-crop/y | `CRDE` |  |
| CRop SUpply (after 20 percent waste) Mt-crop/y | `CRSU` |  |
| Crop Supply Reg Ag Mt-crop/y | `CSRA` |  |
| CRop USe Mt/y | `CRUS` |  |
| CRop USe per Person t-crop/p/y | `CRUSP` |  |
| Crop Waste Reduction | `CWR` |  |
| CRopland EXpansion Mha/y | `CREX` |  |
| Cropland Expansion Multiplier | `CEM` |  |
| CRopland EXpansion Rate 1/y | `CREXR` |  |
| CRopland LOss Mha/y | `CRLO` |  |
| CRopLAnd Mha | `CRLA` | 1450.0 |
| CRops for BIofuel Mt-crop/y | `CRBI` |  |
| Demand for Red Meat Mt-red-meat/y | `DRM` |  |
| Demand for Red Meat per Person kg-red-meat/p/y | `DRMP` |  |
| Desired Crop Supply Conv Ag Mt-crop/y | `DCSCA` |  |
| Desired Crop Supply Mt-crop/y | `DCS` |  |
| Desired Crop Yield in Conv Ag t-crop/ha/y | `DCYCA` |  |
| Extra CO2 Absorption in Reg Ag GtCO2/y | `ECO2ARA` |  |
| Extra Cost of Food Turnaround as Share of GDP | `ECFTSGDP` |  |
| Extra Cost of Food Turnaround Gdollar/y | `ECFT` |  |
| Extra Cost of Reg Ag dollar/ha/y | `ECRA` |  |
| FEed for Red Meat Mt-crop/y | `FERM` |  |
| Fertilizer Cost Reduction Gdollar/y | `FCR` |  |
| Fertilizer Effect on Erosion Rate | `FEER` |  |
| Fertilizer Productivity Index (1980=1) | `FPI` |  |
| Fertilizer Use in Conv Ag kgN/ha/y | `FUCA` |  |
| FErtilizer USe Mt/y | `FEUS` |  |
| FErtilizer USe per Person kg/p/y | `FUP` |  |
| FFLReoOGRR: Fraction Forestry Land Remaining Effect on Old Growth Removal Rate | `FFLREOGRR` |  |
| FOod FOotprint | `FOFO` |  |
| Food Footprint Index (1980=1) | `FFI` |  |
| Food Sector Productivity Index (1980=1) | `FSPI` |  |
| Forest Absorption Multipler | `FAM` |  |
| FOrestry LAnd Mha | `FOLA` | 1100.0 |
| Fraction Forestry Land Remaining | `FFLR` |  |
| Fraction New Red Meat | `FNRM` |  |
| Fraction Regenerative Agriculture | `FRA` |  |
| GRazing LAnd Mha | `GRLA` | 3300.0 |
| Grazing Land Yied in 1980 kg-red-meat/ha/y | `GLY80` |  |
| Grazing Land Yield kg-red-meat/ha/y | `GLY` |  |
| Indicated Urban Land Mha | `IUL` |  |
| Land Erosion Multiplier | `LEM` |  |
| Land Erosion Rate 1/y | `LER` |  |
| LOss of CRopland Mha/y | `LOCR` |  |
| Loss of Forest Land Mha/y | `LFL` |  |
| New Forestry Land Mha/y | `NFL` |  |
| New Grazing Land Mha/y | `NGL` |  |
| Number of Doublings in Reg Ag | `NDRA` |  |
| Old Growth Forest Area Mha | `OGFA` | 2600.0 |
| Old Growth Removal Mha/y | `OGR` |  |
| Old Growth Removal Rate 1/y | `OGRR` |  |
| Old Growth Removal Rate Multiplier | `OGRRM` |  |
| Perceived Crop Balance | `PCB` |  |
| Potential Red Meat from Grazing Land Mt-red-meat/y | `PRMGL` |  |
| Red Meat from Feedlots Mt-red-meat/y | `RMF` |  |
| Red Meat from Grazing Land Mt-red-meat/y | `RMGL` |  |
| Red meat Supply per Person kg-red-meat/p/y | `RMSP` |  |
| Regenerative Agriculture Area Mha | `RAA` |  |
| ROC in Soil Quality in Conv Ag 1/y | `ROCSQCA` |  |
| Soil Quality Index in Conv Ag (1980=1) | `SQICA` | 1.0 |
| Total Forest Area Mha | `TFA` |  |
| Traditional Fertilizer Use in Conv Ag kgN/ha/y | `TFUCA` |  |
| Traditional Use of Crops Ex Red Meat Mt/y | `TUCERM` |  |
| Traditional Use of Crops Ex Red Meat per Person kg-crop/p/y | `TUCERMP` |  |
| Traditional Use of Crops Mt/y | `TUC` |  |
| Traditional Use of Crops per Person kg-crop/p/y | `TUCP` |  |
| Traditional Use of Feed for Red Meat Mt-crop/y | `TUFRM` |  |
| Traditional Use of Red Meat per Person kg-red-meat/p/y | `TURMP` |  |
| URban EXpansion Mha/y | `UREX` |  |
| URban LAnd Mha | `URLA` | 215.0 |
| Warming Effect on Land Yield | `WELY` |  |

### The Food and land parameters

| Vensim name | Name | Value |
| --- | --- | --- |
| Agriculture as Fraction of GDP | `AFGDP` | 0.05 |
| Climate.CO2 concentration in 2022 ppm | `CO2C2022` | 420.0 |
| Climate.Observed Warming in 2022 deg C | `OW2022` | 1.35 |
| CO2 Absorbed in Reg Ag tCO2/ha/y | `CO2ARA` | 1.0 |
| CO2 Release per Ha of Forest Cut tCO2/ha | `CO2RHFC` | 65.0 |
| Cost per Ton Fertilizer dollar/t | `CTF` | 500.0 |
| Cost Reduction per Doubling in Regenerative Agriculture | `CRDRA` | 0.05 |
| Crop Yield in Reg Ag t-crop/ha/y | `CYRA` | 5.0 |
| Desired Reserve Capacity | `DRC` | 0.05 |
| Experience Gained Before 2022 Mha | `EGB22` | 5.0 |
| Extra Cost of Reg Ag in 2022 dollar/ha/y | `ECRA22` | 400.0 |
| Extra ROC in Food Sector Productivity from 2022 1/y | `EROCFSP` | 0.0 |
| Food Footprint in 1980 | `FF80` | 88450.0 |
| Fraction Cleared for Grazing | `FCG` | 0.1 |
| Goal for Crop Waste Reduction | `GCWR` | 0.2 |
| Goal for Fraction New Red Meat | `GFNRM` | 0.5 |
| Goal for fraction regenerative agriculture | `GFRA` | 0.5 |
| Kg-Crop per Kg-Red-Meat | `KCKRM` | 24.0 |
| Land Erosion Rate in 1980 1/y | `LER80` | 0.004 |
| Max Forest Absorption Multiplier | `MFAM` | 2.0 |
| OGRR in 1980 1/y | `OGRR80` | 0.004 |
| ROC in Fertilizer Productivity 1/y | `ROCFP` | 0.01 |
| ROC in Food Sector Productivity 1/y | `ROCFSP` | 0.002 |
| sCO2CeoACY>0: CO2 Concentration Effect on Average Crop Yeld | `CO2CEACY` | 0.3 |
| sFBeoCLE<0: Crob Balance Effect on CropLand Expansion | `CBECLE` | -0.03 |
| sFFLReoOGRR<0: Fraction Forestry Land Remaining Effect on Old Growth Removal Rate Multiplier | `FFLREOGRRM` | -5.0 |
| sFUeoLER>0: Fertilizer Use Effect on Land Erosion Rate | `FUELER` | 0.02 |
| sFUeoSQ<0: Fertilizer Use Effect on Soil Quality | `FUESQ` | -0.001 |
| sOWeoACY<0: Observed Warming Effect on Average Crop Yeld | `OWEACY` | -0.3 |
| SSP2 land management action from 2022? | `SSP2LMA` | 1.0 |
| Sustainable Fertiliser Use kgN/ha/y | `SFU` | 20.0 |
| Threshold FFLR | `TFFLR` | 0.2 |
| Ton Crops per Toe Biofuel | `TCTB` | 0.0 |
| Urban Development Time y | `UDT` | 10.0 |
| Urban Land per Population ha/p | `ULP` | 0.05 |

### The Food and land exogenous variables

| Vensim name | Name | Original sector |
| --- | --- | --- |
| CO2 Concentration in Atm ppm | `CO2CA` | Climate |
| GDP | `GDP` | Inventory |
| GDP per Person kdollar/p/y | `GDPP` | Population |
| Introduction Period for Policy y | `IPP` | Wellbeing |
| OBserved WArming deg C | `OBWA` | Climate |
| Population Mp | `POP` | Population |
