function e4a_run(; kwargs...)
    @named cli = Climate.climate(; kwargs...)
    @named dem = Demand.demand(; kwargs...)
    @named ene = Energy.energy(; kwargs...)
    @named fin = Finance.finance(; kwargs...)
    @named foo = FoodLand.foodland(; kwargs...)
    @named inv = Inventory.inventory(; kwargs...)
    @named lab = LabourMarket.labour_market(; kwargs...)
    @named oth = Other.other(; kwargs...)
    @named out = Output.output(; kwargs...)
    @named pop = Population.population(; kwargs...)
    @named pub = Public.public(; kwargs...)
    @named wel = Wellbeing.wellbeing(; kwargs...)

    systems = [
        dem, cli, ene, fin, foo, inv, lab, oth, out, pop, pub, wel,
    ]

    connection_eqs = variable_connections(systems)

    return WorldDynamics.compose(systems, connection_eqs)
end

function e4a_run_gl(;
    cli_ps=Climate._params,
    dem_ps=Demand._params,
    ene_ps=Energy._params,
    foo_ps=FoodLand._params,
    out_ps=Output._params,
    pop_ps=Population._params,
    pub_ps=Public._params,
    kwargs...
)
    cli_ps[:ERDN2OKF2022] = 0.01
    cli_ps[:ERDCH4KC2022] = 0.01
    cli_ps[:DACCO22100] = 8
    @named cli = Climate.climate(; params=cli_ps, kwargs...)

    dem_ps[:EETF2022] = 0.02
    dem_ps[:EGTRF2022] = 0.01
    dem_ps[:EPTF2022] = 0.02
    dem_ps[:ETGBW] = 0.2
    dem_ps[:FETPO] = 0.8
    dem_ps[:FGDC2022] = 0.1
    dem_ps[:GEIC] = 0.02
    @named dem = Demand.demand(; params=dem_ps, kwargs...)

    ene_ps[:GFCO2SCCS] = 0.9
    ene_ps[:EROCEPA2022] = 0.004
    ene_ps[:GFNE] = 1
    ene_ps[:GREF] = 1
    @named ene = Energy.energy(; params=ene_ps, kwargs...)

    @named fin = Finance.finance(; kwargs...)

    foo_ps[:GCWR] = 0.2
    foo_ps[:GFNRM] = 0.5
    foo_ps[:GFRA] = 0.5
    @named foo = FoodLand.foodland(; params=foo_ps, kwargs...)

    @named inv = Inventory.inventory(; kwargs...)

    @named lab = LabourMarket.labour_market(; kwargs...)

    @named oth = Other.other(; kwargs...)

    out_ps[:USPIS2022] = 0.01
    out_ps[:USPUS2022] = 0.01
    @named out = Output.output(; params=out_ps, kwargs...)

    pop_ps[:GEFR] = 0.2
    @named pop = Population.population(; params=pop_ps, kwargs...)

    pub_ps[:MIROTA2022] = 0.005
    @named pub = Public.public(; params=pub_ps, kwargs...)

    @named wel = Wellbeing.wellbeing(; kwargs...)

    systems = [
        dem, cli, ene, fin, foo, inv, lab, oth, out, pop, pub, wel,
    ]

    connection_eqs = variable_connections(systems)

    return WorldDynamics.compose(systems, connection_eqs)
end
