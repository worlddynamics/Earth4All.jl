using ModelingToolkit
using DifferentialEquations

function cli_run_solution()
    isdefined(@__MODULE__, :_solution_cli_run) && return _solution_cli_run
    global _solution_cli_run = WorldDynamics.solve(climate_run(), (1980, 2100), solver=Euler(), dt=0.015625, dtmax=0.015625)
    return _solution_cli_run
end

function _variables_cli()
    @named cli = climate()

    variables = [
        (cli.OW, 0, 4, "Observed warming deg C"),
        (cli.CO2E, 0, 44, "CO2 emissions GtCO2/y"),
        (cli.CO2CA, 0, 600, "CO2 concentration in atm ppm"),
        (cli.MMF, 0, 8, "Man-made forcing W/m2"),
        (cli.ISCEGA, 0, 20, "Ice and snow cover excl G&A Mkm"),
        (cli.WVF, 0, 8, "Water vapour feedback W/m2"),
    ]
    return variables
end

fig_cli(; kwargs...) = plotvariables(cli_run_solution(), (t, 1980, 2100), _variables_cli(); title="Climate sector plots", showaxis=true, showlegend=true, kwargs...)
