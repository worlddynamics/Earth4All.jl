module Inventory

using WorldDynamics
using ModelingToolkit

include("inventory/tables.jl")
include("inventory/parameters.jl")
include("inventory/initialisations.jl")
include("inventory/subsystems.jl")
include("inventory/scenarios.jl")
include("inventory/plots.jl")

end
