function e4a_run(; kwargs...)
    # @named cli = Climate.climate(; kwargs...)
    @named dem = Demand.demand(; kwargs...)
    @named dem_sup = Demand.demand_partial_support(; kwargs...)
    # @named ene = Energy.energy(; kwargs...)
    # @named fin = Finance.finance(; kwargs...)
    # @named foo = FoodLand.foodland(; kwargs...)
    @named inv = Inventory.inventory(; kwargs...)
    # @named inv_sup = Inventory.inventory_partial_support(; kwargs...)
    @named lab = LabourMarket.labour_market(; kwargs...)
    # @named lab_sup = LabourMarket.labour_market_partial_support(; kwargs...)
    # @named oth = Other.other(; kwargs...)
    @named out = Output.output(; kwargs...)
    @named out_sup = Output.output_partial_support(; kwargs...)
    @named pop = Population.population(; kwargs...)
    @named pop_sup = Population.population_partial_support(; kwargs...)
    @named pub = Public.public(; kwargs...)
    @named pub_sup = Public.public_partial_support(; kwargs...)
    @named wel = Wellbeing.wellbeing(; kwargs...)
    @named wel_sup = Wellbeing.wellbeing_partial_support(; kwargs...)

    systems = [
        dem, dem_sup, inv, lab, out, out_sup, pop, pop_sup, pub, pub_sup, wel, wel_sup,
    ]

    connection_eqs = variable_connections(systems)

    return WorldDynamics.compose(systems, connection_eqs)
end
