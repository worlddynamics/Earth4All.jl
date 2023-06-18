module FoodLand

using WorldDynamics
using ModelingToolkit

include("foodland/parameters.jl")
include("foodland/initialisations.jl")
include("foodland/subsystems.jl")
include("foodland/scenarios.jl")
include("foodland/plots.jl")

end
