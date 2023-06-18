module Climate

using WorldDynamics
using ModelingToolkit

include("climate/parameters.jl")
include("climate/initialisations.jl")
include("climate/subsystems.jl")
include("climate/scenarios.jl")
include("climate/plots.jl")

end
