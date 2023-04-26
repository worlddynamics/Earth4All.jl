function inv_run(; kwargs...)
    @named inv = inventory(; kwargs...)
    @named inv_sup = inventory_support(; kwargs...)

    systems = [
        inv, inv_sup
    ]

    connection_eqs = [
        inv.ORO ~ inv_sup.ORO
        inv.TPP ~ inv_sup.TPP
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end