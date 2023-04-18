_params = Dict{Symbol,Float64}(
    :CMFR => 0.01,
    :DNC80 => 4.3,
    :DNCA => 0,
    :DNCG => 0.14,
    :DNCM => 1.2,
    :EIP => 30,
    :EIPF => 0,
    :FP => 20,
    :FW => 0.5,
    :GEFR => 0.2,
    :MFM => 1.6,
    :MLEM => 1.1,
    :SSP2FA2022F => 1,
    :TAHI => 10,
)

getparameters() = copy(_params)
