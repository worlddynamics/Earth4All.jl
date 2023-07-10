_params = Dict{Symbol,Float64}(
    :DAT => 1.2,
    :DDI1980 => 1,
    :DIC => 0.4,
    :DRI => 1,
    :ICPT => 0.25,
    :MRIWI => 1.07,
    :OO => 28087,
    # :PH => 0,
    :PPU => 1,
    :SAT => 1,
    :INVEODDI => -0.6,
    :INVEOIN => -0.26,
    :INVEOSWI => -0.6,
    :SRI => 1,
    :SWI1980 => 1,
    :TAS => 0.24,
)

getparameters() = copy(_params)
