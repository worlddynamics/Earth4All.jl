_tables = Dict{Symbol,Tuple{Vararg{Float64}}}(
    :ROCWSO => (
        0.06,
        0.02,
        0,
        -0.007,
        -0.01,
    ),
)
_ranges = Dict{Symbol,Tuple{Float64,Float64}}(
    :ROCWSO => (0, 2),
)

gettables() = copy(_tables)
getranges() = copy(_ranges)
