_inits = Dict{Symbol,Float64}(
    :CUCPIS => 10072.5, # Taken from Vensim table
    :CUCPUS => 909.5, # Taken from Vensim table
    :ETFP => 1,
    # UNDOCUMENTED INITIALISATIONS
    :FACNC => 1.05149, # Taken from Vensim table
    :LAUS => 3060, # Taken from Labour and market sector
    :OLY => 26497.1, # Taken from Vensim table
    :WSO => 0.5, # Taken from Labour and market sector
)

getinitialisations() = copy(_inits)
