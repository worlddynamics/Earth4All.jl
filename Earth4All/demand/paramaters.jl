_params = Dict{Symbol,Float64}(
    :GITRO => 0.3,
    :ITRO2022 => 0.3,
    :ITRO1980 => 0.4,

)

getparameters() = copy(_params)
