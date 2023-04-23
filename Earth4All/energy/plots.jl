using ModelingToolkit
using DifferentialEquations


function energy_run_solution()
    isdefined(@__MODULE__, :_solution_energy_run) && return _solution_energy_run
    global _solution_energy_run = WorldDynamics.solve(energy_run(), (1980, 2100), dt=0.015625, dtmax=0.015625)
    return _solution_energy_run
end
function _variables_en()
    @named en = energy()
    variables = [
        (en.CE, 0, 7000, ""),
      
    ]
    return variables
end

fig_en(; kwargs...) = plotvariables(energy_run_solution(), (t, 1980, 2100), _variables_en(); title="Energy sector plots", showaxis=true, showlegend=true, kwargs...)
