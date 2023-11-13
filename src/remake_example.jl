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
def_dic = ModelingToolkit.defaults(sys)
##

# this is a workaround since I don't understand how to access the values of the dictionary directly; the keys are of type SymbolicUtils.BasicSymbolic...
names_list = collect(keys(def_dic))
names_str = string.(names_list)
nameindices = findall(x -> occursin("CO2A", x), names_str)

changed_id = 78
def_dic[names_list[changed_id]] = 4600.0
##

# now we can re-build the vector of default values and regenerate the problem
new_u0 = ModelingToolkit.varmap_to_vars(def_dic, states(sys))
prob = ODEProblem(sys, new_u0, (1980, 2100))
sol = solve(prob)
##
plot(sol[model.cli₊CO2A])
##