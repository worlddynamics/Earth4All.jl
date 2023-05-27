function other_run(; kwargs...)
    @named oth = other(; kwargs...)
    @named oth_sup = other_full_support(; kwargs...)

    systems = [
        oth, oth_sup,
    ]

    connection_eqs = [
        oth.CE ~ oth_sup.CE,
        oth.COFO ~ oth_sup.COFO,
        oth.GDPP ~ oth_sup.GDPP,
        oth.INEQ ~ oth_sup.INEQ,
        oth.POP ~ oth_sup.POP,
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
