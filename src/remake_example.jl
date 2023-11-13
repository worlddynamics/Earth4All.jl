include("Earth4All.jl")
##
using ModelingToolkit
using DifferentialEquations
using Plots 
##
tltl = Earth4All.run_tltl()
##
sys = structural_simplify(tltl)
prob = ODEProblem(sys, [], (1980, 2100))
model = prob.f.sys # variables are fields of this
##

# this is a workaround since I don't understand how to access the values of the dictionary directly; the keys are of type SymbolicUtils.BasicSymbolic...
function get_def_id(s::String, names_list)
    names_str = string.(names_list)
    nameindices = findall(x -> occursin(s*"(", x), names_str)
    if length(nameindices) == 0
        error("No default value found for $s")
    elseif length(nameindices) > 1
        error("More than one default value found for $s")
    else
        return nameindices[1]
    end
end

function change_inits(s::String, val::Number, sys)
    def_dic = ModelingToolkit.defaults(sys)
    names_list = collect(keys(def_dic))
    def_dic[get_def_id(s, names_list)] = val
    return ModelingToolkit.varmap_to_vars(def_dic, states(sys))
end

##
# now we can re-build the vector of default values and regenerate the problem
new_u0 = change_inits("CO2A", 4000., sys)
prob = ODEProblem(sys, new_u0, (1980, 2100))
sol = solve(prob)
##
plot(sol[model.cli₊CO2A])
##