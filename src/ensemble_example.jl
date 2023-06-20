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
##
# This is the function that will be called to generate a new initial condition. 
# In this case, we are adding a small amount of normally distributed noise to the initial condition.
function prob_func(prob, i, repeat)
    remake(prob, u0 = prob.u0 .* (1 .+ 0.1*randn(length(prob.u0))))
end
##
ensemble_prob = EnsembleProblem(prob, prob_func = prob_func)
##
sol = solve(ensemble_prob, Euler(), EnsembleThreads(), trajectories=10; dt=0.015625, dtmax=0.015625)
##
summ = EnsembleSummary(sol)
##
# you can get the trajectory index with 
# ```
# println.(enumerate(states(sys))," -> ",getdescription.(states(sys)))
# ```
i = 26
plot(summ, fillalpha=.5, trajectories = i, title=(getdescription.(states(sys)))[i])
##