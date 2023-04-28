include("../functions.jl")
@register ramp(x, slope, startx, endx)


@variables t
D = Differential(t)

function demand(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t)
    @variables POP(t)
    @variables IPP(t)
    @variables WSO(t)
    @variables NI(t)
    @variables ECTAF2022(t)
    @variables GBC(t)
    @variables WBC(t)
    @variables WF(t)
    @variables EGDPP(t)


    @parameters GITRO = params[:GITRO] [description = "Goal for income tax rate owners"]
    @parameters ITRO2022 = params[:ITRO2022] [description = "Income tax rate owners in 2022"]
    @parameters ITRO1980 = params[:ITRO1980] [description = "Income tax rate owners in 1980"]
    @parameters BITRW = params[:BITRW] [description = "Basic income tax rate workers"]
    @parameters EETF2022 = params[:EETF2022] [description = "Extra empowerment tax from 2022 (share of NI)"]
    @parameters EPTF2022 = params[:EPTF2022] [description = "Extra pension tax from 2022 (share of NI)"]
    @parameters EGTRF2022 = params[:EGTRF2022] [description = "Extra general tax rate from 2022"]
    @parameters FETACPET = params[:FETACPET] [description = "Fraction of extra TA cost paid by extra taxes"]
    @parameters TINT = params[:TINT] [description = "Time to implement new taxes y"]
    @parameters FETPO = params[:FETPO] [description = "Fraction of extra TA paid by owners"]
    @parameters ETGBW = params[:ETGBW] [description = "Extra transfer or government budget to workers"]
    @parameters FT1980 = params[:FT1980] [description = "Fraction transferred in 1980"]
    @parameters GEIC = params[:GEIC] [description = "Goal for extra income from commons (share of NI)"]
    @parameters INEQ1980 = params[:INEQ1980] [description = "Inequality in 1980"]
    @parameters TAOC = params[:TAOC] [description = "Time to adjust owner consumption y"]
    @parameters OCI1980 = params[:OCI1980] [description = "Owner cash inflow in 1980"]
    @parameters GDPOSR = params[:GDPOSR] [description = "sGDPeoOSR<0"]
    @parameters OSF1980 = params[:OSF1980] [description = "Owner savings fraction in 1980"]
    @parameters MWDB = params[:MWDB] [description = "Max workers debt burden y"]
    @parameters MATWF = params[:MATWF] [description = "Mult to avoid transient in worker finance"]
    @parameters WDP = params[:WDP] [description = "Worker drawdown period y"]
    @parameters WPP = params[:WPP] [description = "Worker payback period y"]
    @parameters TAWC = params[:TAWC] [description = "Time to adjust worker consumption y"]
    @parameters WCF = params[:WCF] [description = "Worker consumption fraction"]
    @parameters STR = params[:STR] [description = "Sales tax rate"]
    @parameters GSF2022 = params[:GSF2022] [description = "Government stimulus from 2022 (share of NI)"]
    @parameters MGDB = params[:MGDB] [description = "Max government debt burden y"]
    @parameters GDDP = params[:GDDP] [description = "Government DrawDown period y"]
    @parameters GPP = params[:GPP] [description = "Government Payback period y"]


    @variables BITRO(t) [description = "Basic income tax rate owners"]
    @variables ITO(t) [description = "Income tax owners"]
    @variables ITW(t) [description = "Income tax workers"]
    @variables EGTF2022(t) [description = "Extra general tax from 2022"]
    @variables EPTF2022(t) [description = "Extra pension tax from 2022"]
    @variables ETTAF2022(t) [description = "Extra taxes for TAs from 2022 GDollar/y"]
    @variables GETF2022(t) [description = "Goal for extra taxes from 2022 GDollar/y"]
    @variables ETF2022(t) = inits[:ETF2022] [description = "Extra taxes from 2022 GDollar/y"]
    @variables WT(t) [description = "Worker taxes GDollar/y"]
    @variables WI(t) [description = "Worker income GDollar/y"]
    @variables WTR(t) [description = "Worker tax rate"]
    @variables GFGBW(t) [description = "Goal for fraction of government budget to workers"]
    @variables FGBW(t) = inits[:FGBW] [description = "Fraction of government budget to workers"]
    @variables IC2022(t) [description = "Income from commons in 2022 GDollar/y"]
    @variables OT(t) [description = "Owner taxes GDollar/y"]
    @variables OI(t) [description = "Owner income GDollar/y"]
    @variables OTR(t) [description = "Owner tax rate"]
    @variables GGIS(t) [description = "Government gross income (as share of NI)"]
    @variables GGI(t) [description = "Government gross income GDollar/y"]
    @variables TP(t) [description = "Transfer payments GDollar/y"]
    @variables WIAT(t) [description = "Worker income after taxes GDollar/y"]
    @variables GNI(t) [description = "Gross net income GDollar/y"]
    @variables GNISNI(t) [description = "Gross net income as share of NI"]
    @variables OOIAT(t) [description = "Owner operating income after taxes GDollar/y"]
    @variables INEQ(t) [description = "Inequality"]
    @variables INEQI(t) [description = "Inequality index (1980 = 1)"]
    @variables OCI(t) [description = "Owner cash inflow GDollar/y"]
    @variables POCI(t) = inits[:POCI] [description = "Permanent owner cash inflow GDollar/y"]
    @variables OSF(t) [description = "Owner savings fraction"]
    @variables OCF(t) [description = "Owner consumption fraction"]
    @variables OC(t) [description = "Owner consumption GDollar/y"]
    @variables OS(t) [description = "Owner savings GDollar/y"]
    @variables TS(t) [description = "Total savings GDollar/y"]
    @variables MWD(t) [description = "Max workers debt GDollar"]
    @variables WD1980(t) [description = "Workers debt in 1980 GDollar"]
    @variables WND(t) [description = "Workers new debt GDollar/y"]
    @variables WD(t) = inits[:WD] [description = "Workers debt GDollar"]
    @variables WP(t) [description = "Workers payback GDollar/y"]
    @variables WIC(t) [description = "Worker interest cost GDollar/y"]
    @variables CFWB(t) [description = "Cash flow from workers to banks GDollar/y"]
    @variables WCIN(t) [description = "Worker cash INflow GDollar/y"]
    @variables PWCIN(t) = inits[:PWCIN] [description = "Permanent worker cash INflow GDollar/y"]
    @variables WDI(t) [description = "Worker disposable income kDollar/p/y"]
    @variables WDB(t) [description = "Worker debt burden y"]
    @variables WFCSI(t) [description = "Worker finance cost as share of income"]
    @variables WCD(t) [description = "Worker consumption demand GDollar/y"]
    @variables WS(t) [description = "Worker savings GDollar/y"]
    @variables STW(t) [description = "Sales tax workers GDollar/y"]
    @variables STO(t) [description = "Sales tax owners GDollar/y"]
    @variables ST(t) [description = "Sales tax GDollar/y"]
    @variables CD(t) [description = "Consumption demand GDollar/y"]
    @variables CSGDP(t) [description = "Consumption as share of GDP"] 
    @variables CPP(t) [description = "Consumption per person GDollar/y"]
    @variables MGD(t) [description = "Max government debt GDollar"]

    

    
    eqs = []

    add_equation!(eqs, BITRO ~ min(1, ITRO1980) + ramp(t, (ITRO2022 - ITRO1980) / 42, 1980, 2022) + ramp(t, (GITRO - ITRO2022) / 78, 2022, 2100))
    add_equation!(eqs, ITO ~ BITRO * NI * (1 - WSO))
    add_equation!(eqs, ITW ~ BITRW * NI * WSO)
    add_equation!(eqs, EPTF2022 ~ IfElse.ifelse(t > 2022, EGTRF2022 + EETF2022 + EPTF2022, 0) * NI)
    add_equation!(eqs, ETTAF2022 ~ IfElse.ifelse(t > 2022, ECTAF2022  * FETACPET, 0))
    add_equation!(eqs, GETF2022 ~ EGTF2022 + ETTAF2022)
    smooth!(eqs, ETF2022, GETF2022, TINT)
    add_equation!(eqs, WT ~ ITW + ETF2022 * (1 - FETPO))
    add_equation!(eqs, WI ~ NI * WSO)
    add_equation!(eqs, WTR ~ WT / WI)
    add_equation!(eqs, GFGBW ~ FT1980 + IfElse.ifelse(t > 2022, ETGBW, 0))
    smooth!(eqs, FGBW, GFGBW, TINT)
    add_equation!(eqs, IC2022 ~ NI * IfElse.ifelse(t > 2022, ramp(t, GEIC / IPP, 2022, 2022 + IPP),0))
    add_equation!(eqs, OT ~ ITO + ETF2022 * FETPO)
    add_equation!(eqs, OI ~ NI * (1 - WSO))
    add_equation!(eqs, OTR ~ OT / OI)
    add_equation!(eqs, GGIS ~ GGI / NI)
    add_equation!(eqs, GGI ~ WT + OT + STO + STW + IC2022)
    add_equation!(eqs, TP ~ GGI * FGBW)
    add_equation!(eqs, WIAT ~ WI - WT + TP)
    add_equation!(eqs, GNI ~ GGI - TP + ST) # ST is not defined yet
    add_equation!(eqs, GNISNI ~ GNI / NI)
    add_equation!(eqs, OOIAT ~ OI - OT) 
    add_equation!(eqs, INEQ ~ OOIAT / WIAT)
    add_equation!(eqs, INEQI ~ INEQ / INEQ1980)
    add_equation!(eqs, OCI ~ OOIAT)
    smooth!(eqs, POCI, OCI, TAOC)
    add_equation!(eqs, OSF ~ OSF1980 + (1 + GDPOSR * (EGDPP / GDPP -1)))
    add_equation!(eqs, OCF ~ 1 - OSF)
    add_equation!(eqs, OC ~ POCI * OCF)
    add_equation!(eqs, OS ~ POCI * OC)
    add_equation!(eqs, TS ~ OS + WS) 
    add_equation!(eqs, MWD ~ WI * MWDB)
    add_equation!(eqs, WD1980 ~ 18992 * MATWF)
    add_equation!(eqs, WND ~ max(0, (MWD - WD) / WDP))
    add_equation!(eqs, D(WD) ~ WND - WP)
    add_equation!(eqs, WP ~ WD / WPP)
    add_equation!(eqs, WIC ~ WD * WBC)
    add_equation!(eqs, CFWB ~ WIC + WP - WND)
    add_equation!(eqs, WCIN ~ WIAT - CFWB)
    smooth!(eqs, PWCIN, WCIN, TAWC)
    add_equation!(eqs, WDI ~ PWCIN / WF)
    add_equation!(eqs, WDB ~ WD / WIAT)
    add_equation!(eqs, WFCSI ~ CFWB / WIAT)
    add_equation!(eqs, WCD ~ PWCIN * WCF)
    add_equation!(eqs, WS ~ PWCIN - WCD)
    add_equation!(eqs, STW ~ WCD * STR)
    add_equation!(eqs, STO ~ OC * STR)
    add_equation!(eqs, ST ~ STW + STO)
    add_equation!(eqs, CD ~ WCD - STW + OC - STO)
    add_equation!(eqs, CSGDP ~ CD / NI)
    add_equation!(eqs, CPP ~ CD / POP)
    add_equation!(eqs, MGD ~ NI * MGDB)

    
    return ODESystem(eqs; name=name)
