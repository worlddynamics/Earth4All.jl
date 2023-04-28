_inits = Dict{Symbol,Float64}(
    :ETF2022 => 0,
    :FGBW => 0.3,
    :POCI => 7081,
    :WD => 7406.88,
    :PWCIN => 13000,
    :GD => 17975.7,
    :PGCIN => 5400,
    :GNI => 6531.07,
)


getinitialisations() = copy(_inits)
