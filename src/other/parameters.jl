_params = Dict{Symbol,Float64}(
    :TEGR => 4,
    :INELOK => -0.5,
    :NK => 0.3,
)

getparameters() = copy(_params)
