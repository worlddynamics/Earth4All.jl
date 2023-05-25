_inits = Dict{Symbol,Float64}(
    :CCSD => 0.04, # Taken from Vensim table
    :ELTI => 0.02,
    :PEIN => 0.02,
    :PU => 0.0326951,
    :CBSR => 0.02,
)


getinitialisations() = copy(_inits)
