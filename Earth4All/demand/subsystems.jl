include("../functions.jl")
@register ramp(x, slope, startx, endx)
@register pulse(x, start, width)


@variables t
D = Differential(t)

function demand(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters BITRW = params[:BITRW] [description = "Basic Income Tax Rate Workers"]
    @parameters EETF2022 = params[:EETF2022] [description = "Extra Empowerment Tax From 2022 (share of NI)"]
    @parameters EGTRF2022 = params[:EGTRF2022] [description = "Extra General Tax Rate From 2022"]
    @parameters EPTF2022 = params[:EPTF2022] [description = "Extra Pension Tax From 2022 (share of NI)"]
    @parameters ETGBW = params[:ETGBW] [description = "Extra Transfer or Govmnt Budget to Workers"]
    @parameters FETACPET = params[:FETACPET] [description = "Fraction of Extra TA Cost Paid by Extra Taxes"]
    @parameters FETPO = params[:FETPO] [description = "Fraction of Extra Ta Paid by Owners"]
    @parameters FGDC2022 = params[:FGDC2022] [description = "Fraction of Govmnt Debt Cancelled in 2022 1/y"]
    @parameters FT1980 = params[:FT1980] [description = "Fraction Transferred in 1980"]
    @parameters GCF = params[:GCF] [description = "Govmnt Consumption Fraction"]
    @parameters GDDP = params[:GDDP] [description = "Govmnt DrawDown Period y"]
    @parameters GDPOSR = params[:GDPOSR] [description = "sGDPeoOSR<0"]
    @parameters GDPP1980 = params[:GDPP1980] [description = "GDP per Person in 1980 kDollar/p/y"]
    @parameters GEIC = params[:GEIC] [description = "Goal for Extra Income from Commons (share of NI)"]
    @parameters GITRO = params[:GITRO] [description = "Goal for Income Tax Rate Owners"]
    @parameters GPP = params[:GPP] [description = "Govmnt Payback Period y"]
    @parameters GSF2022 = params[:GSF2022] [description = "Govmnt Stimulus From 2022 (share of NI)"]
    @parameters INEQ1980 = params[:INEQ1980] [description = "INEQuality in 1980"]
    @parameters ITRO1980 = params[:ITRO1980] [description = "Income Tax Rate Owners in 1980"]
    @parameters ITRO2022 = params[:ITRO2022] [description = "Income Tax Rate Owners in 2022"]
    @parameters MATGF = params[:MATGF] [description = "Mult to Avoid Transient in Govmnt Finance"]
    @parameters MATWF = params[:MATWF] [description = "Mult to Avoid Transient in Worker Finance"]
    @parameters MGDB = params[:MGDB] [description = "Max Govmnt Debt Burden y"]
    @parameters MWDB = params[:MWDB] [description = "Max Workers Debt Burden y"]
    @parameters OSF1980 = params[:OSF1980] [description = "Owner Savings Fraction in 1980"]
    @parameters STR = params[:STR] [description = "Sales Tax Rate"]
    @parameters TAB = params[:TAB] [description = "Time to Adjust Budget y"]
    @parameters TAOC = params[:TAOC] [description = "Time to Adjust Owner Consumption y"]
    @parameters TAWC = params[:TAWC] [description = "Time to Adjust Worker Consumption y"]
    @parameters TINT = params[:TINT] [description = "Time to Implement New Taxes y"]
    @parameters WCF = params[:WCF] [description = "Worker Consumption Fraction"]
    @parameters WDP = params[:WDP] [description = "Worker Drawdown Period y"]
    @parameters WPP = params[:WPP] [description = "Worker Payback Period y"]

    @variables BCIL(t) [description = "Bank Cash Inflow from Lending GDollar/y"]
    @variables BCISNI(t) [description = "Bank Cash Inflow as Share of NI (1)"]
    @variables BITRO(t) [description = "Basic Income Tax Rate Owners (1)"]
    @variables CANCD(t) [description = "CANCellation of Debt GDollar/y"]
    @variables CD(t) [description = "Consumption Demand GDollar/y"]
    @variables CFGB(t) [description = "Cash Flow from Govmnt to Banks GDollar/y"]
    @variables CFWB(t) [description = "Cash Flow from Workers to Banks GDollar/y"]
    @variables CONTR(t) [description = "CONTRol: (C+G+S)/NI = 1"]
    @variables CPP(t) [description = "Consumption Per Person GDollar/y"]
    @variables CSGDP(t) [description = "Consumption Share of GDP (1)"]
    @variables EGTF2022(t) [description = "Extra General Tax From 2022 Gdollar/y"]
    @variables ETF2022(t) = inits[:ETF2022] [description = "Extra Taxes From 2022 GDollar/y"]
    @variables ETTAF2022(t) [description = "Extra Taxes for TAs From 2022 GDollar/y"]
    @variables FGBW(t) = inits[:FGBW] [description = "Fraction of Govmnt Budget to Workers (1)"]
    @variables GCIN(t) [description = "Govmnt Cash INflow GDollar/y"]
    @variables GD(t) = 28087 * params[:MATGF] [description = "Govmnt Debt Gdollar"]
    @variables GDB(t) [description = "Govmnt Debt Burden y"]
    @variables GETF2022(t) [description = "Goal for Extra Taxes From 2022 GDollar/y"]
    @variables GFGBW(t) [description = "Goal for Fraction of Govmnt Budget to Workers (1)"]
    @variables GFSNI(t) [description = "Govmnt Finance as Share of NI (1)"]
    @variables GGI(t) [description = "Govmnt Gross Income GDollar/y"]
    @variables GGIS(t) [description = "Govmnt Gross Income (as Share of NI)"]
    @variables GIC(t) [description = "Govmnt Interest Cost GDollar/y"]
    @variables GIPC(t) [description = "Govmnt Investment in Public Capacity GDollar/y"]
    @variables GND(t) [description = "Govmnt New Debt GDollar/y"]
    @variables GNI(t) = inits[:GNI] [description = "Govmnt Net Income GDollar/y"]
    @variables GNISNI(t) [description = "Govmnt Net Income as Share of NI (1)"]
    @variables GP(t) [description = "Govmnt Payback GDollar/y"]
    @variables GPU(t) [description = "Govmnt PUrchases GDollar/y"]
    @variables GS(t) [description = "Govmnt Spending GDollar/y"]
    @variables GSGDP(t) [description = "Govmnt Share of GDP (1)"]
    @variables IC2022(t) [description = "Income from Commons from 2022 GDollar/y"]
    @variables INEQ(t) [description = "INEQuality (1)"]
    @variables INEQI(t) [description = "INEQuality Index (1980=1)"]
    @variables ITO(t) [description = "Income Tax Owners (1)"]
    @variables ITW(t) [description = "Income Tax Workers (1)"]
    @variables MGD(t) [description = "Max Govmnt Debt GDollar"]
    @variables MWD(t) [description = "Max Workers Debt GDollar"]
    @variables OC(t) [description = "Owner Consumption GDollar/y"]
    @variables OCF(t) [description = "Owner Consumptin Fraction (1)"]
    @variables OCIN(t) [description = "Owner Cash INflow GDollar/y"]
    @variables OI(t) [description = "Owner Income GDollar/y"]
    @variables OOIAT(t) [description = "Owner Operating Income After Tax GDollar/y"]
    @variables OS(t) [description = "Owner Savings GDollar/y"]
    @variables OSF(t) [description = "Owner Savings Fraction (1)"]
    @variables OT(t) [description = "Owner Taxes GDollar/y"]
    @variables OTR(t) [description = "Owner Tax Rate (1)"]
    @variables PGCIN(t) = inits[:PGCIN] [description = "Permanent Govmnt Cash INflow GDollar/y"]
    @variables POCI(t) = inits[:POCI] [description = "Permanent Owner Cash Inflow GDollar/y"]
    @variables PWCIN(t) = inits[:PWCIN] [description = "Permanent Worker Cash INflow GDollar/y"]
    @variables SSGDP(t) [description = "Savings Share of GDP (1)"]
    @variables ST(t) [description = "Sales Tax GDollar/y"]
    @variables STO(t) [description = "Sales Tax Owners GDollar/y"]
    @variables STW(t) [description = "Sales Tax Workers GDollar/y"]
    @variables TP(t) [description = "Transfer Payments GDollar/y"]
    @variables TPP(t) [description = "Total Purchasing Power GDollar/y"]
    @variables TS(t) [description = "Total Savings GDollar/y"]
    @variables WCD(t) [description = "Worker consumption demand GDollar/y"]
    @variables WCIN(t) [description = "Worker Cash INflow GDollar/y"]
    @variables WD(t) = 18992 * params[:MATWF] [description = "Workers Debt GDollar"]
    @variables WDB(t) [description = "Worker Debt Burden y"]
    @variables WDI(t) [description = "Worker Disposable Income kDollar/p/y"]
    @variables WFCSI(t) [description = "Worker Finance Cost as Share of Income (1)"]
    @variables WI(t) [description = "Worker Income GDollar/y"]
    @variables WIAT(t) [description = "Worker Income After Tax GDollar/y"]
    @variables WIC(t) [description = "Worker Interest Cost GDollar/y"]
    @variables WND(t) [description = "Workers New Debt GDollar/y"]
    @variables WP(t) [description = "Workers Payback GDollar/y"]
    @variables WS(t) [description = "Worker Savings GDollar/y"]
    @variables WT(t) [description = "Worker Taxes GDollar/y"]
    @variables WTR(t) [description = "Worker Tax Rate (1)"]

    @variables ECTAF2022(t)
    @variables EGDPP(t)
    @variables GBC(t)
    @variables IPP(t)
    @variables NI(t)
    @variables POP(t)
    @variables WBC(t)
    @variables WF(t)
    @variables WSO(t)

    eqs = []

    add_equation!(eqs, BCIL ~ CFWB + CFGB)
    add_equation!(eqs, BCISNI ~ BCIL / NI)
    add_equation!(eqs, BITRO ~ min(1, ITRO1980) + ramp(t, (ITRO2022 - ITRO1980) / 42, 1980, 2022) + ramp(t, (GITRO - ITRO2022) / 78, 2022, 2100))
    add_equation!(eqs, CANCD ~ pulse(t, 2022, 1) * GD * FGDC2022)
    add_equation!(eqs, CD ~ WCD - STW + OC - STO)
    add_equation!(eqs, CFGB ~ GIC + GP - GND)
    add_equation!(eqs, CFWB ~ WIC + WP - WND)
    add_equation!(eqs, CPP ~ CD / POP)
    add_equation!(eqs, CSGDP ~ CD / NI)
    add_equation!(eqs, CONTR ~ CSGDP + GSGDP + SSGDP)
    add_equation!(eqs, EGTF2022 ~ IfElse.ifelse(t > 2022, EGTRF2022 + EETF2022 + EPTF2022, 0) * NI)
    smooth!(eqs, ETF2022, GETF2022, TINT)
    add_equation!(eqs, ETTAF2022 ~ IfElse.ifelse(t > 2022, ECTAF2022 * FETACPET, 0))
    smooth!(eqs, FGBW, GFGBW, TINT)
    add_equation!(eqs, GCIN ~ GNI - CFGB)
    add_equation!(eqs, D(GD) ~ GND - CANCD - GP)
    add_equation!(eqs, GDB ~ GD / NI)
    add_equation!(eqs, GETF2022 ~ EGTF2022 + ETTAF2022)
    add_equation!(eqs, GFGBW ~ FT1980 + IfElse.ifelse(t > 2022, ETGBW, 0))
    add_equation!(eqs, GFSNI ~ (GIC + GP) / NI)
    add_equation!(eqs, GGI ~ WT + OT + STO + STW + IC2022)
    add_equation!(eqs, GGIS ~ GGI / NI)
    add_equation!(eqs, GIC ~ GD * GBC)
    add_equation!(eqs, GIPC ~ PGCIN - GPU)
    add_equation!(eqs, GND ~ max(0, (MGD - GD) / GDDP) + step(t, GSF2022, 2022) * NI)
    add_equation!(eqs, GNI ~ GGI - TP + ST)
    add_equation!(eqs, GNISNI ~ GNI / NI)
    add_equation!(eqs, GP ~ GD / GPP)
    add_equation!(eqs, GPU ~ PGCIN * GCF)
    add_equation!(eqs, GS ~ GPU + GIPC)
    add_equation!(eqs, GSGDP ~ GS / NI)
    add_equation!(eqs, IC2022 ~ NI * IfElse.ifelse(t > 2022, ramp(t, GEIC / IPP, 2022, 2020 + IPP), 0))
    add_equation!(eqs, INEQ ~ OOIAT / WIAT)
    add_equation!(eqs, INEQI ~ INEQ / INEQ1980)
    add_equation!(eqs, ITO ~ BITRO * NI * (1 - WSO))
    add_equation!(eqs, ITW ~ BITRW * NI * WSO)
    add_equation!(eqs, MGD ~ NI * MGDB)
    add_equation!(eqs, MWD ~ WI * MWDB)
    add_equation!(eqs, OC ~ POCI * OCF)
    add_equation!(eqs, OCF ~ 1 - OSF)
    add_equation!(eqs, OCIN ~ OOIAT)
    add_equation!(eqs, OI ~ NI * (1 - WSO))
    add_equation!(eqs, OOIAT ~ OI - OT)
    add_equation!(eqs, OS ~ POCI - OC)
    add_equation!(eqs, OSF ~ OSF1980 * (1 + GDPOSR * (EGDPP / GDPP1980 - 1)))
    add_equation!(eqs, OT ~ ITO + ETF2022 * FETPO)
    add_equation!(eqs, OTR ~ OT / OI)
    smooth!(eqs, PGCIN, GCIN, TAB)
    smooth!(eqs, POCI, OCIN, TAOC)
    smooth!(eqs, PWCIN, WCIN, TAWC)
    add_equation!(eqs, SSGDP ~ TS / NI)
    add_equation!(eqs, ST ~ STW + STO)
    add_equation!(eqs, STO ~ OC * STR)
    add_equation!(eqs, STW ~ WCD * STR)
    add_equation!(eqs, TP ~ GGI * FGBW)
    add_equation!(eqs, TPP ~ WCIN + GCIN + OCIN - ST)
    add_equation!(eqs, TS ~ OS + WS)
    add_equation!(eqs, WCD ~ PWCIN * WCF)
    add_equation!(eqs, WCIN ~ WIAT - CFWB)
    add_equation!(eqs, D(WD) ~ WND - WP)
    add_equation!(eqs, WDI ~ PWCIN / WF)
    add_equation!(eqs, WFCSI ~ CFWB / WIAT)
    add_equation!(eqs, WI ~ NI * WSO)
    add_equation!(eqs, WIAT ~ WI - WT + TP)
    add_equation!(eqs, WIC ~ WD * WBC)
    add_equation!(eqs, WT ~ ITW + ETF2022 * (1 - FETPO))
    add_equation!(eqs, WTR ~ WT / WI)
    add_equation!(eqs, WND ~ max(0, (MWD - WD) / WDP))
    add_equation!(eqs, WP ~ WD / WPP)
    add_equation!(eqs, WDB ~ WD / WIAT)
    add_equation!(eqs, WS ~ PWCIN - WCD)

    return ODESystem(eqs; name=name)
end

function demand_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)

    @variables ECTAF2022(t) [description = "Public.Extra Cost of TAs from 2022 Gdollar/y"]
    @variables EGDPP(t) [description = "Population.Effective GDP per person kDollar/p/y"]
    @variables GBC(t) [description = "Finance.Govmnt borrowing cost 1/y"]
    @variables IPP(t) [description = "Wellbeing.Introduction period for policy y"]
    @variables NI(t) [description = "Inventory.National income GDollar/y"]
    @variables POP(t) [description = "Population.Population Mp"]
    @variables WBC(t) [description = "Finance.Worker borrowing cost 1/y"]
    @variables WF(t) [description = "Labour and market.Work force Mp"]
    @variables WSO(t) [description = "Labour and market.Worker Share of Output (1)"]


    eqs = []


    add_equation!(eqs, ECTAF2022 ~ WorldDynamics.interpolate(t, tables[:ECTAF2022], ranges[:ECTAF2022]))
    add_equation!(eqs, EGDPP ~ WorldDynamics.interpolate(t, tables[:EGDPP], ranges[:EGDPP]))
    add_equation!(eqs, GBC ~ WorldDynamics.interpolate(t, tables[:GBC], ranges[:GBC]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, NI ~ WorldDynamics.interpolate(t, tables[:NI], ranges[:NI]))
    add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))
    add_equation!(eqs, WBC ~ WorldDynamics.interpolate(t, tables[:WBC], ranges[:WBC]))
    add_equation!(eqs, WF ~ WorldDynamics.interpolate(t, tables[:WF], ranges[:WF]))
    add_equation!(eqs, WSO ~ WorldDynamics.interpolate(t, tables[:WSO], ranges[:WSO]))

    return ODESystem(eqs; name=name)
end

