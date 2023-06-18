module Finance

using WorldDynamics
using ModelingToolkit

include("finance/parameters.jl")
include("finance/initialisations.jl")
include("finance/subsystems.jl")
include("finance/scenarios.jl")
include("finance/plots.jl")

end
