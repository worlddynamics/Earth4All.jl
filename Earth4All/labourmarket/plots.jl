using ModelingToolkit
using DifferentialEquations

function lab_run_solution()
    isdefined(@__MODULE__, :_solution_lab_run) && return _solution_lab_run
    global _solution_lab_run = WorldDynamics.solve(lab_run(), (1980, 2100), dt=0.015625, dtmax=0.015625)
    return _solution_lab_run
end

function _variables_lab()
    @named lab = labour_market()
    variables = [
        (lab.WF, 0, 6000, "Workforce"),
        (lab.WSO, 0, 1, "Worker share of output"),
        (lab.UNRA, 0, 0.1, "Unemployment rate"),
    ]
    return variables
end

fig_lab(; kwargs...) = plotvariables(lab_run_solution(), (t, 1980, 2100), _variables_lab(); title="Labour Market sector plots", showaxis=false, showlegend=true, kwargs...)
