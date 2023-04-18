_inits = Dict{Symbol,Float64}(
    :A0020 => 2170,
    :A2040 => 1100,
    :A4060 => 768,
    :A60PL => 382,
    :DYING => 30,
    :EGDPP => 6.4,
    :PASS20 => 100,
    :PASS40 => 64,
    :PASS60 => 38,
)

getinitialisations() = copy(_inits)
