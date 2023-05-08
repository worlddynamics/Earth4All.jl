function e4a_run(; kwargs...)
    @named cli = Climate.climate(; kwargs...)
    @named dem = Demand.demand(; kwargs...)
    @named ene = Energy.energy(; kwargs...)
    @named fin = Finance.finance(; kwargs...)
    @named fl = FoodLand.foodland(; kwargs...)
    @named inv = Inventory.inventory(; kwargs...)
    @named lm = LabourMarket.labour_market(; kwargs...)
    @named oth = Other.other(; kwargs...)
    @named out = Output.output(; kwargs...)
    @named pop = Population.population(; kwargs...)
    @named pub = Public.public(; kwargs...)
    @named wb = Wellbeing.wellbeing(; kwargs...)

    systems = [
        cli, dem, ene, fin, fl, inv, lm, oth, out, pop, pub, wb,
    ]
    # systems = [
    #     pop, pop_sup, wb, wb_sup,
    # ]

    # connection_eqs = [
    #     fin.OGR ~ fin_sup.OGR
    #     fin.IR ~ fin_sup.IR
    #     fin.UR ~ fin_sup.UR
    #     pop.GDP ~ pop_sup.GDP
    #     pop.IPP ~ wb.IPP
    #     pop.OW ~ pop_sup.OW
    #     pub.CTA ~ pub_sup.CTA
    #     pub.GDP ~ pub_sup.GDP
    #     pub.CTPIS ~ pub_sup.CTPIS
    #     pub.IPT ~ pub_sup.IPT
    #     pub.OW2022 ~ pub_sup.OW2022
    #     pub.OW ~ pub_sup.OW
    #     pub.GP ~ pub_sup.GP
    #     pub.CPUS ~ pub_sup.CPUS
    #     pub.GDP ~ pub_sup.GDP
    #     pub.POP ~ pop.POP
    #     pub.GDPP ~ pop.GDPP
    #     pub.II ~ pub_sup.II
    #     pub_GDP.GS ~ pub_GDP_sup.GS
    #     pub_GDP.GDP ~ pub_sup.GDP
    #     pub_GDP.POP ~ pop.POP
    #     wb.GDPP ~ pop.GDPP
    #     wb.INEQ ~ wb_sup.INEQ
    #     wb.LPR ~ wb_sup.LPR
    #     wb.PSP ~ pub_GDP.PSP
    #     wb.PW ~ wb_sup.PW
    #     wb.WDI ~ wb_sup.WDI
    # ]

    # connection_eqs = [
    #     pop.GDP ~ pop_sup.GDP
    #     pop.IPP ~ wb.IPP
    #     pop.OW ~ pop_sup.OW
    #     wb.GDPP ~ pop.GDPP
    #     wb.INEQ ~ wb_sup.INEQ
    #     wb.LPR ~ wb_sup.LPR
    #     wb.PSP ~ wb_sup.PSP
    #     wb.PW ~ wb_sup.PW
    #     wb.WDI ~ wb_sup.WDI
    # ]

    connection_eqs = variable_connections(systems)
    println.(connection_eqs)

    return WorldDynamics.compose(systems, connection_eqs)
end
