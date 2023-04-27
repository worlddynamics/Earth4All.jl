using ModelingToolkit
using DifferentialEquations

function inv_run_solution()
    isdefined(@__MODULE__, :_solution_inv_run) && return _solution_inv_run
    global _solution_inv_run = WorldDynamics.solve(inv_run(), (1980, 2100), dt=0.015625, dtmax=0.015625)
    return _solution_inv_run
end
function _variables_inv()
    @named inv = inventory()
    variables = [
        (inv.PNIS, 0, 2, "PNIS"),
        (inv.PRI, 0, 1.5, "PRI" ),
        (inv.DelDI, 0.9, 1.1, "Delivery Delay Index" ),
        (inv.IR, -0.1, 0.1, "IR"),
        (inv.PI, 0,4, "PI")


        
    ]
    return variables
end

fig_inv(; kwargs...) = plotvariables(inv_run_solution(), (t, 1980, 2040), _variables_inv(); title="Inventory sector plots", showaxis=true, showlegend=true, kwargs...)

