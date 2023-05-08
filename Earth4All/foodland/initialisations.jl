_inits = Dict{Symbol,Float64}(
    :BALA => 3000,
    :CRLA => 1450,
    :GRLA => 3300,
    :FOLA => 1100,
    :OGFA => 2600,
    :SQICA => 1,
    :URLA => 215,
)


getinitialisations() = copy(_inits)
