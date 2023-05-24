_inits = Dict{Symbol,Float64}(
    :CUCPIS => 38971, # Taken from Vensim table
    :CUCPUS => 909.5, # Taken from Vensim table
    :ETFP => 1,
    # UNDOCUMENTED INITIALISATIONS
    :FACNC => 1.05149, # Taken from Vensim table
    :LAUS => 3060, # Taken from Labour and market sector
    :WSO => 0.5, # Taken from Labour and market sector
    :OLY => 26274,
)

getinitialisations() = copy(_inits)
