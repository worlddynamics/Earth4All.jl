include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function inventory(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters DAT = params[:DAT] [description = "Demand Adjustment Time y"]
    @parameters DDI = params[:DDI] [description = "DDI in 1980 y"]
    @parameters DIC = params[:DIC] [description = "Desired Inventory Coverage y"]
    @parameters DP = params[:DP] [description = "Demand Pulse 2020-5"]
    @parameters DRI = params[:DRI] [description = "Desired Relative Inventory"]
    @parameters ICPT = params[:ICPT] [description = "Inventory Coverage Perception Time y"]
    @parameters MRIWI = params[:MRIWI] [description = "Minimum Relative Inventory Without Inflation"]
    @parameters OO = params[:OO] [description = "Optimal Output in 1980 Gu/y"]
    @parameters PH = params[:PH] [description = "Pulse Height"]
    @parameters PPU = params[:PPU] [description = "Price Per Unit /u"]
    @parameters SAT = params[:SAT] [description = "Sales Averaging Time y"]
    @parameters INVEODDI = params[:INVEODDI] [description = "sINVeoDDI < 0: INVentory Effect On Delivery Delay Index"]
    @parameters INVEOIN = params[:INVEOIN] [description = "sINVeoIN < 0: INVentory Effect On INflation"]
    @parameters INVEOSWI = params[:INVEOSWI] [description = "sINVeoSWI < 0: INVentory Effect On Shifts Worked Index"]
    @parameters SRI = params[:SRI] [description = "Sufficient Relative Inventory"]
    @parameters SWI = params[:SWI] [description = "SWI in 1980"]
    @parameters TAS = params[:TAS] [description = "Time to Adjust Shifts y"]

    @variables DELDI(t) = inits[:DELDI] [description = "DELiveries Delay - Index"]
    @variables EPP(t) = inits[:EPP] [description = "Effective Purchasing Power G/y"]
    @variables INV(t) = inits[:INV] [description = "INVentory Gu"]
    @variables PI(t) = inits[:PI] [description = "Price Index in 1980 (=1)"]
    @variables PRI(t) = inits[:PRI] [description = "Perceived Relative Inventory"]
    @variables RS(t) = inits[:RS] [description = "Recent Sales Gu/y"]
    @variables SSWI(t) = inits[:SSWI] [description = "ShiftS Worked - Index"]

    @variables CDDI(t) [description = "Change in DDI"]
    @variables CPI(t) [description = "Change in Price Index 1/y"]
    @variables DEL(t) [description = "DELiveries Gu/y"]
    @variables DSWI(t) [description = "Desired Shifts Worked - Index (1)"]
    @variables GDP(t) [description = "GDP G/y"]
    @variables IC(t) [description = "Inventory Coverage y"]
    @variables IR(t) [description = "Inflation Rate 1/y"]
    @variables NI(t) [description = "National Income G/y"]
    @variables OG(t) [description = "Output Gu/y"]
    @variables PNIS(t) [description = "Pink Noise In Sales"]
    @variables ROC(t) [description = "ROC in DDI 1/y"]
    @variables SA(t) [description = "SAles G/y"]

    @variables ORO(t)
    @variables TPP(t)

    eqs = []

    add_equation!(eqs, GDP ~ OG * PPU)
    add_equation!(eqs, D(DELDI) ~ CDDI)
    add_equation!(eqs, CDDI ~ ROC * DELDI)
    add_equation!(eqs, DSWI ~ 1 + INVEOSWI * (PRI / DRI - 1))
    add_equation!(eqs, IC ~ INV / RS)
    add_equation!(eqs, IR ~ INVEOIN * (PRI / MRIWI - 1))
    add_equation!(eqs, D(INV) ~ OG - DEL)
    add_equation!(eqs, NI ~ SA)
    add_equation!(eqs, PNIS ~ 1)
    add_equation!(eqs, OG ~ ORO * SSWI / SWI)
    add_equation!(eqs, D(PI) ~ CPI)
    add_equation!(eqs, CPI ~ PI * IR)
    add_equation!(eqs, ROC ~ 0 + INVEODDI * (PRI / SRI - 1))
    add_equation!(eqs, SA ~ DEL * PPU)
    add_equation!(eqs, DEL ~ ((EPP / PPU) / (DELDI / DDI)) * IfElse.ifelse(t > 1984, PNIS, 1))
    smooth!(eqs, PRI, (IC / DIC), ICPT)
    smooth!(eqs, EPP, TPP, DAT)
    smooth!(eqs, RS, DEL, SAT)
    smooth!(eqs, SSWI, DSWI, TAS)

    return ODESystem(eqs; name=name)
end

function inventory_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables ORO(t) [description = "Output.Optimal Real Output Gu/y"]
    @variables TPP(t) [description = "Demand.Total Purchasing Power G/y"]

    eqs = []

    add_equation!(eqs, ORO ~ WorldDynamics.interpolate(t, tables[:ORO], ranges[:ORO]))
    add_equation!(eqs, TPP ~ WorldDynamics.interpolate(t, tables[:TPP], ranges[:TPP]))

    return ODESystem(eqs; name=name)
end


