_tables = Dict{Symbol,Tuple{Vararg{Float64}}}(
    :IEST => (
        1,
        1,
        0,
    ),
    :PSESTR => (
        0,
        1,
    ),
)
_ranges = Dict{Symbol,Tuple{Float64,Float64}}(
    :IEST => (0, 2),
    :PSESTR => (0, 1),
)

gettables() = copy(_tables)
getranges() = copy(_ranges)
