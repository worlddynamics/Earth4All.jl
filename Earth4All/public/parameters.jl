_params = Dict{Symbol,Float64}(
    :CTA2022 => 9145,
    :CTPIS => 1.5, # Taken from Output sector
    :EDROTA2022 => 0.003,
    :DROTA1980 => 0.01,
    :FUATA => 0.3,
    :GDPTL => 15,
    :IIEEROTA => -0.1,
    :IPR1980 => 1.2,
    :IPRVPSS => 1,
    :IPT => 1, # Taken from Output sector
    :MIROTA2022 => 0.005,
    :OWETFP => -0.1,
    :SC1980 => 0.3,
    :SCROTA => 0.5,
    :XETAC2022 => 0,
    :XETAC2100 => 0,
    :OW2022 => 1.35,
)

getparameters() = copy(_params)
