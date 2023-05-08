using ModelingToolkit
using DifferentialEquations

function e4a_run_solution()
    isdefined(@__MODULE__, :_solution_e4a_run) && return _solution_e4a_run
    global _solution_e4a_run = WorldDynamics.solve(e4a_run(), (1980, 2100), dt=0.015625, dtmax=0.015625)
    return _solution_e4a_run
end

@variables t

function _variables_pop()
    @named pop = Population.population()
    variables = [
        (pop.POP, 3000, 11000, "Population Mp"),
    ]
    return variables
end

fig_pop(; kwargs...) = plotvariables(e4a_run_solution(), (t, 1980, 2100), _variables_pop(); title="Population plot", showaxis=false, showlegend=true, kwargs...)
