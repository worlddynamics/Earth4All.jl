_inits = Dict{Symbol,Float64}(
    :DELDI => 1,
    :EPP => 28087,
    :INV => 11234.8,
    :PI1980 => 1,
    :PRI => 1,
    :RS => 28087,
    :SSWI => 1,
)

getinitialisations() = copy(_inits)
