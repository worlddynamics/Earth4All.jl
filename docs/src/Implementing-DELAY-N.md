
### Summary
We explain how we can implement the DELAY N function of Vensim and Stella, by using two array of variables. This implementation will be integrated in the new version of `WorldDynamics` by adding it to the file `functions.jl`.

### Prerequisites

We assume that you have read the technical note [[Delay N comments]], in which we described some problems which arise while implementing the DELAY N function. We also assume that you are familiar with array of variables in `ModelingToolkit` (as an example, you can look at the spring-mass system example in the `ModelingToolkit` documentation).

### The `delay_n` function

This function receives in input a vector `eqs` of equations along with the differential `D`, a variable `x` (which corresponds to the variable `input` of the technical note [[Delay N comments]]), two arrays `rt` and `lv` of variables (which correspond to the `RT` and `LV` variables), a delay variable (which corresponds to the variable `delay`), and the order of the delay (that is, the value of `N` which was 1 and 3 in the technical note [[Delay N comments]]). The function adds to the vector `eqs` all the equations of the definition of DELAY N (in the technical note [[Delay N comments]], we gave the definition of DELAY 1 and DELAY 3, only). The delayed variable (that is, the variables `DELAY1` and `DELAY3`) is `rt[order]`.

```jl
function delay_n(eqs, D, x, rt, lv, delay, order)
    append!(eqs, [rt[1] ~ lv[1] / (delay / order)])
    append!(eqs, [D(lv[1]) ~ x - rt[1]])
    for d in 2:order
        append!(eqs, [rt[d] ~ lv[d] / (delay / order)])
        append!(eqs, [D(lv[d]) ~ rt[d-1] - rt[d]])
    end
end
```

### An example

The following is an example of how we can use the above function with order equal to $10$, in the case in which $\mathtt{x}(t) = t$ and $\mathtt{delay}(t) = \sqrt{25+\mathtt{x}(t)}$ (we assume that the code of the function has been saved into the source file `functions.jl`).

```jl
using ModelingToolkit, DifferentialEquations
include("functions.jl")
order = 10
@variables t delay(t) x(t)
@variables (lv_x(t))[1:order] = zeros(order)
@variables (rt_x(t))[1:order] = zeros(order)
D = Differential(t)
eqs = [
    delay ~ sqrt(25 + x)
    D(x) ~ 1
]
delay_n(eqs, D, x, rt_x, lv_x, delay, order)
inits = [x => 0.0]
@named ode = ODESystem(eqs)
prob = ODEProblem(structural_simplify(ode), inits, (0.0, 100.0), [])
sol = solve(prob, Euler(), dt=0.25)
```

This code has been tested by simulating the same model in Stella: the results are exactly the same.

### Integrating the function into `WorldDynamics`

It is easy to integrate the function `delay_n` into `WorldDynamics`. Indeed, we have just to add this function to the file `functions.jl` and, for each already implemented model, appropriately modify the subsystems that use our current implementation of the DELAY 1, DELAY 3, and DELAY N functions. Note that, while doing this, we should take into account that the delayed variable is now `rt[1]`, `rt[2]`, or `rt[10]`: it might be reasonable to add an equation stating that the original delayed variable is equal to `rt[1]`, `rt[2]`, or `rt[10]`.
