include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function inventory(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
	@parameters DAT = params[:DAT] [description = "Demand adjustment time y"]
	@parameters DDI = params[:DDI] [description = "DDI in 1980 y"]
	@parameters DIC = params[:DIC] [description = "Desired inventory coverage y"]
	@parameters DP = params[:DP] [description = "Demand pulse 2020-5 (1)"]
	@parameters DRI = params[:DRI] [description = "Desired relative inventory (1)"]
	@parameters ICPT = params[:ICPT] [description = "Inventory coverage perception time y"]
	@parameters MRIWI = params[:MRIWI] [description = "Minimum relative inventory without inflation (1)"]
	@parameters NOR1 = params[:NOR1] [description = "Normal (1)"]
	@parameters OO = params[:OO] [description = "Optimal output in 1980 Gu/y"]
	@parameters PH = params[:PH] [description = "Pulse height (1)"]
	@parameters PNIS = params[:PNIS]    [description = "Pink noise in sales"]
	@parameters PPU = params[:PPU] [description = "Price per unit /u"]
	@parameters SAT = params[:SAT] [description = "Sales averaging time y"]
	@parameters SINVEODDI = params[:SINVEODDI] [description = "sINVeoDDI < 0"]
	@parameters SINVEOIN = params[:SINVEOIN] [description = "sINVeoIN < 0"]
	@parameters SINVEOSWI = params[:SINVEOSWI] [description = "sINVeoSWI < 0"]
	@parameters SRI = params[:SRI] [description = "Sufficient relative inventory (1)"]
	@parameters SWI = params[:SWI] [description = "SWI in 1980 (1)"]
	@parameters ST = params[:ST] [description = "Sampling time y"]
	@parameters STDIFAN  = params[:STDIFAN] [description = "STD in fluctuation around normal (1)"] 
	@parameters TAS = params[:TAS] [description = "Time to adjust shifts y"]
	    
	@variables DelDI(t)= inits[:DelDI]    [description = "Deliveries delay - index (1)"]
	@variables EPP(t) = inits[:EPP] [description = "Effective purchasing power G/y"]
	@variables INV(t) = inits[:INV] [description = "Inventory Gu"]
	@variables PI(t) = inits[:PI] [description = "Price index in 1980 (=1)"]
	@variables PRI(t) = inits[:PRI] [description = "Perceived relative inventory (1)"]
	@variables RS(t) = inits[:RS] [description = "Recent sales Gu/y"]
	@variables SsWI(t) = inits[:SsWI] [description = "Shifts worked - index (1)"]


	@variables CDDI(t) [description = "Change in DDI"]
	@variables CPI(t) [description = "Change in price index 1/y"]
	@variables DEL(t) [description = "Deliveries Gu/y"]
	@variables DSWI(t) [description = "Desired shifts worked - index (1)"]
	@variables GDP(t) [description = "GDP G/y"]
	@variables IC(t) [description = "Inventory Coverage y"]
	@variables IR(t) [description = "Inflation rate 1/y"]
	@variables NI(t) [description = "National income G/y"]
	@variables OG(t) [description = "Output Gu/y"]
	@variables ROC(t) [description = "ROC in DDI 1/y"]
	@variables Sa(t) [description = "Sales G/y"]
	

	@variables ORO(t)
	@variables TPP(t)
	

	eqs = []

	
	add_equation!(eqs, GDP ~ OG * PPU)
	add_equation!(eqs, D(DelDI) ~ CDDI)
	add_equation!(eqs, CDDI ~ ROC * DelDI)
	add_equation!(eqs, DSWI ~ 1 + SINVEOSWI * (PRI / DRI - 1))
	add_equation!(eqs, IC ~ INV / RS)
	add_equation!(eqs, IR ~ SINVEOIN * (PRI / MRIWI - 1))
	add_equation!(eqs, D(INV) ~ OG - DEL)
	add_equation!(eqs, NI ~ Sa)
	add_equation!(eqs, OG ~ ORO * SsWI / SWI)
	add_equation!(eqs, D(PI) ~ CPI)
	add_equation!(eqs, CPI ~ PI * IR)
	add_equation!(eqs, ROC ~ 0 + SINVEODDI * (PRI / SRI - 1))
	add_equation!(eqs, Sa ~ DEL * PPU)
	add_equation!(eqs, DEL ~ ((EPP / PPU) / (DelDI /DDI)) * IfElse.ifelse(t > 1984, PNIS, 1))
	
	smooth!(eqs, PRI, (IC / DIC), ICPT)
	smooth!(eqs, EPP, TPP, DAT)
	smooth!(eqs, RS, DEL, SAT)
	smooth!(eqs, SsWI, DSWI, TAS)


	return ODESystem(eqs; name=name)
end

function inventory_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)

	@variables ORO(t) [description = "Optimal real output Gu/y"]
	@variables TPP(t) [description = "Total purchasing power G/y"]

    eqs = []

    add_equation!(eqs, ORO ~ WorldDynamics.interpolate(t, tables[:ORO], ranges[:ORO]))
    add_equation!(eqs, TPP ~ WorldDynamics.interpolate(t, tables[:TPP], ranges[:TPP]))

    return ODESystem(eqs; name=name)
end


