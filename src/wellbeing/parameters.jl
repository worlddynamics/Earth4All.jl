_params = Dict{Symbol,Float64}(
    :AI => 0.6,
    :AP => 0.02,
    :AWBPD => 9,
    :DRDI => 0.5,
    :DRPS => 0.7,
    :EIP => 30,
    :EIPF => 0,
    :GWEAWBGWF => -0.58,
    :IEAWBIF => -0.6,
    :MWBGW => 0.2,
    :NRD => 30,
    :PESTF => -15,
    :PAEAWBF => 0.5,
    :PREAWBF => 6,
    :SPS => 0.3,
    :STEERDF => 1,
    :STRERDF => -1,
    :TCRD => 10,
    :TDI => 15,
    :TEST => 10,
    :TI => 0.5,
    :TP => 0.8,
    :TPR => 0.02,
    :TPS => 3,
    :TW => 1,
)

getparameters() = copy(_params)
