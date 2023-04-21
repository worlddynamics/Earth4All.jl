_params = Dict{Symbol,Float64}(
    :MNFCO2PP => 0.5,
    :FCO2SCCS2022 => 0,
    :GFCO2SCCS => 0.9,
    :CCCSt => 95,
    :ROCTCO2PT => - 0.003,
    :EROCEPA2022 => 0.004,
    

)

getparameters() = copy(_params)
