_inits = Dict{Symbol,Float64}(
    :FACNC => 1.05149, # Taken from Vensim table
    :WSO => 0.5, # Taken from Labour and market sector
)

getinitialisations() = copy(_inits)
