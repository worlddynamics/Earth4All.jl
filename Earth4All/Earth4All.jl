module Earth4All

using ModelingToolkit
using WorldDynamics

include("functions.jl")

include("Climate.jl")
include("Energy.jl")
include("Finance.jl")
include("FoodLand.jl")
include("Inventory.jl")
include("LabourMarket.jl")
include("Other.jl")
include("Output.jl")
include("Population.jl")
include("Public.jl")
include("Wellbeing.jl")

include("earth4all/scenarios.jl")
include("earth4all/plots.jl")

end
