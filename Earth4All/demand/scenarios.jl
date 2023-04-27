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
        dem.GDP ~ dem_sup.GDP 
        dem.CAC ~ dem_sup.CAC  
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
