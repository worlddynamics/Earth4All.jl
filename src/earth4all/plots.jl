using ModelingToolkit
using DifferentialEquations


@variables t

function _variables()
    @named pop = Population.population()
    @named wb = Wellbeing.wellbeing()
    @named cli  =  Climate.climate()
    @named dem = Demand.demand()
    variables = [
        (pop.POP, 0, 10000, "Population"),
        (wb.AWBI, 0, 2.4, "Average wellbeing" ),
        (pop.GDPP, 0 , 60, "GDP per person"),
        (wb.STE, 1, 2, "Social tension"),
        (dem.INEQ, 0, 1, "Inequality"),
        (cli.OW, 0, 2, "Global warming"),

    ]
    return variables
end

fig_baserun_tltl(; kwargs...) = plotvariables(run_tltl_solution(), (t, 1980, 2100), _variables(); title="Too Little too late model base run plot", showaxis=true, showlegend=true, kwargs...)


fig_baserun_gl(; kwargs...) = plotvariables(run_gl_solution(), (t, 1980, 2100), _variables(); title="Giant Leap model base run plot", showaxis=true, showlegend=true, kwargs...)
