# Computing variable connections
## Summary
In this memorandum, we will explain how we can compute automatically the variable connections of a scenario (that is, a collection of ODE systems). This method is currently implemented in the function `variable_connections`, which is now included in the file `solvesystems.jl`.

## Prerequisites

We assume that each variable is defined in exactly one ODE system: that is, each variable appears in exactly one Left-Hand Side (in short, LHS) of an equation of an ODE system. Moreover, if a variable appears in the Right-Hand Side (in short, RHS) of an equation of an ODE system, then it has the same name as the one used in the ODE system in which the variable is defined.

## Functions of `ModelingToolkit`

We will make use of the following two functions, which are available in the package `ModelingToolkit`.

- `variable_dependencies`. For each variable in the input system, this function determines the equations that modify it, that is, in which the variable appears in the LHS of the equation. The function returns this information as a bipartite graph.
- `equation_dependencies`. This function calculates, for each equation in the input system, the variables it depends on. The function returns a vector of vectors of variables.
\end{itemize}

## Computing the variable connections

Given a vector `systems` of ODE systems, the function `variable_connections` first compose all the systems into a single ODE system.

```jl
@variables t
@named _model = ODESystem([], t)
@named model = ModelingToolkit.compose(_model, systems)
```

It then initialises the set of variable connection equations, the dictionary mapping each variable name to the name of the *unique* ODE system in which the variable is modified, and the dictionary mapping each variable name to its full name (that is, its name preceded by the name of the unique ODE system in which the variable is modified and separated by the symbol $_+$).

```jl
connection_eqs::Set{Equation} = Set{Equation}()
var2sys::Dict{String,String} = Dict{String,String}()
var2fullvar = Dict()
```

By using the function `variable_dependencies`, the adjacency list of each node of the resulting bipartite graph is examined. This adjacency list contains exactly one element, whenever the corresponding variable has been defined in the corresponding system. In this case, we deduce the name of the system from the full name of the variable, and we save this information in the two dictionaries.

```jl
g = variable_dependencies(model)
al = g.fadjlist
for u in 1:lastindex(al)
    if (length(al[u]) == 1)
        s, v = split(string(states(model)[u]), "$_+$")
        var2sys[v] = s
        var2fullvar[v] = states(model)[u]
    end
end
```

By using the function `equation_dependencies`, for each equation we examine the vector of the full names of the variables it depends on. For each such full name, we deduce from it the name of the corresponding system: if it is not the the unique system in which the variable is defined, then we add the variable connection equation to the set of all variable connection equations.

```jl[breaklines=true,frame=single]
ed = equation_dependencies(model)
for u in 1:lastindex(ed)
    vl = ed[u]
    for v in 1:lastindex(vl)
        subs, var = split(string(vl[v]), "$_+$")
        if (var2sys[var] != subs)
            push!(connection_eqs, vl[v] ~ var2fullvar[var])
        end
    end
end
```

Finally, we return the collection of all the variable connection equations.

```jl
return collect(connection_eqs)
```

## Tests

The function has been tested in the case of the scenario `historicalrun` of the `World3` model and in the case of the scenario `natural_resource_depletion` of the `World2` model. In both cases, we have tested that the vector of variable connection equations was the same as the one in the current distribution of `WorldDynamics`. We also included a test on some small and simple ODE systems.

## Side effects

While testing the function in the case of the `World3` model, we realized that one variable connection equation, that is, `ppgf22 ~ 1.0`, is indeed an algebraic equation to be put in an ODE subsystem of the pollution system. To this aim, we added a subsystem to the pollution system, called `persistent_pollution_dummy`, which contains only this equation.

```jl
function persistent_pollution_dummy(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables ppgf22(t)
    eqs = [ppgf22 ~ 1.0]
    ODESystem(eqs; name)
end
```
Clearly, this subsystem has to be added to the scenario `historicalrun` as follows.

```jl
@named ppd = Pollution.persistent_pollution_dummy(; params=pollution_params, inits=pollution_inits, tables=pollution_tables, ranges=pollution_ranges)
```
