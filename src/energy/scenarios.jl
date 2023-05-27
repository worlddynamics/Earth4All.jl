function energy_run(; kwargs...)
    @named ene = energy(; kwargs...)
    @named ene_sup = energy_full_support(; kwargs...)


    systems = [
        ene, ene_sup
    ]

    connection_eqs = [
        ene.GDPP ~ ene_sup.GDPP
        ene.POP ~ ene_sup.POP
        ene.IPP ~ ene_sup.IPP
        ene.GDP ~ ene_sup.GDP
        ene.CAC ~ ene_sup.CAC
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
