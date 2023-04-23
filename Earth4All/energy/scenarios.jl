function energy_run(; kwargs...)
    @named en = energy(; kwargs...)
    @named en_sup = energy_support(; kwargs...)


    systems = [
        en, en_sup
    ]

    connection_eqs = [
        en.GDPP ~ en_sup.GDPP
        en.POP ~ en_sup.POP 
        en.IPP ~ en_sup.IPP  
        en.GDP ~ en_sup.GDP 
        en.CAC ~ en_sup.CAC  
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
