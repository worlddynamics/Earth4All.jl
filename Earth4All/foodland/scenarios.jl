function foodland_run(; kwargs...)
    @named foo = foodland(; kwargs...)
    @named foo_sup = foodland_support(; kwargs...)


    systems = [
        foo, foo_sup
    ]

    connection_eqs = [
        foo.CO2CA ~ foo_sup.CO2CA
        foo.GDP ~ foo_sup.GDP
        foo.GDPP ~ foo_sup.GDPP
        foo.IPP ~ foo_sup.IPP
        foo.OW ~ foo_sup.OW
        foo.POP ~ foo_sup.POP
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
