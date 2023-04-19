module Earth4All

using ModelingToolkit
using WorldDynamics

include("functions.jl")

# export ramp
# @register ramp(x, slope, startx, endx)

include("Population.jl")
include("Finance.jl")

end