using ModelingToolkit
using DifferentialEquations

function e4a_run_solution()
    isdefined(@__MODULE__, :_solution_e4a_run) && return _solution_e4a_run
    global _solution_e4a_run = WorldDynamics.solve(e4a_run(), (1980, 2100), dt=0.015625, dtmax=0.015625)
    return _solution_e4a_run
end

@variables t

fig_fin(; kwargs...) = plotvariables(e4a_run_solution(), (t, 2010, 2030), Finance._variables_fin(); title="Finance sector plots", showaxis=true, showlegend=true, kwargs...)

fig_pop(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), Population._variables_pop(); title="Population sector plots", showaxis=false, showlegend=true, kwargs...)

fig_pub(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), Public._variables_pub(); title="Public sector plots", showaxis=false, showlegend=true, kwargs...)

fig_wb(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), Wellbeing._variables_wb(); title="Wellbeing sector plots", showaxis=false, showlegend=true, kwargs...)
using ModelingToolkit
using DifferentialEquations

function e4a_run_solution()
    isdefined(@__MODULE__, :_solution_e4a_run) && return _solution_e4a_run
    global _solution_e4a_run = WorldDynamics.solve(e4a_run(), (1980, 2100), solver = Euler(), dt=0.015625, dtmax=0.015625)
    return _solution_e4a_run
end

@variables t

function _variables_test()
    @named inv = Inventory.inventory()
    @named pop = Population.population()
    @named wb = Wellbeing.wellbeing()
    @named cli  =  Climate.climate()
    @named fl = FoodLand.foodland()
    @named pub = Public.public()
    @named fin = Finance.finance()
    @named dem = Demand.demand()
    variables = [
        (pop.POP, 0, 10000, "Population Mp"),
        (wb.AWBI, 0, 2.4, "Awerage WellBeing Index" ),
        (pop.GDPP, 0 , 60, "GDP per person"),
        (inv.PRI, 0 , 1.5, "Perceived relative inventory"),
        (cli.ISCEGA, 0 , 20, "Ice and snow cover excl G&A Mkm"),
        (fl.CRUSP, 0, 1.2, "CRUSP"),
        (pub.PSP, 0, 10, "Public Spending per person"),
        (fin.CBSR, 0, 0.1, "Central bank signal rate"),
        (dem.GSGDP, 0, 1, "Government share of GDP"),
    ]
    return variables
end

fig_test(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_test(); title="Test plot", showaxis=true, showlegend=true, kwargs...)


function _variables_pop()
    @named pop = Population.population()
    variables = [
        (pop.DR, 0, 6, "Dependency ratio p/p"),
        (pop.LE, 0 , 100, "Life expectancy y"),
        (pop.OF, 0, 6, "Observed fertility" )
    ]
    return variables
end

fig_pop(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_pop(); title="Population and workforce", showaxis=true, showlegend=true, kwargs...)

function _variables_wb()
    @named wb = Wellbeing.wellbeing()
    variables = [
        (wb.AWBDI, 0, 8, "Average WellBeing from Disposable Income"),
        (wb.AWBPS, 0 , 8, "Average WellBeing from Public Spending"),
        (wb.AWBI, 0, 2.4, "Awerage WellBeing Index" ),
        (wb.AWBIN, 0, 1.2, "Average WellBeing from INequality" ),
        (wb.AWBGW, 0, 1.2, "Average WellBeing from Global Warming" ),
        (wb.AWBP, 0, 1.2, "Average WellBeing from Progress" ),
    ]
    return variables
end

fig_wb(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_wb(); title="Wellbeing - World 1980 to 2100", showaxis=true, showlegend=true, kwargs...)

function _variables_inv()
    @named inv = Inventory.inventory()
    variables = [
        (inv.PNIS, 0, 2, "Pink Noise in sale"),
        (inv.PRI, 0 , 1.5, "Perceived relative inventory"),
        (inv.DELDI, 0.9, 1.1, "Delivery delay"),
        (inv.IR, -0.1, 0.1, "Inflation rate"),
        (inv.PRIN, 0, 4, "PRIN"),
    ]
    return variables
end

fig_inv(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2040), _variables_inv(); title="Inventory", showaxis=true, showlegend=true, kwargs...)

function _variables_cli()
    @named cli  =  Climate.climate()

    variables = [
        (cli.OBWA, 0, 4,"Observed warming deg C"),
        (cli.CO2E, 0, 44, "CO2 emissions GtCO2/y"),
        (cli.CO2CA, 0, 600, "CO2 concentration in atm ppm"),
        (cli.MMF, 0, 8, "Man-made forcing W/m2"),
        (cli.ISCEGA, 0 , 20, "Ice and snow cover excl G&A Mkm"),
        (cli.WVF, 0, 8, "Water vapour feedback W/m2"),
    ]
    return variables
end

fig_cli(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_cli(); title="Climate sector", showaxis=true, showlegend=true, kwargs...)


function _variables_fl()
    @named fl = FoodLand.foodland()
    variables = [
        (fl.CRLA, 0, 4000, "CRLA"),
        (fl.CRUS, 0, 8000, "CRUS"),
        (fl.CRUSP, 0, 1.2, "CRUSP"),
        (fl.FEUS, 0, 200, "FEUS"),
        (fl.FRA, 0, 1, "FRA"),
        (fl.TFA, 0, 4000, "TFA"),
    ]
    return variables
end

fig_fl(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_fl(); title="Food and land", showaxis=true, showlegend=true, kwargs...)

function _variables_pub()
    @named pub = Public.public()
    variables = [
        (pub.DRTA, 0, 0.1, "DRTA"),
        (pub.GSSGDP, 0, 1, "GSSGDP"),
        (pub.PSP, 0, 10, "PSP"),
        (pub.TFPEE5TA, 0, 5, "TFPEE5TA"),
        (pub.XECTAGDP, -1, 1, "XECTAGDP"),
    ]
    return variables
end

fig_pub(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_pub(); title="Public sector plots", showaxis=true, showlegend=true, kwargs...)

function _variables_fin()
    @named fin = Finance.finance()
    variables = [
        (fin.CBC, 0, 0.1, "Corporate borrowing cost"),
        (fin.CBSR, 0, 0.1, "Central bank signal rate"),
        (fin.GBC, 0, 0.1, "Government borrowing cost"),
        (fin.WBC, 0, 0.1, "Worker borrowing cost"),
        (fin.IR, -0.05, 0.05, "Inflation rate"),
    ]
    return variables
end

fig_fin(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_fin(); title="Finance sector plots", showaxis=true, showlegend=true, kwargs...)

function _variables_dem()
    @named dem = Demand.demand()
    variables = [
        (dem.CSGDP, 0, 1, "Consumption share of GDP"),
        (dem.SSGDP, 0, 1, "Savings share of GDP"),
        (dem.GSGDP, 0, 1, "Government share of GDP"),
        (dem.NI, 0, 400000, "National income"),
        (dem.GDB, 0, 2, "Governament debt burden"),
        (dem.WDB, 0 ,2 , "Worker debt burden"),
      
    ]
    return variables
end

fig_dem(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_dem(); title="Demand", showaxis=true, showlegend=true, kwargs...)



function _variables_do()
    @named out = Output.output()
  
    variables = [
       (out.GIPC, 0, 16000, "FACNC"),
    ]
    return variables
end

fig_do(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_do(); title="Test plot", showaxis=true, showlegend=true, kwargs...)