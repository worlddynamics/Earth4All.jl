_inits = Dict{Symbol,Float64}(
    :PGDPP => 6.4 * 0.93,
)


getinitialisations() = copy(_inits)
