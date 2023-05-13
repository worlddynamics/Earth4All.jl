using ModelingToolkit
using DifferentialEquations

function pub_run_solution()
    isdefined(@__MODULE__, :_solution_pub_run) && return _solution_pub_run
    global _solution_pub_run = WorldDynamics.solve(public_run(), (1980, 2100), solver=Euler(), dt=0.015625, dtmax=0.015625)
    return _solution_pub_run
end

function _variables_pub()
    @named pub = public()
    variables = [
        (pub.DRTA, 0, 0.1, "DRTA"),
        (pub.GSSGDP, 0, 1, "GSSGDP"),
        (pub.PSP, 0, 10, "PSP"),
        (pub.TFPEE5TA, 0, 5, "TFPEE5TA"),
        (pub.XECTAGDP, -1, 1, "XECTAGDP"),
    ]
    return variables
end

fig_pub(; kwargs...) = plotvariables(pub_run_solution(), (t, 1980, 2100), _variables_pub(); title="Public sector plots", showaxis=false, showlegend=true, kwargs...)
