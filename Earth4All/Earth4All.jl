module Earth4All

using ModelingToolkit
using WorldDynamics

include("functions.jl")

include("Wellbeing.jl")
include("Population.jl")
include("Finance.jl")
include("Public.jl")

include("scenarios.jl")
include("plots.jl")

end
