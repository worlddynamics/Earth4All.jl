function foodland_run(; kwargs...)
    @named fl = foodland(; kwargs...)
    @named fl_sup = foodland_support(; kwargs...)


    systems = [
        fl, fl_sup
    ]

    connection_eqs = [
        fl.CO2CA ~ fl_sup.CO2CA
        fl.GDP ~ fl_sup.GDP
        fl.GDPP ~ fl_sup.GDPP
        fl.IPP ~ fl_sup.IPP
        fl.OBWA ~ fl_sup.OBWA
        fl.POP ~ fl_sup.POP
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
