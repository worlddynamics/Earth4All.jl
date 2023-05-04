_params = Dict{Symbol,Float64}(
    :CBCEFRA => -0.8,
    :CU1980 => 0.8,
    :FCI => 0,
    :FRA1980 => 0.9,
    :FRACAM => 0.65,
    :GDPP1980 => 6.4, # It should be the same as in the Labour and market sector
    :GDPPEFRACA => -0.2,
    :IPT => 1,
    :MA1980 => 0.25,
    :USPIS2022 => 0.01,
    :WSOEFRA => -2.5,
)

getparameters() = copy(_params)
