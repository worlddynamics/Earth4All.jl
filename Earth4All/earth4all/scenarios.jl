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
        cli, dem, ene, fin, foo, inv, lab, oth, out, pop, pub, wel,
    ]

    connection_eqs = variable_connections(systems)
    println.(connection_eqs)

    return WorldDynamics.compose(systems, connection_eqs)
end
