include("../functions.jl")


@variables t
D = Differential(t)

function demand(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)

    @variables TIME(t) = 1980 [description = "Time instants"]
    @variables GIPC(t) [description = "Govmnt Investment in Public Capacity Gdollar/y"]
    @variables GP(t) [description = "Govmnt purchases Gdollar/y"]
    @variables GS(t) [description = "Govmnt spending Gdollar/y"]
    @variables II(t) [description = "Inequality index (1980=1)"]
    @variables INEQ(t) [description = "Inequality (1)"]
    @variables TOSA(t) [description = "TOtal SAvings Gdollar/y"]
    @variables TPP(t) [description = "Total Purchasing Power Gdollar/y"]
    @variables WDI(t) [description = "Worker disposable income kDollar/p/y"]

    eqs = []

    add_equation!(eqs, D(TIME) ~ 1)
    add_equation!(eqs, GIPC ~ WorldDynamics.interpolate(t, tables[:GIPC], ranges[:GIPC]))
    add_equation!(eqs, GP ~ WorldDynamics.interpolate(t, tables[:GP], ranges[:GP]))
    add_equation!(eqs, GS ~ WorldDynamics.interpolate(t, tables[:GS], ranges[:GS]))
    add_equation!(eqs, II ~ WorldDynamics.interpolate(t, tables[:II], ranges[:II]))
    add_equation!(eqs, INEQ ~ WorldDynamics.interpolate(t, tables[:INEQ], ranges[:INEQ]))
    add_equation!(eqs, TOSA ~ WorldDynamics.interpolate(t, tables[:TOSA], ranges[:TOSA]))
    add_equation!(eqs, TPP ~ WorldDynamics.interpolate(t, tables[:TPP], ranges[:TPP]))
    add_equation!(eqs, WDI ~ WorldDynamics.interpolate(t, tables[:WDI], ranges[:WDI]))

    return ODESystem(eqs; name=name)
end

