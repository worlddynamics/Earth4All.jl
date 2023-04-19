function wb_run(; kwargs...)
    @named wb = wellbeing(; kwargs...)
    @named wb_sup = wellbeing_support(; kwargs...)

    systems = [
        wb, wb_sup,
    ]

    connection_eqs = [
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
