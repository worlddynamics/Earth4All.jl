function climate_run(; kwargs...)
    @named cli = climate(; kwargs...)
    @named cli_sup = climate_support(; kwargs...)


    systems = [
        cli, cli_sup,
    ]

    connection_eqs = [
        cli.GDP ~ cli_sup.GDP
        cli.IPP ~ cli_sup.IPP
        cli.FEUS ~ cli_sup.FEUS
        cli.CRSU ~ cli_sup.CRSU
        cli.CO2EI ~ cli_sup.CO2EI
        cli.CCCSt ~ cli_sup.CCCSt
        cli.CO2ELULUC ~ cli_sup.CO2ELULUC]

    return WorldDynamics.compose(systems, connection_eqs)
end
