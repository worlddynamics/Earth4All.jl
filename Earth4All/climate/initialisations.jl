_inits = Dict{Symbol,Float64}(
    :N2OA => 1.052,
    :CH4A => 2.5,
    :CO2A => 2600,
)


getinitialisations() = copy(_inits)
