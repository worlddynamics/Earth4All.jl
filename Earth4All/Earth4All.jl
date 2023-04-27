module Earth4All

using ModelingToolkit
using WorldDynamics

include("functions.jl")

include("Wellbeing.jl")
include("Population.jl")
include("Finance.jl")
include("Public.jl")
include("Other.jl")
include("Energy.jl")
include("Inventory.jl")
include("Climate.jl")
include("Demand.jl")

include("earth4all/scenarios.jl")
include("earth4all/plots.jl")

end
