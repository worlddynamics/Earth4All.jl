using ModelingToolkit
using DifferentialEquations

function oth_run_solution()
    isdefined(@__MODULE__, :_solution_oth_run) && return _solution_oth_run
    global _solution_oth_run = WorldDynamics.solve(other_run(), (1980, 2100), solver=Euler(), dt=0.015625, dtmax=0.015625)
    return _solution_oth_run
end

function _variables_oth()
    @named oth = other()

    variables = [
        (oth.CTA, 0, 20000, "CTA"),
        (oth.PB15, 0, 10000, "PB15"),
        (oth.RGGDPP, 0, 0.04, "RGGDPP"),
    ]

    return variables
end

fig_oth(; kwargs...) = plotvariables(oth_run_solution(), (t, 1980, 2100), _variables_oth(); title="Other sector plots", showaxis=false, showlegend=true, kwargs...)
