using ModelingToolkit
using DifferentialEquations

function out_run_solution()
    isdefined(@__MODULE__, :_solution_out_run) && return _solution_out_run
    global _solution_out_run = WorldDynamics.solve(output_run(), (1980, 2100), solver=Euler(), dt=0.015625, dtmax=0.015625)
    return _solution_out_run
end

function _variables_out()
    @named out = output()

    variables = [
        (out.CUCPIS, 0, 100000, "CUCPIS"),
        (out.CUCPUS, 0, 30000, "CUCPUS"),
        (out.OGR, -0.1, 0.1, "OGR"),
        (out.OLY, 0, 350000, "OLY"),
        (out.ORO, 0, 350000, "ORO"),
    ]

    return variables
end

fig_out(; kwargs...) = plotvariables(out_run_solution(), (t, 1980, 2100), _variables_out(); title="Output sector plots", showaxis=false, showlegend=true, kwargs...)
