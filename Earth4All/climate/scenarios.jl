function climate_run(; kwargs...)
    @named cli = climate(; kwargs...)
    @named cli_sup = climate_support(; kwargs...)


    systems = [
        cli, cli_sup, 
    ]

    connection_eqs = [

    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
