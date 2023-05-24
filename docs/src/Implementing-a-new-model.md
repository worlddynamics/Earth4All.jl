
## Summary
In this memorandum, we will describe how a new model can be implemented by using WorldDynamics. To this aim we refer to the third chapter of [Duggan2016]. In this chapter, whose title is \textit{Modeling Limits to Growth}, the author introduces the reader to system dynamics models of limits to growth through three models of increasing complexity. Here, we will implement the third model, in which a growing stock consumes its carrying capacity (this dynamic leads to growth followed by rapid decline).

## Model, sectors, and scenarios

Each model consists of sectors. Each sector is a collection of ODE systems, along with Julia support files specifying the initial values of the variables, the values of the parameters, and the tables and the ranges used to interpolate non-linear functions through linear segments. A scenario is the concatenation of several ODE systems defined in the sectors of the model, along with the connections between the variables defined or used in different ODE systems.

## The limits to growth model

The model (called `NonRenewableStock`) we are going to implement has two sectors, one (called `Capital`) corresponding to the growing stock and one (called `Resource`) corresponding to the non-renewable resource. This is specified in the following code file (which we assume is contained in the directory `Duggan`): this file also include two code files used to define one scenario and to plot some variables of its solution.

```jl
module NonRenewableStock
using ModelingToolkit
using WorldDynamics
include("Capital.jl")
include("Resource.jl")

include("scenarios.jl")
include("plots.jl")
end
```

### The two sectors

The file `Capital.jl` (which we assume is contained in the directory `Duggan`) includes the code files specifying the ODE system of the sector `Capital`, the initial values of the variables, the values of the parameters, and the tables and the ranges used to interpolate non-linear functions through linear segments (all these files are contained in the directory `capital` within the directory `Duggan`).

```jl
module Capital
include("capital/tables.jl")
include("capital/parameters.jl")
include("capital/initialisations.jl")
include("capital/subsystems.jl")
end
```

Analogously, the file `Resource.jl` (also contained in the directory `Duggan`) includes the code files corresponding to the sector `Resource` (all these files are contained in the directory `resource` within the directory `Duggan`).

```jl
module Resource
include("resource/tables.jl")
include("resource/parameters.jl")
include("resource/initialisations.jl")
include("resource/subsystems.jl")
end
```

\paragraph{The sector `Capital`} This sector contains one ODE system which is related to the capital stock. The file `parameters.jl` (which is contained in the directory `capital`) specifies the parameters used by this ODE system (see Equations (3-36), (3-24), (3-26), and (3-34)).

```jl
_params = Dict{Symbol,Float64}(
    :cost_per_investment => 2,
    :depreciation_rate => 0.05,
    :desired_growth_fraction => 0.07,
    :fraction_profits_reinvested => 0.12,
)
getparameters() = copy(_params)
```
In order to well define the ODE system, the file `initialisations.jl` (which is contained in the directory `capital`) specifies the initial variable of the only variable which is involved in a differential equation (see Equation (3-22)).

```jl
_inits = Dict{Symbol,Float64}(
    :capital => 5,
)
getinitialisations() = copy(_inits)
```
Finally, the ODE system of the sector `Capital` does not interpolate any non-linear function. Hence, the following code file contains only two empty dictionaries.

```jl
_tables = Dict{Symbol,Tuple{Vararg{Float64}}}(
)
_ranges = Dict{Symbol,Tuple{Float64,Float64}}(
)
gettables() = copy(_tables)
getranges() = copy(_ranges)
```
The file `subsystems.jl` contains the code specifying the ODE system. The file starts with the declaration of the variable `t`  with respect to which the derivatives have to be computed and continues by declaring one function (corresponding to the only ODE system of the sector `Capital`) in which all variables and parameters are declared and the ODE system is defined (see Equations (3-22), (3-23), (3-25), (3-32), (3-33), (3-35), (3-37), and (3-38)).

```jl
@variables t
D = Differential(t)
function capital_system(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters cost_per_investment = params[:cost_per_investment]
    @parameters depreciation_rate = params[:depreciation_rate]
    @parameters fraction_profits_reinvested = params[:fraction_profits_reinvested]
    @parameters desired_growth_fraction = params[:desired_growth_fraction]

    @variables capital(t) = inits[:capital]
    @variables depreciation(t)
    @variables desired_investment(t)
    @variables capital_costs(t)
    @variables profit(t)
    @variables capital_funds(t)
    @variables maximum_investment(t)
    @variables investment(t)

    @variables total_revenue(t)

    eqs = [
        D(capital) ~ investment - depreciation
        depreciation ~ capital * depreciation_rate
        desired_investment ~ desired_growth_fraction * capital
        capital_costs ~ capital * 0.10
        profit ~ total_revenue - capital_costs
        capital_funds ~ profit * fraction_profits_reinvested
        maximum_investment ~ capital_funds / cost_per_investment
        investment ~ min(desired_investment, maximum_investment)
    ]
    ODESystem(eqs; name)
end
```

