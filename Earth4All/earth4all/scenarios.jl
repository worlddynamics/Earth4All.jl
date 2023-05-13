function e4a_run(; kwargs...)
    @named cli = Climate.climate(; kwargs...)
    # @named dem = Demand.demand(; kwargs...)
    # @named ene = Energy.energy(; kwargs...)
    # @named fin = Finance.finance(; kwargs...)
    # @named fl = FoodLand.foodland(; kwargs...)
    # @named inv = Inventory.inventory(; kwargs...)
    # @named lm = LabourMarket.labour_market(; kwargs...)
    # @named oth = Other.other(; kwargs...)
    # @named out = Output.output(; kwargs...)
    @named pop = Population.population(; kwargs...)
    # @named pub = Public.public(; kwargs...)
    # @named wb = Wellbeing.wellbeing(; kwargs...)


    @named cli_sup = Climate.climate_support(; kwargs...)
    @named pop_sup = Population.population_support(; kwargs...)


    systems = [
        cli, cli_sup, pop, pop_sup,
    ]

    connection_eqs = variable_connections(systems)

    return WorldDynamics.compose(systems, connection_eqs)
end
