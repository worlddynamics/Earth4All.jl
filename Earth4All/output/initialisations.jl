_inits = Dict{Symbol,Float64}(
    :CUCPUS => 909.5, # Taken from Vensim table
    :ETFP => 1,
    :FACNC => 1.05149, # Taken from Vensim table
    :LAUS => 3060, # Taken from Labour and market sector
    :WSO => 0.5, # Taken from Labour and market sector
)

getinitialisations() = copy(_inits)
