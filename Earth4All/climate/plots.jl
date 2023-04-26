using ModelingToolkit
using DifferentialEquations

function climate_run_solution()
    isdefined(@__MODULE__, :_solution_cli_run) && return _solution_cli_run
    global _solution_cli_run = WorldDynamics.solve(climate_run(), (1980, 2100), dt=0.015625, dtmax=0.015625)
    return _solution_cli_run
end
function _variables_cli()
    @named cli  =  climate()

    variables = [
        (oth1.RGGDPP, 0, 0.04, "Rate of growth of GDP per person"),
   
    ]
    return variables
end

fig_cli(; kwargs...) = plotvariables(climate_run_solution(), (t, 1980, 2100), _variables_cli(); title="Climate sector plots", showaxis=false, showlegend=true, kwargs...)
