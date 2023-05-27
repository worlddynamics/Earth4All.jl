using ModelingToolkit
using DifferentialEquations

function run_tltl_solution()
    return WorldDynamics.solve(e4a_run_tltl(), (1980, 2100), solver=Euler(), dt=0.015625, dtmax=0.015625)
end

function run_gl_solution()
    return WorldDynamics.solve(e4a_run_gl(), (1980, 2100), solver=Euler(), dt=0.015625, dtmax=0.015625)
end
