include("../functions.jl")
@register_symbolic ramp(x, slope, startx, endx)


@variables t
D = Differential(t)

function energy(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters MNFCO2PP = params[:MNFCO2PP] [description = "Max non-fossil CO2 per person tCO2/p/y"]
    @parameters FCO2SCCS2022 = params[:FCO2SCCS2022] [description = "Fraction of CO2-sources with CCS in 2022"]
    @parameters GFCO2SCCS = params[:GFCO2SCCS] [description = "Goal for fraction of CO2-sources with CCS"]
    @parameters CCCSt = params[:CCCSt] [description = "Cost of CCS Dollar/tCO2"]
    @parameters ROCTCO2PT = params[:ROCTCO2PT] [description = "ROC in tCO2 per toe 1/y"]
    @parameters EROCEPA2022 = params[:EROCEPA2022] [description = "Extra ROC in energy productivity after 2022 1/y"]
    @parameters NIEE = params[:NIEE] [description = "Normal increase in energy efficiency 1/y"]
    @parameters GFNE = params[:GFNE] [description = "Goal for fraction new electrification"]
    @parameters FNE2022 = params[:FNE2022] [description = "Fraction new electrification in 2022"]
    @parameters FNE1980 = params[:FNE1980] [description = "Fraction new electrification in 1980"]
    @parameters EUEPRUNEFF = params[:EUEPRUNEFF] [description = "Extra use of electricity per reduced use of non-el FF MWh/toe"]
    @parameters ECRUNEFF = params[:ECRUNEFF] [description = "Extra cost per reduced use og non-el FF Dollar/toe"]
    @parameters GREF = params[:GREF] [description = "Goal for renewable el fraction"]
    @parameters REFF2022 = params[:REFF2022] [description = "Renewable el fraction in 2022"]
    @parameters REFF1980 = params[:REFF1980] [description = "Renewable el fraction in 1980"]
    @parameters RCUT = params[:RCUT] [description = "Renewable capacity up-time kh/y"]
    @parameters RECT = params[:RECT] [description = "Renewable el contruction time y"]
    @parameters LREC = params[:LREC] [description = "Life of renewable el capacity y"]
    @parameters SWC1980 = params[:SWC1980] [description = "Sun and wind capacity in 1980 GW"]
    @parameters CRDSWC = params[:CRDSWC] [description = "Cost reduction per dubling of sun and wind capacity"]
    @parameters CAPEXRE1980 = params[:CAPEXRE1980] [description = "CAPEX of renewable el in 1980 Dollar/W"]
    @parameters CAPEXFED = params[:CAPEXFED] [description = "CAPEX fossil el Dollar/W"]
    @parameters OPEXRED = params[:OPEXRED] [description = "OPEX renewable el Dollar/kWh"]
    @parameters OPEXFED = params[:OPEXFED] [description = "OPEX fossil el Dollar/kWh"]
    @parameters CNED = params[:CNED] [description = "Cost of Nuclear El Dollar/kWh"]
    @parameters FREH = params[:FREH] [description = "Fraction of renewable electricity to hydrogen"]
    @parameters KWEPKGH2 = params[:KWEPKGH2] [description = "kWh electricity per kg of hydrogen"]
    @parameters TPTH2 = params[:TPTH2] [description = "toe per tH2"]
    @parameters BEM = params[:BEM] [description = "Biomass energy Mtoe/y"]
    @parameters EFPP = params[:EFPP] [description = "Efficiency of fossil power plant TWh-el/TWh-heat"]
    @parameters TWHPEJCE = params[:TWHPEJCE] [description = "TWh-heat per EJ - calorific equivalent"]
    @parameters MTPEJCE = params[:MTPEJCE] [description = "Mtoe per EJ - calorific equivalent"]
    @parameters EKHPY = params[:EKHPY] [description = "8 khours per year"]
    @parameters FECCT = params[:FECCT] [description = "Fossil el cap construction time y"]
    @parameters NLFEC = params[:NLFEC] [description = "Normal life of fossil el capacity y"]
    @parameters sFCUTLOFC = params[:sFCUTLOFC] [description = "sFCUTeoLOFC>0"]
    @parameters NCUT = params[:NCUT] [description = "Nuclear capacity up-time kh/y"]
    @parameters TCE = params[:TCE] [description = "Traditional cost of electricity Dollar/kWh"]
    @parameters AFMCM = params[:AFMCM] [description = "Adjustment factor to make cost match 1980 - 2022"]
    @parameters TCFFFNEU = params[:TCFFFNEU] [description = "Traditional cost of fossil fuels for non-el use Dollar/toe"]
    @parameters TC = params[:TC] [description = "Transmission cost Dollar/kWh"]


    @variables CNEL(t) [description = "Cost of Nuclear ELectricity Gdollar/y"]
    @variables CO2NFIP(t) [description = "CO2 from non-fossil industrial processes GtCO2/y"]
    @variables FCO2SCCS(t) [description = "Fraction of CO2-sources with CCS (1)"]
    @variables NFCO2PP(t) [description = "Non-fossil CO2 per person tCO2/p/y"]
    @variables CO2EI(t) [description = "CO2 from energy and industry GtCO2/y"]
    @variables CO2EP(t) [description = "CO2 from energy production GtCO2/y"]
    @variables CO2EMPP(t) [description = "CO2 EMissions per person tCO2/y"]
    @variables CCCSG(t) [description = "Cost of CCS GDollar/y"]
    @variables ICCSC(t) [description = "Installed CCS capacity GtCO2/y"]
    @variables TCO2PT(t) [description = "tCO2 per toe"]
    @variables EEPI2022(t) = inits[:EEPI2022] [description = "Extra energy productivity index 2022=1"]
    @variables IEEPI(t) [description = "Increase in extra energy productivity index 1/y"]
    @variables TPPUEBEE(t) [description = "Traditional per person use of electricity before EE MWh/p/y"]
    @variables TPPUFFNEUBEE(t) [description = "Traditional per person use of fossil fuels for non-el-use before EE toe/p/y"]
    @variables DEBNE(t) [description = "Demand for electricity before NE TWh/y"]
    @variables DFFNEUBNE(t) [description = "Demand for fossil fuel for non-el use before NE Mtoe/y"]
    @variables FNE(t) [description = "Fraction new electrification (1)"]
    @variables ERDNEFFFNE(t) [description = "Extra reduction in demand for non-el fossil fuel from NE Mtoe/y"]
    @variables CNE(t) [description = "Cost of new electrification GDollar/y"]
    @variables EIDEFNE(t) [description = "Extra increase in demand for electricity from NE TWh/y"]
    @variables DFFFNEU(t) [description = "Demand for fossil fuel for non-el use Mtoe/y"]
    @variables UFF(t) [description = "Use of fossil fuels Mtoe/y"]
    @variables DE(t) [description = "Demand for electricity TWh/y"]
    @variables DRES(t) [description = "Desired renewable electricity share (1)"]
    @variables DSRE(t) [description = "Desired supply of renewable electricity TWh/y"]
    @variables DREC(t) [description = "Desired renewable el capacity GW"]
    @variables DRECC(t) [description = "Desired renewable el capacity change GW"]
    @variables REC(t) = inits[:REC] [description = "Renewable electricity capacity GW"]
    @variables AREC(t) [description = "Addition of renewable el capacity GW/y"]
    @variables DIREC(t) [description = "Discard of renewable el capacity GW/y"]
    @variables ASWC(t) [description = "Addition of sun and wind capacity GW/y"]
    @variables ACSWCF1980(t) = inits[:ACSWCF1980] [description = "ACcumulated sun and wind capacity from 1980 GW"]
    @variables NDSWC(t) [description = "Number of doublings in sun and wind capacity (1)"]
    @variables CISWC(t) [description = "Cost index for sun and wind capacity (1)"]
    @variables CAPEXRED(t) [description = "CAPEX renewable el dollar/W"]
    @variables CAPEXREG(t) [description = "CAPEX renewable el Gdollar/y"]
    @variables OPEXREG(t) [description = "OPEX renewable el Gdollar/y"]
    @variables CRE(t) [description = "Cost of renewable electricity GDollar/y"]
    @variables CAPEXFEG(t) [description = "CAPEX fossil el GDollar/y"]
    @variables OPEXFEG(t) [description = "OPEX fossil el GDollar/y"]
    @variables CFE(t) [description = "Cost of fossil electricity GDollar/y"]
    @variables CEL(t) [description = "Cost of electricity GDollar/y"]
    @variables REP(t) [description = "Renewable electricity production TWh/y"]
    @variables GHMH2(t) [description = "Green hydrogen MtH2/y"]
    @variables GHMt(t) [description = "Green hydrogen Mtoe/y"]
    @variables RHP(t) [description = "Renewable heat production Mtoe/y"]
    @variables TWEPEJEE(t) [description = "TWh-el per EJ - engineering equivalent"]
    @variables IIASAREP(t) [description = "IIASA Renewable energy production EJ/yr"]
    @variables FTWEPMt(t) [description = "4 TWh-el per Mtoe"]
    @variables IIASAFEP(t) [description = "IIASA Fossil energy production EJ/yr"]
    @variables LCEP(t) [description = "Low-carbon el production TWh/y"]
    @variables DFE(t) [description = "Demand for fossil electricity TWh/y"]
    @variables DFEC(t) [description = "Desired fossil el capacity GW"]
    @variables DFECC(t) [description = "Desired fossil el capacity change GW/y"]
    @variables AFEC(t) [description = "Addition of fossil el capacity GW/y"]
    @variables FEC(t) = inits[:FEC] [description = "Fossil electricity capacity GW"]
    @variables LFEC(t) [description = "Life of fossil el capacity y"]
    @variables DIFEC(t) [description = "DIscard of Fossil El Capacity GW/y"]
    @variables FCUT(t) [description = "Fossil capacity up-time kh/y"]
    @variables FCUTLOFC(t) [description = "FCUTeoLOFC (1)"]
    @variables FEP(t) [description = "Fossil Electricity Production TWh/y"]
    @variables NC(t) [description = "Nuclear capacity GW"]
    @variables NEP(t) [description = "Nuclear electricity production TWh/y"]
    @variables EP(t) [description = "Electricity production TWh/y"]
    @variables ELB(t) [description = "ELectricity balance (1)"]
    @variables FFPNE(t) [description = "Fraction fossil plus nuclear electricity (1)"]
    @variables EU(t) [description = "Energy use Mtoe/y"]
    @variables EUPP(t) [description = "Energy use per person toe/p/y"]
    @variables FFE(t) [description = "Fossil fuels for electricity Mtoe/y"]
    @variables TCEG(t) [description = "Traditional cost of electricity GDollar/y"]
    @variables TCFFFNEUG(t) [description = "Traditional cost of fossil fuel for non-el use Gdollar/y"]
    @variables CFFFNEU(t) [description = "Cost of Fossil Fuel For Non-El Use Gdollar/y"]
    @variables CG(t) [description = "Cost of grid GDollar/y"]
    @variables TGC(t) [description = "Traditional grid cost GDollar/y"]
    @variables TCEN(t) [description = "Traditional Cost of ENergy Gdollar/y"]
    @variables TCENSGDP(t) [description = "Traditional cost of energy as share of GDP (1)"]
    @variables CE(t) [description = "Cost of energy GDollar/y"]
    @variables RECTEC(t) [description = "Ratio of Energy cost to Trad Energy cost (1)"]
    @variables CESGDP(t) [description = "Cost of energy as share of GDP (1)"]
    @variables ECETSGDP(t) [description = "Extra cost of Energy Turnaround as share of GDP (1)"]

    @variables CAC(t)
    @variables GDP(t)
    @variables GDPP(t)
    @variables IPP(t)
    @variables POP(t)

    eqs = []

    add_equation!(eqs, CNEL ~ NEP * CNED)
    add_equation!(eqs, NFCO2PP ~ MNFCO2PP * (1 - exp(-(GDPP / 10))))
    add_equation!(eqs, CO2NFIP ~ (NFCO2PP / 1000) * POP * (1 - FCO2SCCS))
    add_equation!(eqs, FCO2SCCS ~ FCO2SCCS2022 + ramp(t, (GFCO2SCCS - FCO2SCCS2022) / IPP, 2022, 2022 + IPP))
    add_equation!(eqs, CO2EI ~ CO2EP + CO2NFIP)
    add_equation!(eqs, CO2EP ~ UFF * (TCO2PT / 1000) * (1 - FCO2SCCS))
    add_equation!(eqs, CO2EMPP ~ (CO2EI / POP) * 1000)
    add_equation!(eqs, CCCSG ~ CCCSt * ICCSC)
    add_equation!(eqs, ICCSC ~ FCO2SCCS * (CO2NFIP + CO2EP) / (1 - FCO2SCCS))
    add_equation!(eqs, TCO2PT ~ 2.8 * exp(ROCTCO2PT * (t - 1980)))
    add_equation!(eqs, D(EEPI2022) ~ IEEPI)
    add_equation!(eqs, IEEPI ~ EROCEPA2022 * 0 + step(t, EROCEPA2022, 2022))
    add_equation!(eqs, TPPUEBEE ~ withlookup(GDPP, [(0.0, 0.0), (10.0, 4.0), (20.0, 7.0), (30.0, 9.0), (50.0, 12.0), (65.0, 13.0)]))
    add_equation!(eqs, TPPUFFNEUBEE ~ withlookup(GDPP, [(0.0, 0.3), (15.0, 2.0), (25.0, 3.1), (35.0, 4.0), (50.0, 5.0)]))
    add_equation!(eqs, DEBNE ~ (POP * TPPUEBEE * exp(-NIEE * (t - 1980))) / EEPI2022)
    add_equation!(eqs, DFFNEUBNE ~ (POP * TPPUFFNEUBEE * exp(-NIEE * (t - 1980))) / EEPI2022)
    add_equation!(eqs, FNE ~ FNE1980 + ramp(t, (FNE2022 - FNE1980) / 42, 1980, 2022) + ramp(t, (GFNE - FNE2022) / IPP, 2022, 2022 + IPP))
    add_equation!(eqs, ERDNEFFFNE ~ FNE * DFFNEUBNE)
    add_equation!(eqs, CNE ~ (ECRUNEFF / 1000) * ERDNEFFFNE)
    add_equation!(eqs, EIDEFNE ~ ERDNEFFFNE * EUEPRUNEFF)
    add_equation!(eqs, DFFFNEU ~ DFFNEUBNE - ERDNEFFFNE)
    add_equation!(eqs, UFF ~ DFFFNEU + FFE)
    add_equation!(eqs, DE ~ DEBNE + EIDEFNE)
    add_equation!(eqs, DRES ~ REFF1980 + ramp(t, (REFF2022 - REFF1980) / 42, 1980, 2022) + ramp(t, (GREF - REFF2022) / IPP, 2022, 2022 + IPP))
    add_equation!(eqs, DSRE ~ DE * DRES)
    add_equation!(eqs, DREC ~ DSRE / RCUT)
    add_equation!(eqs, DRECC ~ DREC - REC)
    add_equation!(eqs, D(REC) ~ AREC - DIREC)
    add_equation!(eqs, AREC ~ max(0, (DRECC / RECT) + (DIREC)))
    add_equation!(eqs, DIREC ~ REC / LREC)
    add_equation!(eqs, ASWC ~ AREC)
    add_equation!(eqs, D(ACSWCF1980) ~ ASWC)
    add_equation!(eqs, NDSWC ~ log(2) + log(ACSWCF1980 / SWC1980))
    add_equation!(eqs, CISWC ~ (1 - CRDSWC)^NDSWC)
    add_equation!(eqs, CAPEXRED ~ CAPEXRE1980 * CISWC)
    add_equation!(eqs, CAPEXREG ~ CAPEXRED * AREC)
    add_equation!(eqs, OPEXREG ~ OPEXRED * REP)
    add_equation!(eqs, CRE ~ CAPEXREG + OPEXREG)
    add_equation!(eqs, CAPEXFEG ~ CAPEXFED * AFEC)
    add_equation!(eqs, OPEXFEG ~ OPEXFED * FEP)
    add_equation!(eqs, CFE ~ CAPEXFEG + OPEXFEG)
    add_equation!(eqs, CEL ~ CFE + CRE + CNEL)
    add_equation!(eqs, REP ~ REC * RCUT)
    add_equation!(eqs, GHMH2 ~ REP * FREH / KWEPKGH2)
    add_equation!(eqs, GHMt ~ GHMH2 * TPTH2)
    add_equation!(eqs, RHP ~ BEM + GHMt)
    add_equation!(eqs, TWEPEJEE ~ TWHPEJCE * EFPP)
    add_equation!(eqs, IIASAREP ~ REP / TWEPEJEE + RHP / MTPEJCE)
    add_equation!(eqs, FTWEPMt ~ TWEPEJEE / MTPEJCE)
    add_equation!(eqs, IIASAFEP ~ UFF / MTPEJCE)
    add_equation!(eqs, LCEP ~ REP + NEP)
    add_equation!(eqs, DFE ~ max(0, DE - LCEP))
    add_equation!(eqs, DFEC ~ DFE / EKHPY)
    add_equation!(eqs, DFECC ~ (DFEC - FEC) / FECCT + DIFEC)
    add_equation!(eqs, AFEC ~ max(0, DFECC))
    add_equation!(eqs, D(FEC) ~ AFEC - DIFEC)
    add_equation!(eqs, LFEC ~ NLFEC * FCUTLOFC)
    add_equation!(eqs, DIFEC ~ FEC / LFEC)
    add_equation!(eqs, FCUT ~ DFE / FEC)
    add_equation!(eqs, FCUTLOFC ~ 1 + sFCUTLOFC * ((FCUT / EKHPY) - 1))
    add_equation!(eqs, FEP ~ FEC * FCUT)
    add_equation!(eqs, NC ~ withlookup(t, [(1980.0, 75.0), (2000.0, 310.0), (2020.0, 310.0), (2098.9, 310.0)]))
    add_equation!(eqs, NEP ~ NC * NCUT)
    add_equation!(eqs, EP ~ FEP + NEP + REP)
    add_equation!(eqs, ELB ~ EP / DE)
    add_equation!(eqs, FFPNE ~ (FEP + NEP) / EP)
    add_equation!(eqs, EU ~ DFFFNEU + EP / FTWEPMt + RHP)
    add_equation!(eqs, EUPP ~ EU / POP)
    add_equation!(eqs, FFE ~ FEP / FTWEPMt)
    add_equation!(eqs, TCEG ~ (DEBNE * TCE / 1000) * AFMCM)
    add_equation!(eqs, TCFFFNEUG ~ (DFFNEUBNE * TCFFFNEU / 1000) * AFMCM)
    add_equation!(eqs, CFFFNEU ~ (DFFFNEU * TCFFFNEU) / 1000)
    add_equation!(eqs, CG ~ EP * TC)
    add_equation!(eqs, TGC ~ DEBNE * TC)
    add_equation!(eqs, TCEN ~ TCEG + TCFFFNEUG + TGC)
    add_equation!(eqs, TCENSGDP ~ TCEN / GDP)
    add_equation!(eqs, CE ~ CFFFNEU + CEL + CG + CNE + CCCSG + CAC)
    add_equation!(eqs, RECTEC ~ CE / TCEN)
    add_equation!(eqs, CESGDP ~ CE / GDP)
    add_equation!(eqs, ECETSGDP ~ IfElse.ifelse(t > 2022, (CE - TCEN) / GDP, 0))

    return ODESystem(eqs, t; name=name)
end

function energy_full_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CAC(t) [description = "Climate.Cost of Air Capture Gdollar/y"]
    @variables GDP(t) [description = "Inventory.GDP Gdollar/y"]
    @variables GDPP(t) [description = "Population.GDP per Person kdollar/p/y"]
    @variables IPP(t) [description = "Wellbeing.Introduction Period for Policy y"]
    @variables POP(t) [description = "POPulation.Population Mp"]

    eqs = []

    add_equation!(eqs, CAC ~ WorldDynamics.interpolate(t, tables[:CAC], ranges[:CAC]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, GDP ~ WorldDynamics.interpolate(t, tables[:GDP], ranges[:GDP]))

    return ODESystem(eqs, t; name=name)
end

function energy_partial_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables CAC(t) [description = "Climate.Cost of Air Capture Gdollar/y"]
    @variables GDP(t) [description = "Inventory.GDP Gdollar/y"]
    @variables GDPP(t) [description = "Population.GDP per Person kdollar/p/y"]
    @variables IPP(t) [description = "Wellbeing.Introduction Period for Policy y"]
    @variables POP(t) [description = "POPulation.Population Mp"]

    eqs = []

    add_equation!(eqs, CAC ~ WorldDynamics.interpolate(t, tables[:CAC], ranges[:CAC]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, GDP ~ WorldDynamics.interpolate(t, tables[:GDP], ranges[:GDP]))

    return ODESystem(eqs, t; name=name)
end

