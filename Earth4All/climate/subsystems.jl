include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function climate(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters CCCS = params[:CCCS] [description = "Cost of CCS dollar/tCO2"]

    @parameters AI1980 = params[:AI1980] [description = "Amount of ice in 1980 MKm3"]
    @parameters ALGAV = params[:ALGAV] [description = "ALbedo global average"]
    @parameters ALIS = params[:ALIS] [description = "ALbedo Ice and snow"]
    @parameters CH4A1980 = params[:CH4A1980] [description = "CH4 in atm in 1980 GtCH4"]
    @parameters CO2A1850 = params[:CO2A1850] [description = "CO2 in atmosphere in 1850 GtCO2"]
    @parameters DACCO22100 = params[:DACCO22100] [description = "Direct Air Capture of CO2 in 2100 GtCO2/y"]
    @parameters EH1980 = params[:EH1980] [description = "Extra Heat in 1980 ZJ"]
    @parameters ERDCH4KC2022 = params[:ERDCH4KC2022] [description = "Extra rate of decline in CH4 per kg crop after 2022 1/y"]
    @parameters ERDN2OKF2022 = params[:ERDN2OKF2022] [description = "Extra rate of decline in N2O per kg fertilizer from 2022"]
    @parameters GCH4PP = params[:GCH4PP] [description = "GtCH4 per ppm"]
    @parameters GCO2PP = params[:GCO2PP] [description = "GtCO2 per ppm"]
    @parameters GLSU = params[:GLSU] [description = "GLobal SUrface Mkm2"]
    @parameters GN2OPP = params[:GN2OPP] [description = "GtN2O per ppm"]
    @parameters HRMI = params[:HRMI] [description = "Heat required to melt ice kJ/kg"]
    @parameters KCH4KC1980 = params[:KCH4KC1980] [description = "kg CH4 per kg crop in 1980"]
    @parameters KN2OKF1980 = params[:KN2OKF1980] [description = "kg N2O per kg fertilizer in 1980 "]
    @parameters ISCEGA1980 = params[:ISCEGA1980] [description = "Ice and snow cover excluding Greenland and Antarctica in 1980 Mkm2"]
    @parameters LCH4A = params[:LCH4A] [description = "Life of CH4 in atmosphere y"]
    @parameters LECO2A1980 = params[:LECO2A1980] [description = "Life of extra CO2 in atmosphere in 1980 y"]
    @parameters LN2OA = params[:LN2OA] [description = "Life of N2O in atmosphere y"]
    @parameters MAT = params[:MAT] [description = "Mass of ATmosphere Zt"]
    @parameters MRS1980 = params[:MRS1980] [description = "Melting rate surface in 1980 1/y"]
    @parameters N2OA1980 = params[:N2OA1980] [description = "N2O in atm in 1980 GtN2O"]
    @parameters OBWA2022 = params[:OBWA2022] [description = "OBserved WArming in 2022 deg C"]
    @parameters OWWV = params[:OWWV] [description = "sOWeoWV>0"]
    @parameters PD = params[:PD] [description = "Perception delay y"]
    @parameters RDCH4KC = params[:RDCH4KC] [description = "Rate of decline in CH4 per kg crop 1/y"]
    @parameters RDN2OKF = params[:RDN2OKF] [description = "Rate of decline in N2O per kg fertilizer 1/y"]
    @parameters SOWLCO2 = params[:SOWLCO2] [description = "sOWeoLoCO2>0"]
    @parameters SVDR = params[:SVDR] [description = "Surface vs deep rate"]
    @parameters TCO2ETCH4 = params[:TCO2ETCH4] [description = "tCO2e/tCH4"]
    @parameters TCO2ETCO2 = params[:TCO2ETCO2] [description = "tCO2e/tCO2"]
    @parameters TCO2ETN2O = params[:TCO2ETN2O] [description = "tCO2e/tN2O"]
    @parameters TCO2PTCH4 = params[:TCO2PTCH4] [description = "tCO2 per tCH4"]
    @parameters TPM3I = params[:TPM3I] [description = "Ton per m3 ice"]
    @parameters TRSA1980 = params[:TRSA1980] [description = "Transfer rate surface-abyss in 1980 1/y"]
    @parameters TRSS1980 = params[:TRSS1980] [description = "Transfer rate surface-space in 1980 1/y"]
    @parameters WA1980 = params[:WA1980] [description = "Warming in 1980 deg C"]
    @parameters WFEH = params[:WFEH] [description = "Warming from Extra Heat deg/ZJ"]
    @parameters WVC1980 = params[:WVC1980] [description = "Water Vapour Concentration in 1980 g/kg"]
    @parameters WVF1980 = params[:WVF1980] [description = "Water Vapour Feedback in 1980 W/m2"]
    @parameters WVWVF = params[:WVWVF] [description = "sWVeoWVF>0"]

    @variables AL(t) [description = "ALbedo"]
    @variables AL1980(t) [description = "ALbedo in 1980"]
    @variables CAC(t) [description = "Cost of air capture GDollar/y"]
    @variables CH4A(t) = inits[:CH4A] [description = "CH4 in Atmosphere GtCH4"]
    @variables CH4BD(t) [description = "CH4 BreakDown GtCH4/y"]
    @variables CH4C1980(t) [description = "CH4 conc in 1980 ppm"]
    @variables CH4CA(t) [description = "CH4 concentration in atm ppm"]
    @variables CH4E(t) [description = "CH4 emissions GtCH4/y"]
    @variables CH4FPP(t) [description = "CH4 forcing per ppm W/m2/ppm"]
    @variables CO2A(t) = inits[:CO2A] [description = "CO2 in Atmosphere GtCO2"]
    @variables CO2AB(t) [description = "CO2 absorption GtCO2/y"]
    @variables CO2CA(t) [description = "CO2 concentration in atm ppm"]
    @variables CO2E(t) [description = "CO2 emissions GtCO2/y"]
    @variables CO2FCH4(t) [description = "CO2 from CH4 GtCO2/y"]
    @variables CO2FPP(t) [description = "CO2 forcing per ppm W/m2/ppm"]
    @variables CO2GDP(t) [description = "CO2 per GDP (kgCO2/Dollar)"]
    @variables DACCO2(t) [description = "Direct Air Capture of CO2 GtCO2/y"]
    @variables ECIM(t) [description = "Extra cooling from ice melt ZJ/y"]
    @variables EHS(t) = inits[:EHS] [description = "Extra heat in surface ZJ"]
    @variables EWFF(t) [description = "Extra Warming from forcing ZJ/y"]
    @variables FCH4(t) [description = "Forcing from CH4  W/m2"]
    @variables FCO2(t) [description = "Forcing from CO2  W/m2"]
    @variables FN2O(t) [description = "Forcing from N2O  W/m2"]
    @variables FOG(t) [description = "Forcing from other gases  W/m2"]
    @variables GHGE(t) [description = "GHG emissions GtCO2e/y"]
    @variables HDO(t) [description = "Heat to deep ocean ZJ/y"]
    @variables HTS(t) [description = "Heat to space ZJ/y"]
    @variables ISC(t) [description = "Ice and snow cover Mha"]
    @variables ISCEGA(t) = inits[:ISCEGA] [description = "Ice and snow cover excluding Greenland and Antarctica Mkm2"]
    @variables KCH4EKC(t) [description = "kg CH4 emission per kg crop"]
    @variables KN2OEKF(t) [description = "kg N2O emission per kg fertilizer"]
    @variables LECO2A(t) [description = "Life of extra CO2 in atmosphere y"]
    @variables MEL(t) [description = "Melting Mha/y"]
    @variables MMCH4E(t) [description = "Man-made CH4 emissions GtCH4/y"]
    @variables MMF(t) [description = "Man-made Forcing  W/m2"]
    @variables MMN2OE(t) [description = "Man-made N2O emissions GtN2O/y"]
    @variables MRDI(t) [description = "Melting rate deep ice 1/y"]
    @variables MRS(t) [description = "Melting rate surface 1/y"]
    @variables N2OA(t) = inits[:N2OA] [description = "N2O in Atmosphere GtN2O"]
    @variables N2OBD(t) [description = "N2O BreakDown GtN2O/y"]
    @variables N2OC1980(t) [description = "N2O conc in 1980 ppm"]
    @variables N2OCA(t) [description = "N2O concentration in atm ppm"]
    @variables N2OE(t) [description = "N2O emissions GtN2O/y"]
    @variables N2OFPP(t) [description = "N2O forcing per ppm W/m2/ppm"]
    @variables NCH4E(t) [description = "Natural CH4 emissions GtCH4/y"]
    @variables NN2OE(t) [description = "Natural N2O emissions GtN2O/y"]
    @variables OBWA(t) [description = "OBserved WArming deg C"]
    @variables OWLCO2(t) [description = "OWeoLoCO2"]
    @variables PWA(t) = inits[:PWA] [description = "Perceived warming deg C"]
    @variables REHE(t) [description = "Risk of extreme heat event"]
    @variables TMMF(t) [description = "Total man-made forcing W/m2"]
    @variables TRHGA(t) [description = "Transfer rate for heat going to abyss 1/y"]
    @variables TRHGS(t) [description = "Transfer rate for heat going to space 1/y"]
    @variables WVC(t) [description = "Water Vapour Concentration g/kg"]
    @variables WVF(t) [description = "Water Vapour Feedback W/m2"]

    @variables CO2EI(t)
    @variables CO2ELULUC(t)
    @variables CRSU(t)
    @variables FEUS(t)
    @variables GDP(t)
    @variables IPP(t)

    eqs = []

    add_equation!(eqs, KN2OEKF ~ KN2OKF1980 * exp(-(RDN2OKF) * (t - 1980)) * IfElse.ifelse(t > 2022, exp(-(ERDN2OKF2022) * (t - 2022)), 1))
    add_equation!(eqs, MMN2OE ~ FEUS * KN2OEKF / 1000)
    add_equation!(eqs, NN2OE ~ interpolate1(t, [(1980.0, 0.009), (2020.0, 0.009), (2099.27, 0.0)]))
    add_equation!(eqs, N2OE ~ NN2OE + MMN2OE)
    add_equation!(eqs, N2OC1980 ~ N2OA1980 / MAT)
    add_equation!(eqs, D(N2OA) ~ N2OE - N2OBD)
    add_equation!(eqs, N2OBD ~ N2OA / LN2OA)
    add_equation!(eqs, N2OCA ~ N2OA / GN2OPP)
    add_equation!(eqs, N2OFPP ~ interpolate1(t, [(1980.0, 0.43), (2000.0, 0.64), (2010.0, 0.73), (2020.0, 0.8), (2100.0, 1.0)]))
    add_equation!(eqs, FN2O ~ N2OCA * N2OFPP)
    add_equation!(eqs, KCH4EKC ~ KCH4KC1980 * exp(-(RDCH4KC) * (t - 1980)) * IfElse.ifelse(t > 2022, exp(-(ERDCH4KC2022) * (t - 2022)), 1))
    add_equation!(eqs, MMCH4E ~ CRSU * KCH4EKC / 1000)
    add_equation!(eqs, NCH4E ~ interpolate1(t, [(1980.0, 0.19), (2020.0, 0.19), (2100.0, 0.19)]))
    add_equation!(eqs, CH4E ~ NCH4E + MMCH4E)
    add_equation!(eqs, CH4C1980 ~ CH4A1980 / MAT)
    add_equation!(eqs, D(CH4A) ~ CH4E - CH4BD)
    add_equation!(eqs, CH4BD ~ CH4A / LCH4A)
    add_equation!(eqs, CH4CA ~ CH4A / GCH4PP)
    add_equation!(eqs, CH4FPP ~ interpolate1(t, [(1980.0, 0.82), (2000.0, 0.94), (2020.0, 1.01), (2100.0, 1.1)]))
    add_equation!(eqs, FCH4 ~ CH4CA * CH4FPP)
    add_equation!(eqs, OWLCO2 ~ IfElse.ifelse(t > 2022, 1 + SOWLCO2 * (OBWA / OBWA2022 - 1), 1))
    add_equation!(eqs, LECO2A ~ LECO2A1980 * OWLCO2)
    add_equation!(eqs, CO2FCH4 ~ CH4BD * TCO2PTCH4)
    add_equation!(eqs, CO2AB ~ (CO2A - CO2A1850) / LECO2A)
    add_equation!(eqs, CO2E ~ CO2EI + CO2ELULUC - DACCO2)
    add_equation!(eqs, CO2GDP ~ (CO2E / GDP) * 1000)
    add_equation!(eqs, CAC ~ DACCO2 * CCCS)
    add_equation!(eqs, DACCO2 ~ IfElse.ifelse(t > 2022, ramp(t, (DACCO22100) / IPP, 2022, 2022 + IPP), 0))
    add_equation!(eqs, D(CO2A) ~ CO2E - CO2AB + 2 * CO2FCH4) #STRANGE EQUATION!
    add_equation!(eqs, CO2CA ~ CO2A / GCO2PP)
    add_equation!(eqs, CO2FPP ~ interpolate1(t, [(1980.0, 0.0032), (1990.0, 0.0041), (2000.0, 0.0046), (2020.0, 0.0051), (2100.0, 0.006)]))
    add_equation!(eqs, FCO2 ~ CO2CA * CO2FPP)
    add_equation!(eqs, FOG ~ interpolate1(t, [(1980.0, 0.18), (2000.0, 0.36), (2020.0, 0.39), (2050.0, 0.37), (2100.0, 0.0)]))
    add_equation!(eqs, MMF ~ FCO2 + FOG + FCH4 + FN2O)
    add_equation!(eqs, GHGE ~ CO2E * TCO2ETCO2 + CH4E * TCO2ETCH4 + N2OE * TCO2ETN2O)
    add_equation!(eqs, AL1980 ~ (ISCEGA1980 * ALIS + (GLSU - ISCEGA1980) * ALGAV) / GLSU)
    add_equation!(eqs, AL ~ (ISCEGA * ALIS + (GLSU - ISCEGA) * ALGAV) / GLSU)
    add_equation!(eqs, TRHGS ~ (TRSS1980 * ((OBWA + 297) / 297)) * (AL / AL1980))
    add_equation!(eqs, HTS ~ EHS * TRHGS) # EHS
    add_equation!(eqs, MRS ~ MRS1980 * (OBWA / WA1980))
    add_equation!(eqs, MRDI ~ MRS / SVDR)
    add_equation!(eqs, ECIM ~ MRDI * AI1980 * TPM3I * HRMI)
    add_equation!(eqs, MEL ~ ISCEGA * MRS)
    add_equation!(eqs, D(ISCEGA) ~ -MEL)
    add_equation!(eqs, ISC ~ ISCEGA * 100)
    add_equation!(eqs, WVC ~ WVC1980 * (1 + OWWV * (OBWA / WA1980 - 1)))
    add_equation!(eqs, WVF ~ WVF1980 * (1 + WVWVF * (WVC / WVC1980 - 1)))
    add_equation!(eqs, TMMF ~ MMF + WVF)
    add_equation!(eqs, EWFF ~ (TMMF * GLSU) * 31.5 / 1000)
    add_equation!(eqs, OBWA ~ WA1980 + (EHS - EH1980) * WFEH)
    add_equation!(eqs, REHE ~ interpolate1(OBWA, [(0.0, 1.0), (1.2, 4.8), (2.0, 8.6), (2.9, 14.0), (5.2, 40.0)]))
    add_equation!(eqs, TRHGA ~ TRSA1980 * ((OBWA + 287) / 287))
    add_equation!(eqs, HDO ~ EHS * TRHGA)
    add_equation!(eqs, D(EHS) ~ EWFF - ECIM - HDO - HTS)

    smooth!(eqs, PWA, OBWA, PD)

    return ODESystem(eqs; name=name)
end

function climate_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDP(t) [description = "Inventory.GDP GDollar/y"]
    @variables IPP(t) [description = "Wellbeing.Introduction period for policy y"]
    @variables FEUS(t) [description = "Food and land.Fertilizer use Mt/y"]
    @variables CRSU(t) [description = "Food and land.Crop supply (after 20% waste) Mt-crop/y"]
    @variables CO2EI(t) [description = "Energy.CO2 from energy and industry GtCO2/y"]
    @variables CO2ELULUC(t) [description = "Food and land.CO2 emissions from LULUC GtCO2/y"]

    eqs = []

    add_equation!(eqs, GDP ~ WorldDynamics.interpolate(t, tables[:GDP], ranges[:GDP]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, FEUS ~ WorldDynamics.interpolate(t, tables[:FEUS], ranges[:FEUS]))
    add_equation!(eqs, CRSU ~ WorldDynamics.interpolate(t, tables[:CRSU], ranges[:CRSU]))
    add_equation!(eqs, CO2EI ~ WorldDynamics.interpolate(t, tables[:CO2EI], ranges[:CO2EI]))
    add_equation!(eqs, CO2ELULUC ~ WorldDynamics.interpolate(t, tables[:CO2ELULUC], ranges[:CO2ELULUC]))

    return ODESystem(eqs; name=name)
end

