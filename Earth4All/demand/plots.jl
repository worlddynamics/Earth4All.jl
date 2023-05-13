using ModelingToolkit
using DifferentialEquations

function dem_run_solution()
    isdefined(@__MODULE__, :_solution_demand_run) && return _solution_demand_run
    @named dem = demand()
    global _solution_demand_run = WorldDynamics.solve(dem, (1980, 2100), solver=Euler(), dt=0.015625, dtmax=0.015625)
    return _solution_demand_run
end
