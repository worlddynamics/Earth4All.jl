include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function labour_market(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters AUR = params[:AUR] [description = "Acceptable Unemployment Rate"]
    @parameters FIC = params[:FIC] [description = "Fraction of Inflation Compensated"]
    @parameters GDPENHW = params[:GDPENHW] [description = "sTIeoNHW<0: GDP Effect on Number Hours Worked"]
    @parameters GDPPEROCCLRM = params[:GDPPEROCCLRM] [description = "sGDPppeoROCCLR<0: GDPP Effect on ROC in CLR"]
    # @parameters GDPP80 = params[:GDPP80] [description = "GDP per Person in 1980"]
    @parameters GENLPR = params[:GENLPR] [description = "Goal for Extra Normal Labour Participation Rate"]
    @parameters HFD = params[:TYLD] / 3 [description = "Hiring/Firing Delay y"]
    @parameters PFTJ = params[:PFTJ] [description = "Persons per Full-Time Job p/ftj"]
    @parameters PFTJ80 = params[:PFTJ80] [description = "Persons per Full-Time Job in 1980 p/ftj"]
    @parameters PRUN = params[:PRUN] [description = "PRice per UNit dollar/u"]
    @parameters PUELPR = params[:PUELPR] [description = "sPUNeoLPR>0: Perceived Unemployment Effect on LPR"]
    @parameters RWER = params[:RWER] [description = "Real Wage Erosion Rate 1/y"]
    @parameters TAHW = params[:TAHW] [description = "Time to Adjust Hours Worked y"]
    @parameters TCT = params[:TYLD] / 3 [description = "Time to Change Tooling y"]
    @parameters TELLM = params[:TELLM] [description = "Time to Enter/Leave Labor Market y"]
    @parameters TYLD = params[:TYLD] [description = "Ten-Yr Loop Delay y"]
    @parameters UPT = params[:TYLD] / 3 [description = "Unemployment Perception Time y"]
    @parameters WSOECLR = params[:WSOECLR] [description = "sWSOeoCLR>0: Worker Share of Output Effect on Capital Ratio Labour"]
    @parameters WSOELPR = params[:WSOELPR] [description = "sWSOeoLPR>0: Worker Share of Output Effect on Labour Participation Rate"]

    @variables AGIW(t) [description = "Average Gross Income per Worker kdollar/p/y"]
    @variables AHW(t) [description = "Average Hours Worked kh/y"]
    @variables AVWO(t) [description = "AVailable WOrkforce Mp"]
    @variables CECLR(t) [description = "Change in Embedded CLR kcu/ftj/y"]
    @variables CHWO(t) [description = "CHange in WOrkforce Mp"]
    @variables CWR(t) [description = "Change in wage rate dollar/ph/y"]
    @variables CWSO(t) [description = "Change in WSO 1/y"]
    @variables ECLR(t) = inits[:ECLR] [description = "Embedded Capital Labour Ratio kcu/ftj"]
    @variables ENLPR2022(t) [description = "Extra Normal Labour Participation Rate from 2022"]
    @variables GDPPEROCCLR(t) [description = "GDPppeoROCCLR: GDPP Effect on ROC in CLR"]
    @variables HWMGDPP(t) [description = "Hours Worked Mult from GDPpP"]
    @variables IWEOCLR(t) [description = "Indicated Wage Effect on Optimal CLR"]
    @variables ILPR(t) [description = "Indicated Labour Participation Rate"]
    @variables LAPR(t) = inits[:LAPR] [description = "LAbour PRoductivity dollar/ph"]
    @variables LAUS(t) = inits[:LAUS] [description = "LAbour USe Gph/y"]
    @variables LPR(t) = inits[:ILPR] [description = "Labour Participation Rate"]
    @variables LTEWSO(t) [description = "Long-Term Erosion of WSO 1/y"]
    @variables NHW(t) = inits[:NHW] [description = "Normal Hours Worked kh/ftj/y"]
    @variables NLPR(t) = inits[:NLPR] [description = "Normal LPR"]
    @variables OCLR(t) [description = "Optimal Capital Labour Ratio kcu/ftj"]
    @variables OPWO(t) [description = "OPtimal WOrkforce Mp"]
    @variables PART(t) [description = "Participation"]
    @variables PSW(t) [description = "Perceived Surplus Workforce"]
    @variables PURA(t) = inits[:UNRA] [description = "Perceived Unemployment RAte"]
    @variables ROCECLR(t) = inits[:ROCECLR] [description = "Rate Of Change in ECLR 1/y"]
    @variables ROCWSO(t) [description = "ROC in WSO - Table 1/y"]
    @variables UNEM(t) [description = "UNEMployed Mp"]
    @variables UNRA(t) [description = "UNemployment RAte"]
    @variables WAP(t) [description = "Working Age Population Mp"]
    @variables WARA(t) = inits[:WARA] [description = "WAge RAte dollar/ph"]
    @variables WASH(t) [description = "WAge Share"]
    @variables WEOCLR(t) = inits[:WEOCLR] [description = "Wage Effect on Optimal CLR"]
    @variables WF(t) = inits[:WF] [description = "WorkForce Mp"]
    @variables WRER(t) [description = "Wage Rate Erosion Rate 1/y"]
    @variables WRE(t) [description = "Wage Rate Erosion dollar/ph/y"]
    @variables WSO(t) = inits[:WSO] [description = "Worker Share of Output"]

    @variables A20PA(t)
    @variables CAPA(t)
    @variables GDPP(t)
    @variables IR(t)
    @variables IPP(t)
    @variables OUTP(t)

    eqs = []

    add_equation!(eqs, AGIW ~ WARA * AHW)
    add_equation!(eqs, AHW ~ NHW / PFTJ)
    add_equation!(eqs, AVWO ~ WAP * LPR)
    add_equation!(eqs, CECLR ~ ROCECLR * ECLR)
    add_equation!(eqs, CHWO ~ (OPWO - WF) / HFD)
    add_equation!(eqs, CWSO ~ WSO * ROCWSO)
    add_equation!(eqs, CWR ~ WARA * ROCWSO)
    add_equation!(eqs, D(ECLR) ~ CECLR)
    add_equation!(eqs, GDPPEROCCLR ~ max(0, 1 + GDPPEROCCLRM * (GDPP / inits[:GDPP] - 1)))
    add_equation!(eqs, ENLPR2022 ~ ramp(t, GENLPR / IPP, 2022, 2022 + IPP))
    add_equation!(eqs, HWMGDPP ~ 1 + GDPENHW * (GDPP / inits[:GDPP] - 1))
    add_equation!(eqs, IWEOCLR ~ 1 + WSOECLR * (WSO / inits[:WSO] - 1))
    add_equation!(eqs, ILPR ~ NLPR - PSW)
    add_equation!(eqs, LAPR ~ (OUTP * PRUN) / LAUS)
    add_equation!(eqs, LAUS ~ WF * AHW)
    smooth!(eqs, LPR, ILPR, TELLM)
    add_equation!(eqs, LTEWSO ~ WSO * RWER)
    smooth!(eqs, NHW, inits[:NHW] * HWMGDPP, TAHW)
    add_equation!(eqs, NLPR ~ inits[:NLPR] * (1 + WSOELPR * (WSO / inits[:WSO] - 1)) + ENLPR2022)
    add_equation!(eqs, OCLR ~ ECLR * WEOCLR)
    add_equation!(eqs, OPWO ~ (CAPA / OCLR) * PFTJ)
    add_equation!(eqs, PART ~ LPR * (1 - PURA))
    add_equation!(eqs, PSW ~ AUR * (1 + PUELPR * (PURA / AUR - 1)))
    smooth!(eqs, PURA, UNRA, UPT)
    add_equation!(eqs, ROCECLR ~ inits[:ROCECLR] * GDPPEROCCLR)
    add_equation!(eqs, ROCWSO ~ interpolate1(PURA / AUR, [(0.0, 0.06), (0.5, 0.02), (1.0, 0.0), (1.5, -0.007), (2.0, -0.01)]))
    add_equation!(eqs, UNEM ~ max(0, AVWO - WF))
    add_equation!(eqs, UNRA ~ UNEM / AVWO)
    add_equation!(eqs, WAP ~ A20PA)
    add_equation!(eqs, D(WARA) ~ CWR - WRE)
    add_equation!(eqs, WASH ~ WARA / LAPR)
    smooth!(eqs, WEOCLR, IWEOCLR, TCT)
    add_equation!(eqs, D(WF) ~ CHWO)
    add_equation!(eqs, WRE ~ WARA * WRER)
    add_equation!(eqs, WRER ~ IR * (1 - FIC))
    add_equation!(eqs, D(WSO) ~ CWSO - LTEWSO)

    return ODESystem(eqs; name=name)
end

function labour_market_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables A20PA(t) [description = "Aged 20-Pension Age Mp"]
    @variables CAPA(t) [description = "Capacity Gcu"]
    @variables GDPP(t) [description = "GDP per Person kDollar/p/y"]
    @variables IR(t) [description = "Inflation Rate 1/y"]
    @variables IPP(t) [description = "Introduction Period for Policy y"]
    @variables OUTP(t) [description = "OUTput Gu/y"]

    eqs = []

    add_equation!(eqs, A20PA ~ WorldDynamics.interpolate(t, tables[:A20PA], ranges[:A20PA]))
    add_equation!(eqs, CAPA ~ WorldDynamics.interpolate(t, tables[:CAPA], ranges[:CAPA]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, IR ~ WorldDynamics.interpolate(t, tables[:IR], ranges[:IR]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, OUTP ~ WorldDynamics.interpolate(t, tables[:OUTP], ranges[:OUTP]))

    return ODESystem(eqs; name=name)
end