using ModelingToolkit
using DifferentialEquations


function foodland_run_solution()
    isdefined(@__MODULE__, :_solution_foodland_run) && return _solution_foodland_run
    global _solution_foodland_run = WorldDynamics.solve(foodland_run(), (1980, 2100), solver=Euler(), dt=0.015625, dtmax=0.015625)
    return _solution_foodland_run
end

function _variables_foo()
    @named foo = foodland()
    variables = [
        (foo.CRLA, 0, 2000, "CRLA"),
        (foo.CRUS, 0, 8000, "CRUS"),
        (foo.CRUSP, 0, 1.2, "CRUSP"),
        (foo.FEUS, 0, 200, "FEUS"),
        (foo.FRA, 0, 1, "FRA"),
        (foo.TFA, 0, 4000, "TFA"),
    ]
    return variables
end

fig_fl(; kwargs...) = plotvariables(foodland_run_solution(), (t, 1980, 2100), _variables_foo(); title="Food and land sector plots", showaxis=true, showlegend=true, kwargs...)
