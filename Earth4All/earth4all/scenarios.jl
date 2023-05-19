function e4a_run(; kwargs...)
    # @named cli = Climate.climate(; kwargs...)
    @named dem = Demand.demand(; kwargs...)
    @named dem_sup = Demand.demand_support(; kwargs...)
    # @named ene = Energy.energy(; kwargs...)
    # @named fin = Finance.finance(; kwargs...)
    # @named foo = FoodLand.foodland(; kwargs...)
    @named inv = Inventory.inventory(; kwargs...)
    # @named lab = LabourMarket.labour_market(; kwargs...)
    # @named oth = Other.other(; kwargs...)
    @named out = Output.output(; kwargs...)
    @named out_sup = Output.output_support(; kwargs...)
    # @named pop = Population.population(; kwargs...)
    # @named pub = Public.public(; kwargs...)
    @named wel = Wellbeing.wellbeing(; kwargs...)
    @named wel_sup = Wellbeing.wellbeing_support(; kwargs...)

    systems = [
        dem, dem_sup, inv, out, out_sup, wel, wel_sup,
    ]

    connection_eqs = variable_connections(systems)

    return WorldDynamics.compose(systems, connection_eqs)
end
