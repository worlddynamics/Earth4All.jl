function run_tltl(; kwargs...)
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

function run_gl(;
    cli_ps=Climate.getparameters(),
    dem_ps=Demand.getparameters(),
    ene_ps=Energy.getparameters(),
    foo_ps=FoodLand.getparameters(),
    out_ps=Output.getparameters(),
    pop_ps=Population.getparameters(),
    pub_ps=Public.getparameters(),
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

function run_pars_inits(;
    cli_pars=Climate.getparameters(),
    dem_pars=Demand.getparameters(),
    ene_pars=Energy.getparameters(),
    fin_pars=Finance.getparameters(),
    foo_pars=FoodLand.getparameters(),
    inv_pars=Inventory.getparameters(),
    lab_pars=LabourMarket.getparameters(),
    oth_pars=Other.getparameters(),
    out_pars=Output.getparameters(),
    pop_pars=Population.getparameters(),
    pub_pars=Public.getparameters(),
    wel_pars=Wellbeing.getparameters(),
    cli_inits=Climate.getinitialisations(),
    dem_inits=Demand.getinitialisations(),
    ene_inits=Energy.getinitialisations(),
    fin_inits=Finance.getinitialisations(),
    foo_inits=FoodLand.getinitialisations(),
    inv_inits=Inventory.getinitialisations(),
    lab_inits=LabourMarket.getinitialisations(),
    oth_inits=Other.getinitialisations(),
    out_inits=Output.getinitialisations(),
    pop_inits=Population.getinitialisations(),
    pub_inits=Public.getinitialisations(),
    wel_inits=Wellbeing.getinitialisations(),
    kwargs...
)
    @named cli = Climate.climate(; params=cli_pars, inits=cli_inits, kwargs...)
    @named dem = Demand.demand(; params=dem_pars, inits=dem_inits, kwargs...)
    @named ene = Energy.energy(; params=ene_pars, inits=ene_inits, kwargs...)
    @named fin = Finance.finance(; params=fin_pars, inits=fin_inits, kwargs...)
    @named foo = FoodLand.foodland(; params=foo_pars, inits=foo_inits, kwargs...)
    @named inv = Inventory.inventory(; params=inv_pars, inits=inv_inits, kwargs...)
    @named lab = LabourMarket.labour_market(; params=lab_pars, inits=lab_inits, kwargs...)
    @named oth = Other.other(; params=oth_pars, inits=oth_inits, kwargs...)
    @named out = Output.output(; params=out_pars, inits=out_inits, kwargs...)
    @named pop = Population.population(; params=pop_pars, inits=pop_inits, kwargs...)
    @named pub = Public.public(; params=pub_pars, inits=pub_inits, kwargs...)
    @named wel = Wellbeing.wellbeing(; params=wel_pars, inits=wel_inits, kwargs...)

    systems = [
        dem, cli, ene, fin, foo, inv, lab, oth, out, pop, pub, wel,
    ]

    connection_eqs = variable_connections(systems)

    return WorldDynamics.compose(systems, connection_eqs)
end
