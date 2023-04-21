function energy_run(; kwargs...)
    @named en = energy(; kwargs...)
    @named en_sup = energy_support(; kwargs...)


    systems = [
        en,en_sup
    ]

    connection_eqs = [
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
