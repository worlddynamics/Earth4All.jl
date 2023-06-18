module Demand

using WorldDynamics
using ModelingToolkit

include("demand/parameters.jl")
include("demand/initialisations.jl")
include("demand/subsystems.jl")
include("demand/scenarios.jl")
include("demand/plots.jl")

end
