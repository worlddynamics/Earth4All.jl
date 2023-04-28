_params = Dict{Symbol,Float64}(
    :GITRO => 0.3,
    :ITRO2022 => 0.3,
    :ITRO1980 => 0.4,
    :BITRW => 0.2,
    :EETF2022 => 0.02,
    :EPTF2022 => 0.02,
    :EGTRF2022 => 0.01,
    :FETACPET => 0.5,
    :TINT => 5,
    :FETPO => 0.8,
    :ETGBW => 0.2,
    :FT1980 => 0.3,
    :GEIC => 0.02,
    :INEQ1980 => 0.61,
    :TAOC => 1,
    :GDPOSR => -0.06,
    :OSF1980 => 0.9,
    :MWDB => 1,
    :MATWF => 0.39,
    :WDP => 10,
    :WPP => 20,
    :TAWC => 1,
    :WCF => 0.9,
    :STR => 0.03,
    :GSF2022 => 0,
    :MGDB => 1,
    :GDDP => 10,
    :GPP => 200,


)

getparameters() = copy(_params)
