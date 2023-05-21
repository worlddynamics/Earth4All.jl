function output_run(; kwargs...)
    @named out = output(; kwargs...)
    @named out_sup = output_full_support(; kwargs...)

    systems = [
        out, out_sup,
    ]

    connection_eqs = [
        out.CBC ~ out_sup.CBC
        out.CBC1980 ~ out_sup.CBC1980
        out.GDP ~ out_sup.GDP
        out.GDPP ~ out_sup.GDPP
        out.GIPC ~ out_sup.GIPC
        out.ITFP ~ out_sup.ITFP
        out.LAUS ~ out_sup.LAUS
        out.OW ~ out_sup.OW
        out.TS ~ out_sup.TS
        out.TPP ~ out_sup.TPP
        out.WASH ~ out_sup.WASH
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
