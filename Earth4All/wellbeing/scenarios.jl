function wellbeing_run(; kwargs...)
    @named wel = wellbeing(; kwargs...)
    @named wel_sup = wellbeing_support(; kwargs...)

    systems = [
        wel, wel_sup,
    ]

    connection_eqs = [
        wel.GDPP ~ wel_sup.GDPP
        wel.INEQ ~ wel_sup.INEQ
        wel.LPR ~ wel_sup.LPR
        wel.PSP ~ wel_sup.PSP
        wel.PWA ~ wel_sup.PWA
        wel.WDI ~ wel_sup.WDI
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
