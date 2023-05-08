function wb_run(; kwargs...)
    @named wb = wellbeing(; kwargs...)
    @named wb_sup = wellbeing_support(; kwargs...)

    systems = [
        wb, wb_sup,
    ]

    connection_eqs = [
        wb.GDPP ~ wb_sup.GDPP
        wb.INEQ ~ wb_sup.INEQ
        wb.LPR ~ wb_sup.LPR
        wb.PSP ~ wb_sup.PSP
        wb.PWA ~ wb_sup.PWA
        wb.WDI ~ wb_sup.WDI
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
