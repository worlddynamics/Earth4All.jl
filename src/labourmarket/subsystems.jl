include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function labour_market(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters AUR = params[:AUR] [description = "Acceptable Unemployment Rate (1)"]
    @parameters FIC = params[:FIC] [description = "Fraction of Inflation Compensated (1)"]
    @parameters GDPP1980 = params[:GDPP1980] [description = "GDP per Person in 1980"]
    @parameters GDPPEROCCLRM = params[:GDPPEROCCLRM] [description = "sGDPppeoROCCLR<0: GDPP Effect on Rate Of Change in Capital Labour Ratio"]
    @parameters GENLPR = params[:GENLPR] [description = "Goal for Extra Normal LPR (1)"]
    @parameters NLPR80 = params[:NLPR80] [description = "Normal LPR in 1980 (1)"]
    @parameters PFTJ = params[:PFTJ] [description = "Persons per Full-Time Job p/ftj"]
    @parameters PFTJ80 = params[:PFTJ80] [description = "Persons per Full-Time Job in 1980 p/ftj"]
    @parameters PRUN = params[:PRUN] [description = "PRice per UNit dollar/u"]
    @parameters PUELPR = params[:PUELPR] [description = "sPUNeoLPR>0: Perceived Unemployment Effect on Labour Participation Rate"]
    @parameters ROCECLR80 = params[:ROCECLR80] [description = "ROC in ECLR in 1980 1/y"]
    @parameters RWER = params[:RWER] [description = "Real Wage Erosion Rate 1/y"]
    @parameters TAHW = params[:TAHW] [description = "Time to Adjust Hours Worked y"]
    @parameters TELLM = params[:TELLM] [description = "Time to Enter/Leave Labor Market y"]
    @parameters TENHW = params[:TENHW] [description = "sTIeoNHW<0: Time Effect on Number Hours Worked"]
    @parameters TYLD = params[:TYLD] [description = "10-Yr Loop Delay y"]
    @parameters WSOECLR = params[:WSOECLR] [description = "sWSOeoCLR>0: Worker Share of Output Effect on Capital Labour Ratio "]
    @parameters WSOELPR = params[:WSOELPR] [description = "sWSOeoLPR>0: Worker Share of Output Effect on Labour Participation Rate"]

    @variables AGIW(t) [description = "Average Gross Income per Worker kdollar/p/y"]
    @variables AHW(t) [description = "Average Hours Worked kh/y"]
    @variables AHW1980(t) [description = "Average Hours Worked in 1980 kh/y"]
    @variables AVWO(t) [description = "AVailable WOrkforce Mp"]
    @variables CECLR(t) [description = "Change in Embedded CLR kcu/ftj/y"]
    @variables CHWO(t) [description = "CHange in WOrkforce Mp/y"]
    @variables CWRA(t) [description = "Change in Wage RAte dollar/ph/y"]
    @variables CWSO(t) [description = "Change in WSO 1/y"]
    @variables ECLR(t) = inits[:ECLR] [description = "Embedded CLR kcu/ftj"]
    @variables ENLPR2022(t) [description = "Extra Normal LPR from 2022 (1)"]
    @variables GDPPEROCCLR(t) [description = "GDPppeoROCCLR"]
    @variables HFD(t) [description = "Hiring/Firing Delay y"]
    @variables HWMGDPP(t) [description = "Hours Worked Mult from GDPpP (1)"]
    @variables IWEOCLR(t) [description = "Indicated Wage Effect on Optimal CLR (1)"]
    @variables ILPR(t) [description = "Indicated Labour Participation Rate (1)"]
    @variables LAPR(t) [description = "LAbour PRoductivity dollar/ph"]
    @variables LAUS(t) = inits[:LAUS] [description = "LAbour USe Gph/y"]
    @variables LAUS80(t) [description = "LAbour USe in 1980 Gph/y"]
    @variables LPR(t) = inits[:ILPR] [description = "Labour Participation Rate (1)"]
    @variables LTEWSO(t) [description = "Long-Term Erosion of WSO 1/y"]
    @variables NHW(t) = inits[:NHW] [description = "Normal Hours Worked kh/ftj/y"]
    @variables NLPR(t) [description = "Normal LPR (1)"]
    @variables OCLR(t) [description = "Optimal Capital Labour Ratio kcu/ftj"]
    @variables OPWO(t) [description = "OPtimal WOrkforce Mp"]
    @variables PART(t) [description = "Participation (1)"]
    @variables PSW(t) [description = "Perceived Surplus Workforce (1)"]
    @variables PURA(t) = inits[:PURA] [description = "Perceived Unemployment RAte (1)"]
    @variables ROCECLR(t) [description = "ROC in ECLR 1/y"]
    @variables ROCWSO(t) [description = "ROC in WSO - Table 1/y"]
    @variables TCT(t) [description = "Time to Change Tooling y"]
    @variables UNEM(t) [description = "UNEMployed Mp"]
    @variables UR(t) [description = "UNemployment RAte (1)"]
    @variables UPT(t) [description = "Unemployment perception time y"]
    @variables WAP(t) [description = "Working Age Population Mp"]
    @variables WARA(t) = inits[:WARA] [description = "WAge RAte dollar/ph"]
    @variables WASH(t) [description = "WAge Share (1)"]
    @variables WEOCLR(t) = inits[:WEOCLR] [description = "Wage Effect on Optimal CLR (1)"]
    @variables WF(t) = inits[:WF] [description = "WorkForce Mp"]
    @variables WRER(t) [description = "Wage Rate Erosion Rate 1/y"]
    @variables WRE(t) [description = "Wage Rate Erosion dollar/ph/y"]
    @variables WSO(t) = inits[:WSO] [description = "Worker Share of Output (1)"]

    @variables A20PA(t)
    @variables CAP(t)
    @variables GDPP(t)
    @variables IR(t)
    @variables IPP(t)
    @variables OUTP(t)

    eqs = []

    add_equation!(eqs, AGIW ~ WARA * AHW)
    add_equation!(eqs, AHW ~ NHW / PFTJ)
    add_equation!(eqs, AHW1980 ~ inits[:NHW] / PFTJ80)
    add_equation!(eqs, AVWO ~ WAP * LPR)
    add_equation!(eqs, CECLR ~ ROCECLR * ECLR)
    add_equation!(eqs, CHWO ~ (OPWO - WF) / HFD)
    add_equation!(eqs, CWSO ~ WSO * ROCWSO)
    add_equation!(eqs, CWRA ~ WARA * ROCWSO)
    add_equation!(eqs, D(ECLR) ~ CECLR)
    add_equation!(eqs, GDPPEROCCLR ~ max(0, 1 + GDPPEROCCLRM * (GDPP / GDPP1980 - 1)))
    add_equation!(eqs, ENLPR2022 ~ ramp(t, GENLPR / IPP, 2022, 2022 + IPP))
    add_equation!(eqs, HFD ~ TYLD / 3)
    add_equation!(eqs, HWMGDPP ~ 1 + TENHW * (GDPP / GDPP1980 - 1))
    add_equation!(eqs, IWEOCLR ~ 1 + WSOECLR * (WSO / inits[:WSO] - 1))
    add_equation!(eqs, ILPR ~ NLPR - PSW)
    add_equation!(eqs, LAPR ~ (OUTP * PRUN) / LAUS)
    add_equation!(eqs, LAUS ~ WF * AHW)
    add_equation!(eqs, LAUS80 ~ inits[:WF] * AHW1980)
    smooth!(eqs, LPR, ILPR, TELLM)
    add_equation!(eqs, LTEWSO ~ WSO * RWER)
    smooth!(eqs, NHW, inits[:NHW] * HWMGDPP, TAHW)
    add_equation!(eqs, NLPR ~ NLPR80 * (1 + WSOELPR * (WSO / inits[:WSO] - 1)) + ENLPR2022)
    add_equation!(eqs, OCLR ~ ECLR * WEOCLR)
    add_equation!(eqs, OPWO ~ (CAP / OCLR) * PFTJ)
    add_equation!(eqs, PART ~ LPR * (1 - PURA))
    add_equation!(eqs, PSW ~ AUR * (1 + PUELPR * (PURA / AUR - 1)))
    smooth!(eqs, PURA, UR, UPT)
    add_equation!(eqs, ROCECLR ~ ROCECLR80 * GDPPEROCCLR)
    add_equation!(eqs, ROCWSO ~ withlookup(PURA / AUR, [(0.0, 0.06), (0.5, 0.02), (1.0, 0.0), (1.5, -0.007), (2.0, -0.01)]))
    add_equation!(eqs, TCT ~ TYLD / 3)
    add_equation!(eqs, UNEM ~ max(0, AVWO - WF))
    add_equation!(eqs, UPT ~ TYLD / 3)
    add_equation!(eqs, UR ~ UNEM / AVWO)
    add_equation!(eqs, WAP ~ A20PA)
    add_equation!(eqs, D(WARA) ~ CWRA - WRE)
    add_equation!(eqs, WASH ~ WARA / LAPR)
    smooth!(eqs, WEOCLR, IWEOCLR, TCT)
    add_equation!(eqs, D(WF) ~ CHWO)
    add_equation!(eqs, WRE ~ WARA * WRER)
    add_equation!(eqs, WRER ~ IR * (1 - FIC))
    add_equation!(eqs, D(WSO) ~ CWSO - LTEWSO)

    return ODESystem(eqs; name=name)
end

function labour_market_full_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables A20PA(t) [description = "Population.Aged 20-Pension Age Mp"]
    @variables CAP(t) [description = "Output.CAPacity Gcu"]
    @variables GDPP(t) [description = "Population.GDP per Person kDollar/p/y"]
    @variables IR(t) [description = "Inventory.Inflation Rate 1/y"]
    @variables IPP(t) [description = "Wellbeing.Introduction Period for Policy y"]
    @variables OUTP(t) [description = "Inventory.OUTput Gu/y"]

    eqs = []

    add_equation!(eqs, A20PA ~ WorldDynamics.interpolate(t, tables[:A20PA], ranges[:A20PA]))
    add_equation!(eqs, CAP ~ WorldDynamics.interpolate(t, tables[:CAP], ranges[:CAP]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, IR ~ WorldDynamics.interpolate(t, tables[:IR], ranges[:IR]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, OUTP ~ WorldDynamics.interpolate(t, tables[:OUTP], ranges[:OUTP]))

    return ODESystem(eqs; name=name)
end

function labour_market_partial_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables A20PA(t) [description = "Population.Aged 20-Pension Age Mp"]
    @variables CAP(t) [description = "Output.CAPacity Gcu"]
    @variables GDPP(t) [description = "Population.GDP per Person kDollar/p/y"]
    @variables IR(t) [description = "Inventory.Inflation Rate 1/y"]
    @variables IPP(t) [description = "Wellbeing.Introduction Period for Policy y"]
    @variables OUTP(t) [description = "Inventory.OUTput Gu/y"]

    eqs = []

    add_equation!(eqs, A20PA ~ WorldDynamics.interpolate(t, tables[:A20PA], ranges[:A20PA]))
    add_equation!(eqs, CAP ~ WorldDynamics.interpolate(t, tables[:CAP], ranges[:CAP]))
    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, IR ~ WorldDynamics.interpolate(t, tables[:IR], ranges[:IR]))
    add_equation!(eqs, IPP ~ WorldDynamics.interpolate(t, tables[:IPP], ranges[:IPP]))
    add_equation!(eqs, OUTP ~ WorldDynamics.interpolate(t, tables[:OUTP], ranges[:OUTP]))

    return ODESystem(eqs; name=name)
end
