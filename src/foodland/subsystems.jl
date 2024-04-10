include("../functions.jl")
@register_symbolic ramp(x, slope, startx, endx)


@variables t
D = Differential(t)

function foodland(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters AFGDP = params[:AFGDP] [description = "Agriculture as Fraction of GDP"]
    @parameters CBECLE = params[:CBECLE] [description = "sFBeoCLE<0: Crob Balance Effect on CropLand Expansion"]
    @parameters CO2ARA = params[:CO2ARA] [description = "CO2 Absorbed in Reg Ag tCO2/ha/y"]
    @parameters CO2C2022 = params[:CO2C2022] [description = "Climate.CO2 concentration in 2022 ppm"]
    @parameters CO2CEACY = params[:CO2CEACY] [description = "sCO2CeoACY>0: CO2 Concentration Effect on Average Crop Yeld"]
    @parameters CO2RHFC = params[:CO2RHFC] [description = "CO2 Release per Ha of Forest Cut tCO2/ha"]
    @parameters CRDRA = params[:CRDRA] [description = "Cost Reduction per Doubling in Regenerative Agriculture"]
    @parameters CTF = params[:CTF] [description = "Cost per Ton Fertilizer dollar/t"]
    @parameters CYRA = params[:CYRA] [description = "Crop Yield in Reg Ag t-crop/ha/y"]
    @parameters DRC = params[:DRC] [description = "Desired Reserve Capacity"]
    @parameters ECRA22 = params[:ECRA22] [description = "Extra Cost of Reg Ag in 2022 dollar/ha/y"]
    @parameters EGB22 = params[:EGB22] [description = "Experience Gained Before 2022 Mha"]
    @parameters EROCFSP = params[:EROCFSP] [description = "Extra ROC in Food Sector Productivity from 2022 1/y"]
    @parameters FCG = params[:FCG] [description = "Fraction Cleared for Grazing"]
    @parameters FF80 = inits[:CRLA] * params[:FU80] [description = "Food Footprint in 1980"]
    @parameters FFLREOGRRM = params[:FFLREOGRRM] [description = "sFFLReoOGRR<0: Fraction Forestry Land Remaining Effect on Old Growth Removal Rate Multiplier"]
    @parameters FU80 = params[:FU80] [description = "Fertilizer Use in 1980 Mt/y"]
    @parameters FUELER = params[:FUELER] [description = "sFUeoLER>0: Fertilizer Use Effect on Land Erosion Rate"]
    @parameters FUESQ = params[:FUESQ] [description = "sFUeoSQ<0: Fertilizer Use Effect on Soil Quality"]
    @parameters GCWR = params[:GCWR] [description = "Goal for Crop Waste Reduction"]
    @parameters GFNRM = params[:GFNRM] [description = "Goal for Fraction New Red Meat"]
    @parameters GFRA = params[:GFRA] [description = "Goal for fraction regenerative agriculture"]
    @parameters KCKRM = params[:KCKRM] [description = "Kg-Crop per Kg-Red-Meat"]
    @parameters LER80 = params[:LER80] [description = "Land Erosion Rate in 1980 1/y"]
    @parameters MFAM = params[:MFAM] [description = "Max Forest Absorption Multiplier"]
    @parameters OGRR80 = params[:OGRR80] [description = "OGRR in 1980 1/y"]
    @parameters OW2022 = params[:OW2022] [description = "Climate.Observed Warming in 2022 deg C"]
    @parameters OWEACY = params[:OWEACY] [description = "sOWeoACY<0: Observed Warming Effect on Average Crop Yeld"]
    @parameters ROCFP = params[:ROCFP] [description = "ROC in Fertilizer Productivity 1/y"]
    @parameters ROCFSP = params[:ROCFSP] [description = "ROC in Food Sector Productivity 1/y"]
    @parameters SFU = params[:SFU] [description = "Sustainable Fertiliser Use kgN/ha/y"]
    @parameters SSP2LMA = params[:SSP2LMA] [description = "SSP2 land management action from 2022?"]
    @parameters TCTB = params[:TCTB] [description = "Ton Crops per Toe Biofuel"]
    @parameters TFFLR = params[:TFFLR] [description = "Threshold FFLR"]
    @parameters UDT = params[:UDT] [description = "Urban Development Time y"]
    @parameters ULP = params[:ULP] [description = "Urban Land per Population ha/p"]

    @variables ACY(t) [description = "Average Crop Yield t-crop/ha/y"]
    @variables ALFL(t) [description = "Acceptable Loss of Forestry Land (1)"]
    @variables AFSRA(t) [description = "Amount of Fertilizer Saved in Reg Ag kgN/ha/y"]
    @variables BALA(t) = inits[:BALA] [description = "BArren LAnd Mha"]
    @variables BIUS(t) [description = "BIofuels USe Mtoe/y"]
    @variables CEM(t) [description = "Cropland Expansion Multiplier (1)"]
    @variables CIRA(t) [description = "Cost Index for Regenerative Agriculture (1)"]
    @variables CO2AFL(t) [description = "CO2 Absorption in Forestry Land GtCO2/y"]
    @variables CO2AFLH(t) [description = "CO2 Absorption in Forestry Land tCO2/ha/y"]
    @variables CO2ELULUC(t) [description = "CO2 Emissions from LULUC GtCO2/y"]
    @variables CO2ELY(t) [description = "CO2 Effect on Land Yield (1)"]
    @variables CO2RFC(t) [description = "CO2 Release from Forest Cut GtCO2/y"]
    @variables COFE(t) [description = "COst of FErtilizer Gdollar/y"]
    @variables COFO(t) [description = "COst of FOod Gdollar/y"]
    @variables CRA(t) [description = "Cost of Regenerative Agriculture Gdollar/y"]
    @variables CRBA(t) [description = "CRop BAlance (1)"]
    @variables CRBI(t) [description = "CRops for BIofuel Mt-crop/y"]
    @variables CRDE(t) [description = "CRop DEmand Mt-crop/y"]
    @variables CREX(t) [description = "CRopland EXpansion Mha/y"]
    @variables CREXR(t) [description = "CRopland EXpansion Rate 1/y"]
    @variables CRLA(t) = inits[:CRLA] [description = "CRopLAnd Mha"]
    @variables CRLO(t) [description = "CRopland LOss Mha/y"]
    @variables CRSU(t) [description = "CRop SUpply (after 20 % waste) Mt-crop/y"]
    @variables CRUS(t) [description = "CRop USe Mt/y"]
    @variables CRUSP(t) [description = "CRop USe per Person t-crop/p/y"]
    @variables CSQCA(t) [description = "Change in Soil Quality in Conv Ag t-crop/ha/y/y"]
    @variables CSRA(t) [description = "Crop Supply Reg Ag Mt-crop/y"]
    @variables CWR(t) [description = "Crop Waste Reduction (1)"]
    @variables DCS(t) [description = "Desired Crop Supply Mt-crop/y"]
    @variables DCSCA(t) [description = "Desired Crop Supply Conv Ag Mt-crop/y"]
    @variables DCYCA(t) [description = "Desired Crop Yield in Conv Ag t-crop/ha/y"]
    @variables DRM(t) [description = "Demand for Red Meat Mt-red-meat/y"]
    @variables DRMP(t) [description = "Demand for Red Meat per Person kg-red-meat/p/y"]
    @variables ECFT(t) [description = "Extra Cost of Food Turnaround Gdollar/y"]
    @variables ECFTSGDP(t) [description = "Extra Cost of Food Turnaround as Share of GDP (1)"]
    @variables ECO2ARA(t) [description = "Extra CO2 Absorption in Reg Ag GtCO2/y"]
    @variables ECRA(t) [description = "Extra Cost of Reg Ag dollar/ha/y"]
    @variables FAM(t) [description = "Forest Absorption Multipler (1)"]
    @variables FCR(t) [description = "Fertilizer Cost Reduction Gdollar/y"]
    @variables FEER(t) [description = "Fertilizer Effect on Erosion Rate (1)"]
    @variables FERM(t) [description = "FEed for Red Meat Mt-crop/y"]
    @variables FEUS(t) [description = "FErtilizer USe Mt/y"]
    @variables FFI(t) [description = "Food Footprint Index (1980=1)"]
    @variables FFLR(t) [description = "Fraction Forestry Land Remaining (1)"]
    @variables FFLREOGRR(t) [description = "FFLReoOGRR"]
    @variables FNRM(t) [description = "Fraction New Red Meat (1)"]
    @variables FOFO(t) [description = "FOod FOotprint"]
    @variables FOLA(t) = inits[:FOLA] [description = "FOrestry LAnd Mha"]
    @variables FPI(t) [description = "Fertilizer Productivity Index (1980=1)"]
    @variables FRA(t) [description = "Fraction Regenerative Agriculture (1)"]
    @variables FSPI(t) [description = "Food Sector Productivity Index (1980=1)"]
    @variables FUCA(t) [description = "Fertilizer Use in Conv Ag kgN/ha/y"]
    @variables FUP(t) [description = "FErtilizer USe per Person kg/p/y"]
    @variables GLY(t) [description = "Grazing Land Yield kg-red-meat/ha/y"]
    @variables GLY80(t) [description = "Grazing Land Yied in 1980 kg-red-meat/ha/y"]
    @variables GRLA(t) = inits[:GRLA] [description = "GRazing LAnd Mha"]
    @variables IUL(t) [description = "Indicated Urban Land Mha"]
    @variables LERM(t) [description = "Land ERosion Multiplier (1)"]
    @variables LER(t) [description = "Land Erosion Rate 1/y"]
    @variables LFL(t) [description = "Loss of Forest Land Mha/y"]
    @variables LOCR(t) [description = "LOss of CRopland Mha/y"]
    @variables NDRA(t) [description = "Number of Doublings in Reg Ag (1)"]
    @variables NFL(t) [description = "New Forestry Land Mha/y"]
    @variables NGL(t) [description = "New Grazing Land Mha/y"]
    @variables OGFA(t) = inits[:OGFA] [description = "Old Growth Forest Area Mha 1"]
    @variables OGRE(t) [description = "Old Growth Removal Mha/y"]
    @variables OGRR(t) [description = "Old Growth Removal Rate 1/y"]
    @variables OGRRM(t) [description = "Old Growth Removal Rate Multiplier (1)"]
    @variables PCB(t) [description = "Perceived Crop Balance (1)"]
    @variables PRMGL(t) [description = "Potential Red Meat from Grazing Land Mt-red-meat/y"]
    @variables RAA(t) [description = "Regenerative Agriculture Area Mha"]
    @variables RMF(t) [description = "Red Meat from Feedlots Mt-red-meat/y"]
    @variables RMGL(t) [description = "Red Meat from Grazing Land Mt-red-meat/y"]
    @variables RMSP(t) [description = "Red meat Supply per Person kg-red-meat/p/y"]
    @variables ROCSQCA(t) [description = "ROC in Soil Quality in Conv Ag 1/y"]
    @variables SQICA(t) = inits[:SQICA] [description = "Soil Quality Index in Conv Ag (1980=1)"]
    @variables TFA(t) [description = "Total Forest Area Mha"]
    @variables TFUCA(t) [description = "Traditional Fertilizer Use in Conv Ag kgN/ha/y"]
    @variables TUC(t) [description = "Traditional Use of Crops Mt/y"]
    @variables TUCERM(t) [description = "Traditional Use of Crops Ex Red Meat Mt/y"]
    @variables TUCERMP(t) [description = "Traditional Use of Crops Ex Red Meat per Person kg-crop/p/y"]
    @variables TUCP(t) [description = "Traditional Use of Crops per Person kg-crop/p/y"]
    @variables TUFRM(t) [description = "Traditional Use of Feed for Red Meat Mt-crop/y"]
    @variables TURMP(t) [description = "Traditional Use of Red Meat per Person kg-red-meat/p/y"]
    @variables UREX(t) [description = "URban EXpansion Mha/y"]
    @variables URLA(t) = inits[:URLA] [description = "URban LAnd Mha"]
    @variables WELY(t) [description = "Warming Effect on Land Yield (1)"]

    @variables CO2CA(t)
    @variables GDP(t)
    @variables GDPP(t)
    @variables IPP(t)
    @variables OW(t)
    @variables POP(t)

    eqs = []

    add_equation!(eqs, ACY ~ (DCYCA * (1 - FRA) * SQICA + CYRA * FRA) * CO2ELY * WELY)
    add_equation!(eqs, ALFL ~ 1 - exp(-FFLR / TFFLR))
    add_equation!(eqs, AFSRA ~ 268 - SFU)
    add_equation!(eqs, D(BALA) ~ CRLO)
    add_equation!(eqs, BIUS ~ withlookup(t, [(1980.0, 0.0), (1990.0, 0.0), (2000.0, 0.0), (2020.0, 0.0), (2100.0, 0.0)]))
    add_equation!(eqs, CEM ~ IfElse.ifelse(t > 2022, 1 - SSP2LMA * ramp(t, (1 - 0) / 78, 2022, 2100), 1))
    add_equation!(eqs, CIRA ~ (1 - CRDRA)^NDRA)
    add_equation!(eqs, CO2AFL ~ FOLA * (CO2AFLH / 1000) * CO2ELY * WELY)
    add_equation!(eqs, CO2AFLH ~ 1.6 * FAM)
    add_equation!(eqs, CO2ELULUC ~ CO2RFC - CO2AFL - ECO2ARA)
    add_equation!(eqs, CO2ELY ~ IfElse.ifelse(t > 2022, 1 + CO2CEACY * (CO2CA / CO2C2022 - 1), 1))
    add_equation!(eqs, CO2RFC ~ ((OGRE + CREX) * CO2RHFC) / 1000)
    add_equation!(eqs, COFE ~ FEUS * CTF / 1000)
    add_equation!(eqs, COFO ~ AFGDP * GDP + CRA + COFE)
    add_equation!(eqs, CRA ~ (ECRA * RAA) / 1000)
    add_equation!(eqs, CRBA ~ CRUS / DCS)
    add_equation!(eqs, CRBI ~ BIUS * TCTB)
    add_equation!(eqs, CRDE ~ (TUCERM + FERM + CRBI))
    add_equation!(eqs, CREX ~ IfElse.ifelse(FOLA > 0, CRLA * CREXR, 0) * ALFL * CEM)
    add_equation!(eqs, CREXR ~ 1 / 200 + CBECLE * (PCB - 1))
    add_equation!(eqs, D(CRLA) ~ CREX - CRLO - UREX)
    add_equation!(eqs, CRLO ~ CRLA * LER)
    add_equation!(eqs, CRSU ~ ACY * CRLA)
    add_equation!(eqs, CRUS ~ CRSU * (1 + CWR))
    add_equation!(eqs, CRUSP ~ CRUS / POP)
    add_equation!(eqs, CSQCA ~ ROCSQCA * SQICA)
    add_equation!(eqs, CSRA ~ CYRA * CRLA * FRA)
    add_equation!(eqs, CWR ~ ramp(t, GCWR / IPP, 2022, 2022 + IPP))
    add_equation!(eqs, DCS ~ CRDE)
    add_equation!(eqs, DCSCA ~ DCS - CSRA)
    add_equation!(eqs, DCYCA ~ DCSCA / (CRLA * (1 - FRA)))
    add_equation!(eqs, DRM ~ ((POP * DRMP) / 1000) * (1 - FNRM))
    add_equation!(eqs, DRMP ~ TURMP)
    add_equation!(eqs, ECFT ~ CRA - FCR)
    add_equation!(eqs, ECFTSGDP ~ ECFT / GDP)
    add_equation!(eqs, ECO2ARA ~ RAA * CO2ARA / 1000)
    add_equation!(eqs, ECRA ~ ECRA22 * CIRA)
    add_equation!(eqs, FAM ~ IfElse.ifelse(t > 2022, 1 + SSP2LMA * ramp(t, (MFAM - 1) / 78, 2022, 2100), 1))
    add_equation!(eqs, FCR ~ (AFSRA / 1000) * RAA * CTF)
    add_equation!(eqs, FEER ~ 1 + FUELER * (FUCA / SFU - 1))
    add_equation!(eqs, FERM ~ RMF * KCKRM)
    add_equation!(eqs, FEUS ~ CRLA * (1 - FRA) * FUCA / 1000)
    add_equation!(eqs, FFI ~ FOFO / FF80)
    add_equation!(eqs, FFLR ~ max(0, FOLA / inits[:FOLA]))
    add_equation!(eqs, FFLREOGRR ~ max(1, 1 + FFLREOGRRM * (FFLR - TFFLR)))
    add_equation!(eqs, FNRM ~ ramp(t, GFNRM / IPP, 2022, 2022 + IPP))
    add_equation!(eqs, FOFO ~ CRLA * FEUS)
    add_equation!(eqs, D(FOLA) ~ NFL - CREX)
    add_equation!(eqs, FPI ~ exp(ROCFP * (t - 1980)))
    add_equation!(eqs, FRA ~ ramp(t, GFRA / IPP, 2022, 2020 + IPP))
    add_equation!(eqs, FSPI ~ exp(ROCFSP * (t - 1980)) * IfElse.ifelse(t > 2022, exp(EROCFSP * (t - 2022)), 1))
    add_equation!(eqs, FUCA ~ TFUCA / FPI)
    add_equation!(eqs, FUP ~ (FEUS / POP) * 1000)
    add_equation!(eqs, GLY ~ GLY80 + 0 * CO2CA - 0 * OW)
    add_equation!(eqs, GLY80 ~ 14 * CO2ELY * WELY)
    add_equation!(eqs, D(GRLA) ~ NGL)
    add_equation!(eqs, IUL ~ POP * ULP)
    add_equation!(eqs, LERM ~ IfElse.ifelse(t > 2022, 1 - SSP2LMA * ramp(t, (1 - 0) / 78, 2022, 2100), 1))
    add_equation!(eqs, LER ~ LER80 * FEER * LERM)
    add_equation!(eqs, LFL ~ OGRE + CREX)
    add_equation!(eqs, LOCR ~ CRLO + UREX)
    add_equation!(eqs, NDRA ~ log((RAA + EGB22) / EGB22) / 0.693)
    add_equation!(eqs, NFL ~ OGRE * (1 - FCG))
    add_equation!(eqs, NGL ~ OGRE * FCG)
    add_equation!(eqs, D(OGFA) ~ -NFL - NGL)
    add_equation!(eqs, OGRE ~ OGFA * OGRR * OGRRM)
    add_equation!(eqs, OGRR ~ OGRR80 * FFLREOGRR)
    add_equation!(eqs, OGRRM ~ IfElse.ifelse(t > 2022, 1 - SSP2LMA * ramp(t, (1 - 0) / 78, 2022, 2100), 1))
    add_equation!(eqs, PCB ~ CRBA / (1 + DRC))
    add_equation!(eqs, PRMGL ~ GRLA * GLY / 1000)
    add_equation!(eqs, RAA ~ CRLA * FRA)
    add_equation!(eqs, RMF ~ DRM - RMGL)
    add_equation!(eqs, RMGL ~ min(DRM, PRMGL))
    add_equation!(eqs, RMSP ~ (RMGL + RMF * min(1, CRBA)) * 1000 / POP)
    add_equation!(eqs, ROCSQCA ~ 0 + FUESQ * (FUCA / SFU - 1))
    add_equation!(eqs, D(SQICA) ~ CSQCA)
    add_equation!(eqs, TFA ~ OGFA + FOLA)
    add_equation!(eqs, TFUCA ~ withlookup(DCYCA, [(1.0, 0.0), (2.0, 40.0), (2.5, 50.0), (3.0, 60.0), (3.5, 70.0), (4.5, 100.0), (6.5, 200.0), (10.0, 600.0)]))
    add_equation!(eqs, TUC ~ TUCP * POP / 1000)
    add_equation!(eqs, TUCERM ~ (TUC - TUFRM) / FSPI)
    add_equation!(eqs, TUCERMP ~ TUCERM * 1000 / POP)
    add_equation!(eqs, TUCP ~ withlookup(GDPP, [(0.0, 400.0), (6.1, 680.0), (8.7, 780.0), (13.9, 950.0), (20.0, 1050.0), (30.0, 1150.0), (40.0, 1250.0), (60.0, 1350.0), (100.0, 1550.0)]))
    add_equation!(eqs, TUFRM ~ (((TURMP / 1000) * POP) - RMGL) * KCKRM)
    add_equation!(eqs, TURMP ~ withlookup(GDPP, [(0.0, 0.0), (6.1, 6.0), (8.8, 8.5), (14.0, 13.0), (30.0, 27.0), (40.0, 32.0), (50.0, 33.0), (100.0, 25.0)]))
    add_equation!(eqs, UREX ~ max(0, (IUL - URLA) / UDT))
    add_equation!(eqs, D(URLA) ~ UREX)
    add_equation!(eqs, WELY ~ IfElse.ifelse(t > 2022, 1 + OWEACY * (OW / OW2022 - 1), 1))

    return ODESystem(eqs, t; name=name)
end

function foodland_full_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CO2CA(t) [description = "Climate.CO2 Concentration in Atm ppm"]
    @variables GDP(t) [description = "Inventory.GDP"]
    @variables GDPP(t) [description = "Population.GDP per Person kdollar/p/y"]
    @variables IPP(t) [description = "Wellbeing.Introduction Period for Policy y"]
    @variables OW(t) [description = "Climate.Observed warming deg C"]
    @variables POP(t) [description = "Population.Population Mp"]

    eqs = []

    add_equation!(eqs, CO2CA ~ WorldDynamics.interpolate(t, tables[:CO2CA], ranges[:CO2CA]))
    add_equation!(eqs, GDP ~ WorldDynamics.interpolate(t, tables[:GDP], ranges[:GDP]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, OW ~ WorldDynamics.interpolate(t, tables[:OW], ranges[:OW]))
    add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))

    return ODESystem(eqs, t; name=name)
end

function foodland_partial_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CO2CA(t) [description = "Climate.CO2 Concentration in Atm ppm"]
    @variables GDP(t) [description = "Inventory.GDP"]
    @variables GDPP(t) [description = "Population.GDP per Person kdollar/p/y"]
    @variables IPP(t) [description = "Wellbeing.Introduction Period for Policy y"]
    @variables OW(t) [description = "Climate.Observed warming deg C"]
    @variables POP(t) [description = "Population.Population Mp"]

    eqs = []

    add_equation!(eqs, CO2CA ~ WorldDynamics.interpolate(t, tables[:CO2CA], ranges[:CO2CA]))
    add_equation!(eqs, GDP ~ WorldDynamics.interpolate(t, tables[:GDP], ranges[:GDP]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, OW ~ WorldDynamics.interpolate(t, tables[:OW], ranges[:OW]))
    add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))

    return ODESystem(eqs, t; name=name)
end
