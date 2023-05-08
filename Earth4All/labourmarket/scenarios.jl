function lab_run(; kwargs...)
    @named lab = labour_market(; kwargs...)
    @named lab_sup = labour_market_support(; kwargs...)

    systems = [
        lab, lab_sup
    ]

    connection_eqs = [
        lab.A20PA ~ lab_sup.A20PA
        lab.CAPA ~ lab_sup.CAPA
        lab.GDPP ~ lab_sup.GDPP
        lab.IR ~ lab_sup.IR
        lab.IPP ~ lab_sup.IPP
        lab.OUTP ~ lab_sup.OUTP
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
