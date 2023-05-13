using ModelingToolkit
using DifferentialEquations

function dem_run_solution()
    isdefined(@__MODULE__, :_solution_demand_run) && return _solution_demand_run
    global _solution_demand_run = WorldDynamics.solve(demand_run(), (1980, 2100), solver=Euler(), dt=0.015625, dtmax=0.015625)
    return _solution_demand_run
end

function _variables_dem()
    @named dem = demand()
    variables = [
        (dem.CSGDP, 0, 1, "Consumption share of GDP"),
        (dem.SSGDP, 0, 1, "Savings share of GDP"),
        (dem.GSGDP, 0, 1, "Government share of GDP"),
        (dem.NI, 0, 400000, "National income"),
        (dem.GDB, 0, 2, "Governament debt burden"),
        (dem.WDB, 0, 2, "Worker debt burden"),]
    return variables
end

fig_dem(; kwargs...) = plotvariables(dem_run_solution(), (t, 1980, 2100), _variables_dem(); title="Demand sector plots", showaxis=true, showlegend=true, kwargs...)
