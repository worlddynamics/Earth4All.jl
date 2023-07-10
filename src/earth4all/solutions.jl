using ModelingToolkit
using DifferentialEquations

function run_tltl_solution(; default_solver=Euler(), default_dt=0.015625, default_dtmax=0.015625)
    return WorldDynamics.solve(run_tltl(), (1980, 2100), solver=default_solver, dt=default_dt, dtmax=default_dtmax)
end

function run_gl_solution(; default_solver=Euler(), default_dt=0.015625, default_dtmax=0.015625)
    return WorldDynamics.solve(run_gl(), (1980, 2100), solver=default_solver, dt=default_dt, dtmax=default_dtmax)
end
