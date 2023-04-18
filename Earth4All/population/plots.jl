using ModelingToolkit
using DifferentialEquations

function pop_run_solution()
    isdefined(@__MODULE__, :_solution_pop_run) && return _solution_pop_run
    global _solution_pop_run = WorldDynamics.solve(pop_run(), (1980, 2100), dt=0.015625, dtmax=0.015625)
    return _solution_pop_run
end
function _variables_pop()
    @named pop = population()
    variables = [
        (pop.EFR, 0, 0.5, "Extra fertility reduction"),
        (pop.IPP, 20, 31, "Introduction period for policy"),
    ]
    return variables
end

fig_pop(; kwargs...) = plotvariables(pop_run_solution(), (t, 1980, 2100), _variables_pop(); title="Population sector plots", showaxis=false, showlegend=true, kwargs...)
