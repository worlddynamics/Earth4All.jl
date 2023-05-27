_params = Dict{Symbol,Float64}(
    :AUR => 0.05,
    :FIC => 1,
    :GDPP1980 => 6.4, # Should be the same in Population
    :GDPPEROCCLRM => -0.1,
    :GENLPR => 0,
    :NLPR80 => 0.85,
    :PFTJ => 1,
    :PFTJ80 => 1,
    :PRUN => 1, # Taken from Vensim table
    :PUELPR => 0.05,
    :ROCECLR80 => 0.02,
    :RWER => 0.015,
    :TAHW => 5,
    :TENHW => -0.03,
    :TELLM => 5,
    :TYLD => 2.3,
    :WSOECLR => 1.05,
    :WSOELPR => 0.2,
)

getparameters() = copy(_params)
