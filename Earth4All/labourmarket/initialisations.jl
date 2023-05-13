_inits = Dict{Symbol,Float64}(
    :ECLR => 41,
    :GDPP => 6.4, # Taken from Vensim table
    :ILPR => 0.8, # Taken from Vensim table
    :LAPR => 7.343, # Taken from Vensim table
    :LAUS => 3060, # Taken from Vensim table
    :NHW => 2,
    :NLPR => 0.85,
    :ROCECLR => 0.02,
    :UR => 0.05,
    :WARA => 3.6715, # Taken from Vensim table
    :WEOCLR => 1, # Taken from Vensim table
    :WF => 1530,
    :WSO => 0.5,
)

getinitialisations() = copy(_inits)
