function demand_run(; kwargs...)
    @named dem = demand(; kwargs...)
    @named dem_sup = demand_full_support(; kwargs...)


    systems = [
        dem, dem_sup
    ]

    connection_eqs = [
        dem.ECTAF2022 ~ dem_sup.ECTAF2022
        dem.EGDPP ~ dem_sup.EGDPP
        dem.GBC ~ dem_sup.GBC
        dem.IPP ~ dem_sup.IPP
        dem.NI ~ dem_sup.NI
        dem.POP ~ dem_sup.POP
        dem.WBC ~ dem_sup.WBC
        dem.WF ~ dem_sup.WF
        dem.WSO ~ dem_sup.WSO
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
