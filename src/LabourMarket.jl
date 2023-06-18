module LabourMarket

using WorldDynamics
using ModelingToolkit

include("labourmarket/parameters.jl")
include("labourmarket/initialisations.jl")
include("labourmarket/subsystems.jl")
include("labourmarket/scenarios.jl")
include("labourmarket/plots.jl")

end