end

function demand_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t) [description = "GDP per person kDollar/p/y"] 
    @variables POP(t) [description = "Population Mp"]
    @variables IPP(t) [description = "Introduction period for policy y"]
    @variables WSO(t) [description = "Worker share output "]
    @variables NI(t) [description = "National income GDollar/y"]
    @variables ECTAF2022(t) [description = "Extra Cost of TAs from 2022"]
    @variables GBC(t) [description = "Government borrowing cost 1/y"]
    @variables WBC(t) [description = "Worker borrowing cost 1/y"]
    @variables WF(t) [description = "Work force Mp"]
    @variables EGDPP(t) [description = "Effective GDP per person kDollar/p/y"]

    
    eqs = []

    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, POP ~ WorldDynamics.interpolate(t, tables[:POP], ranges[:POP]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, WSO ~ WorldDynamics.interpolate(t, tables[:WSO], ranges[:WSO]))
    add_equation!(eqs, NI ~ WorldDynamics.interpolate(t, tables[:NI], ranges[:NI]))
    add_equation!(eqs, ECTAF2022 ~ WorldDynamics.interpolate(t, tables[:ECTAF2022], ranges[:ECTAF2022]))
    add_equation!(eqs, GBC ~ WorldDynamics.interpolate(t, tables[:GBC], ranges[:GBC]))
    add_equation!(eqs, WBC ~ WorldDynamics.interpolate(t, tables[:WBC], ranges[:WBC]))
    add_equation!(eqs, WF ~ WorldDynamics.interpolate(t, tables[:WF], ranges[:WF]))
    add_equation!(eqs, EGDPP ~ WorldDynamics.interpolate(t, tables[:EGDPP], ranges[:EGDPP]))
    
    return ODESystem(eqs; name=name)
end

