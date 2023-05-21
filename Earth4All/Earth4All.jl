module Earth4All

using ModelingToolkit
using WorldDynamics

include("functions.jl")
include("solvesystems.jl")
println("=== Including all tables ===")
@time include("tables.jl")
println("=== All tables included ===")

include("Demand.jl")
include("Inventory.jl")
include("Output.jl")
include("Public.jl")
include("Wellbeing.jl")

include("earth4all/scenarios.jl")
include("earth4all/plots.jl")

end