### The sector `Resource`
This sector also contains one ODE system which is related to the resource. The file `parameters.jl` (which is contained in the directory `resource`) specifies the parameters used by this ODE system (see Equation~(3-31)).

```jl
_params = Dict{Symbol,Float64}(
    :revenue_per_unit_extracted => 3,
)
getparameters() = copy(_params)
```
In order to well define the ODE system, the file `initialisations.jl` (which is contained in the directory `capital`) specifies the initial variable of the only variable which is involved in a differential equation (see Equation~(3-27)).

```jl
_inits = Dict{Symbol,Float64}(
    :resource => 1000,
)
getinitialisations() = copy(_inits)
```
Finally, the ODE system of the sector `Capital` interpolates one non-linear function. Hence, the following code file defines two dictionaries whose values are the table and the range corresponding to this function, respectively (see Equation (3-29)).

```jl
_tables = Dict{Symbol,Tuple{Vararg{Float64}}}(
    :eepuc => (0.0, 0.25, 0.45, 0.63, 0.75, 0.85, 0.92, 0.96, 0.98, 0.99, 1.0),
)
_ranges = Dict{Symbol,Tuple{Float64,Float64}}(
    :eepuc => (0.0, 1000.0),
)
gettables() = copy(_tables)
getranges() = copy(_ranges)
```
The file `subsystems.jl` contains the code specifying the ODE system. Once again, the file starts with the declaration of the variable `t`  with respect to which the derivatives have to be computed and continues by declaring one function (corresponding to the only ODE system of the sector `Resource`) in which all variables and parameters are declared and the ODE system is defined (see Equations (3-27), (3-28), (3-29), and (3-30)).

```jl
@variables t
D = Differential(t)
function resource_system(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters revenue_per_unit_extracted = params[:revenue_per_unit_extracted]

    @variables resource(t) = inits[:resource]
    @variables extraction(t)
    @variables extraction_efficiency_per_unit_capital(t)
    @variables total_revenue(t)

    @variables capital(t)

    eqs = [
        D(resource) ~ -extraction
        extraction ~ capital * extraction_efficiency_per_unit_capital
        extraction_efficiency_per_unit_capital ~ interpolate(resource, tables[:eepuc], ranges[:eepuc])
        total_revenue ~ revenue_per_unit_extracted * extraction
    ]
    ODESystem(eqs; name)
end
```

### The scenario

As we already said, a scenario is the composition of the two ODE systems defined in the two sectors, along with the specification of the connections between the variable defined or used in the ODE systems. The following code defines a function which return such a composition.

```jl
function nrs_scenario(;
    capital_params = Capital._params,
    resource_params = Resource._params,
    capital_inits = Capital._inits,
    resource_inits = Resource._inits,
    capital_tables = Capital._tables,
    resource_tables = Resource._tables,
    capital_ranges = Capital._ranges,
    resource_ranges = Resource._ranges,
)
    @named cs = Capital.capital_system(; params=capital_params, inits=capital_inits, tables=capital_tables, ranges=capital_ranges)
    @named rs = Resource.resource_system(; params=resource_params, inits=resource_inits, tables=resource_tables, ranges=resource_ranges)

    systems = [
        cs, rs,
    ]


    connection_eqs = [
        rs.capital ~ cs.capital
        cs.total_revenue ~ rs.total_revenue
    ]

    return WorldDynamics.compose(systems, connection_eqs)
end
```
Note that the connection equations could be computed automatically by using the function `variable_connections` described in a [[Computing variable connections]].

## Running the model and generating the plots

In the following code, we solve the ODE system defined in the above scenario and, after specifying which variables we want to plot, we generate the picture with these plots.

```jl
using DifferentialEquations

function solve_nrs_scenario()
    return WorldDynamics.solve(nrs_scenario(), (0, 200), solver=Tsit5(), dt=0.015625, dtmax=0.015625)
end

function _variables_nrs()
    @named cs = Capital.capital_system()
    @named rs = Resource.resource_system()

    variables = [
        (cs.capital, 0, 30, "Capital"),
        (rs.extraction, 0, 15, "Extraction"),
        (cs.investment, 0, 2, "Investment"),
        (cs.depreciation, 0, 2, "Investment"),
        (rs.resource, 0, 1000, "Resource"),
    ]
    return variables
end

@variables t

fig_3_9(; kwargs...) = plotvariables(solve_nrs_scenario(), (t, 0, 200), _variables_nrs(); title="Simulation output showing stocks and flows", showaxis=false, showlegend=true, kwargs...)
```
The above code can be executed as follows (we assume the Julia REPL has been started within the directory `Duggan`).
```jl
include("NonRenewableStock.jl")
NonRenewableStock.fig_3_9()
```
If everything works correctly, the following picture should be produced (see Figure 3.9 of the chapter).

![Figure 3-9](https://github.com/natema/worlddynamicswiki/blob/main/imgs/figure_3_9.png)

[Duggan2016]: https://link.springer.com/book/10.1007/978-3-319-34043-2
