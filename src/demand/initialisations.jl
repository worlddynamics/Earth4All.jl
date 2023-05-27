_inits = Dict{Symbol,Float64}(
    :ETF2022 => 0, # No extra taxes before 2022
    :FGBW => 0.3, # Equal to fraction transfer in 1980
    :POCI => 7081, # It was OCI in 1980
    :WD => 7406.88,
    :PWCIN => 13000,
    :PGCIN => 5400,
    :GNI => 6531.07,
)


getinitialisations() = copy(_inits)
