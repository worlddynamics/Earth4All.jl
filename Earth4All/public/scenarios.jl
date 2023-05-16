function public_run(; kwargs...)
    @named pub = public(; kwargs...)
    @named pub_sup = public_support(; kwargs...)

    systems = [
        pub, pub_sup
    ]

    connection_eqs = [
        pub.CPUS ~ pub_sup.CPUS
        pub.CTA ~ pub_sup.CTA
        pub.GDP ~ pub_sup.GDP
        pub.GDPP ~ pub_sup.GDPP
        pub.GP ~ pub_sup.GP
        pub.GS ~ pub_sup.GS
        pub.INEQI ~ pub_sup.INEQI
        pub.OW ~ pub_sup.OW
        pub.POP ~ pub_sup.POP
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
