include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function wellbeing(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters AI = params[:AI] [description = "Acceptable Inequality"]
    @parameters AP = params[:AP] [description = "Acceptable Progress 1/y"]
    @parameters AWBPD = params[:AWBPD] [description = "Average WellBeing Perception Delay y"]
    @parameters DRDI = params[:DRDI] [description = "Diminishing Return Disposable Income"]
    @parameters DRPS = params[:DRPS] [description = "Diminishing Return Public Spending"]
    @parameters EIP = params[:EIP] [description = "Exogenous Introduction Period y"]
    @parameters EIPF = params[:EIPF] [description = "Exogenous Introduction Period Flag"]
    @parameters GWEAWBGWF = params[:GWEAWGWF] [description = "sGWeoAW<0<0: Global Warming Effect on Average WellBeing from Global Warming Flag"]
    @parameters IEAWBIF = params[:IEAWIF] [description = "sIIeoAW<0: Inequality Effect on Average WellBeing from Inequality Flag"]
    @parameters MWBGW = params[:MWBGW] [description = "Min WellBeing from Global Warming"]
    @parameters NRD = params[:NRD] [description = "Normal Reform Delay y"]
    @parameters PAEAWBF = params[:PAEAWBF] [description = "sLPeoAWP>0: PArtecipation Effect on Average WellBeing Flag"]
    @parameters PREAWBF = params[:PREAWBF] [description = "sROPeoAW>0: PRogress Effect on Average WellBeing Flag"]
    @parameters PESTF = params[:PESTF] [description = "sPPReoSTE<0: Progress Effect on Social Tension Flag"]
    @parameters SPS = params[:SPS] [description = "Satisfactory Public Spending"]
    @parameters STEERDF = params[:STEERDF] [description = "sSTEeoRD>0: Social Tension Effect on Reform Delay Flag"]
    @parameters STRERDF = params[:STRERDF] [description = "sSTReoRD<0: Social Trust Effect on Reform Delay Flag"]
    @parameters TCRD = params[:TCRD] [description = "Time to Change Reform Delay y"]
    @parameters TDI = params[:TDI] [description = "Threshold Disposable Income kdollar/p/y"]
    @parameters TEST = params[:TEST] [description = "Time to Establish Social Trust y"]
    @parameters TI = params[:TI] [description = "Threshold Inequality"]
    @parameters TP = params[:TP] [description = "Threshold Participation"]
    @parameters TPR = params[:TPR] [description = "Threshold Progress Rate 1/y"]
    @parameters TPS = params[:TPS] [description = "Threshold Public Spending kdollar/p/y"]
    @parameters TW = params[:TW] [description = "Threshold Warming deg C"]

    @variables IEST(t) [description = "Inequity Effect on Social Trust"]
    @variables IST(t) [description = "Indicated Social Trust"]
    @variables PSESTR(t) [description = "Public Spending Effect on Social TRust"]
    @variables PSSGDP(t) [description = "Public Spending as Share of GDP"]
    @variables ST(t) = inits[:ST] [description = "Social Trust"]

    @variables GDPP(t)
    @variables INEQ(t)
    @variables LBR(t)
    @variables PSP(t)
    @variables PW(t)
    @variables WDI(t)

    eqs = []

    add_equation!(eqs, IEST ~ interpolate(INEQ / AI, [(0.0, 1.0), (1.0, 1.0), (2.0, 0.0)]))
    add_equation!(eqs, IST ~ PSESTR * IEST)
    add_equation!(eqs, PSSGDP ~ PSP / GDPP)
    add_equation!(eqs, PSESTR ~ interpolate(PSSGDP / SPS, [(0.0, 0.0), (1.0, 1.0)]))

    return ODESystem(eqs; name=name)
end

function wellbeing_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDPP(t)
    @variables INEQ(t)
    @variables LBR(t)
    @variables PSP(t)
    @variables PW(t)
    @variables WDI(t)

    eqs = []

    add_equation!(eqs, GDPP ~ WorldDynamics.interpolate(t, tables[:GDPP], ranges[:GDPP]))
    add_equation!(eqs, INEQ ~ WorldDynamics.interpolate(t, tables[:INEQ], ranges[:INEQ]))
    add_equation!(eqs, LBR ~ WorldDynamics.interpolate(t, tables[:LBR], ranges[:LBR]))
    add_equation!(eqs, PSP ~ WorldDynamics.interpolate(t, tables[:PSP], ranges[:PSP]))
    add_equation!(eqs, PW ~ WorldDynamics.interpolate(t, tables[:PW], ranges[:PW]))
    add_equation!(eqs, WDI ~ WorldDynamics.interpolate(t, tables[:WDI], ranges[:WDI]))

    return ODESystem(eqs; name=name)
end