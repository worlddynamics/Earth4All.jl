_params = Dict{Symbol,Float64}(
    :DAT => 1.2,
    :DDI => 1,
    :DIC => 0.4,
    :DP => 0,
    :DRI => 1,
    :ICPT => 0.25,
    :MRIWI => 1.07,
    :NOR1 => 1,
    :OO => 28087,
    :PH => 0,
    :PPU => 1,
    :SAT => 1,
    :SINVEODDI => -0.6,
    :SINVEOIN => -0.26,
    :SINVEOSWI => -0.6,
    :SRI => 1, 
    :SWI => 1,
    :ST => 0.1,
    :STDIFAN => 0,
    :TAS => 0.24,

)

getparameters() = copy(_params)