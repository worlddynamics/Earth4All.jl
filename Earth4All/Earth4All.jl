module Earth4All

using ModelingToolkit
using WorldDynamics

include("functions.jl")
include("solvesystems.jl")

include("Demand.jl")
include("Inventory.jl")
include("Output.jl")

include("earth4all/scenarios.jl")
include("earth4all/plots.jl")

end
