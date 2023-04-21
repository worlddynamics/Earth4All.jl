function other_run(; kwargs...)
    @named oth1 = other1(; kwargs...)
    @named oth1_sup = other1_support(; kwargs...)
    @named oth2 = other2(; kwargs...)
    @named oth2_sup = other2_support(; kwargs...)
    @named oth3 = other3(; kwargs...)
    @named oth3_sup = other3_support(; kwargs...)

    systems = [
        oth1, oth1_sup, oth2, oth2_sup, oth3, oth3_sup,
    ]

    connection_eqs = [
        oth1.GDPP ~ oth1_sup.GDPP,
        oth2.CF ~ oth2_sup.CF,
        oth2.CE ~ oth2_sup.CE,
        oth3.INEQ ~ oth3_sup.INEQ,
        oth3.GDPP ~ oth3_sup.GDPP,
        oth3.POP ~ oth3_sup.POP,
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
