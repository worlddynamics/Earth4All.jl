function demand_run(; kwargs...)
    @named dem = demand(; kwargs...)
    @named dem_sup = demand_support(; kwargs...)


    systems = [
        dem, dem_sup
    ]

    connection_eqs = [
        dem.GDPP ~ dem_sup.GDPP
        dem.POP ~ dem_sup.POP
        dem.IPP ~ dem_sup.IPP
        dem.WSO ~ dem_sup.WSO
        dem.NI ~ dem_sup.NI
        dem.ECTAF2022 ~ dem_sup.ECTAF2022
        dem.GBC ~ dem_sup.GBC
        dem.WBC ~ dem_sup.WBC
        dem.WF ~ dem_sup.WF
        dem.EGDPP ~ dem_sup.EGDPP
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
