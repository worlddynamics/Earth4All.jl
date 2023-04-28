using ModelingToolkit
using DifferentialEquations


function demand_run_solution()
    isdefined(@__MODULE__, :_solution_demand_run) && return _solution_demand_run
    global _solution_demand_run = WorldDynamics.solve(demand_run(), (1980, 2100), dt=0.015625, dtmax=0.015625, solver =  Rodas5())
    return _solution_demand_run
end
function _variables_en()
    @named dem = demand()
    variables = [
        (dem.FGBW, 0, 0.5, ""),
      
    ]
    return variables
end

fig_dem(; kwargs...) = plotvariables(demand_run_solution(), (t, 1980, 2100), _variables_en(); title="Demand sector plots", showaxis=true, showlegend=true, kwargs...)
