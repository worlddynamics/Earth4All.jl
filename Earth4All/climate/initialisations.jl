_inits = Dict{Symbol,Float64}(
    :N2OA => 1.052,
    :CH4A => 2.5,
    :CO2A => 2600,
    :ISCEGA => 12,
    :PWA => 0.4,
    :EHS => 0,
)


getinitialisations() = copy(_inits)
