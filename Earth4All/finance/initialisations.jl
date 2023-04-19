_inits = Dict{Symbol,Float64}(
    :CCSD => TIR+NBOM,
    :ELTI => I,
    :PI => I,
    :PU => UR,
)


getinitialisations() = copy(_inits)
