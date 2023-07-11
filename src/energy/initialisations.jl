_inits = Dict{Symbol,Float64}(
    :EEPI2022 => 1,
    :REC => 300,
    :ACSWCF => 10,
    :FEC => 980,)


getinitialisations() = copy(_inits)
