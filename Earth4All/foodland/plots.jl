using ModelingToolkit
using DifferentialEquations


function foodland_run_solution()
    isdefined(@__MODULE__, :_solution_foodland_run) && return _solution_foodland_run
    global _solution_foodland_run = WorldDynamics.solve(foodland_run(), (1980, 2100), dt=0.015625, dtmax=0.015625)
    return _solution_foodland_run
end

function _variables_fl()
    @named fl = foodland()
    variables = [
        (fl.CRLA, 0, 2000, "CRLA"),
        (fl.CRUS, 0, 8000, "CRUS"),
        (fl.CRUSP, 0, 1.2, "CRUSP"),
        (fl.FEUS, 0, 200, "FEUS"),
        (fl.FRA, 0, 1, "FRA"),
        (fl.TFA, 0, 4000, "TFA"),
    ]
    return variables
end

fig_fl(; kwargs...) = plotvariables(foodland_run_solution(), (t, 1980, 2100), _variables_fl(); title="Food and land sector plots", showaxis=true, showlegend=true, kwargs...)
