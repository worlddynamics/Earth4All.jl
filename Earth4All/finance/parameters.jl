_params = Dict{Symbol,Float64}(
    :FSRT => 1,
    :GRCR => 0,
    :IEFT => 10,
    :INSR => 0.7,
    :IPT => 1,
    :IT => 0.02,
    :NBBM => 0.005,
    :NBOM => 0.015,
    :NSR => 0.02,
    :SRAT => 1,
    :UNSR => -1.5,
    :UPTCB => 1,
    :UT => 0.05,
)

getparameters() = copy(_params)
