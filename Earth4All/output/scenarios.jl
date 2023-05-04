function output_run(; kwargs...)
    @named out = output(; kwargs...)
    @named out_sup = output_support(; kwargs...)

    systems = [
        out, out_sup,
    ]

    connection_eqs = [
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
