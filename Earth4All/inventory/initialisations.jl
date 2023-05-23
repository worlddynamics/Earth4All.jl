_inits = Dict{Symbol,Float64}(
    :DELDI => 1,
    :EPP => 28087, # Taken from Vensim table
    :INV => 11234.8, # Taken from Vensim table
    :PRIN => 1, # Taken from Vensim table
    :PRI => 1,
    :RS => 28087,
    :SSWI => 1,
)

getinitialisations() = copy(_inits)
