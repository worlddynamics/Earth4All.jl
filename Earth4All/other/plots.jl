using ModelingToolkit
using DifferentialEquations

function oth_run_solution()
    isdefined(@__MODULE__, :_solution_oth_run) && return _solution_oth_run
    global _solution_oth_run = WorldDynamics.solve(other_run(), (1980, 2100), dt=0.015625, dtmax=0.015625)
    return _solution_oth_run
end
function _variables_oth()
    @named oth1  =  other1()
    @named oth2  =  other2()
    @named oth3  =  other3()
    variables = [
        (oth1.RGGDPP, 0, 0.04, "Rate of growth of GDP per person"),
        (oth2.CTA, 0, 20000, "Cost of TAs"),
        (oth3.PB15, 0, 10000, "Population below 15"),
    ]
    return variables
end

fig_oth(; kwargs...) = plotvariables(oth_run_solution(), (t, 1980, 2100), _variables_oth(); title="Other sector plots", showaxis=false, showlegend=true, kwargs...)
