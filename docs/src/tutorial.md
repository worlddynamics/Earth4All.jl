# A tutorial of Earth4All.jl

The Julia implementation of the Earth4All model allows the user to *play* with the Earth4All model introduced in [Dixson2022](https://www.clubofrome.org/publication/earth4all-book/). This model is formed by twelve sectors (see the [The Earth4All model](earth4all.md) page).

In the Julia implementation each sector is a Julia module containing a Julia function, which defines the ODE system corresponding to the sector itself. All the ODE systems corresponding to the sectors of the Earth4All model have to be composed. This will produce the entire ODE system of the Earth4All model, which can then be solved.

Let us now see how we can replicate the two scenarios described in the above mentioned book.

## Replicating the Too Little Too Late scenario

In order to simulate the Too Little Too Late scenario, we can simply execute the following code (assuming that we started the Julia REPL within the directory the repository).

```
using ModelingToolkit
using PlotlyJS
using WorldDynamics
include("src/Earth4All.jl");
e4a_sol = Earth4All.run_tltl_solution();
```

This may require some time, because the used Julia packages have to be precompiled.

In order to check that the solution is consistent with the solution produced by the Vensim implementation (using the Euler solver with time step equal $0.015625$), we can plot the values of any variable according to the two solutions. Suppose, for example, that we want to check the `POP` variable, which is contained in the population Vensim view (its Vensim name is `Population Mp`). To this aim we read the values of all variables included in the Vensim population view.   

```
vensim = Earth4All.read_vensim_dataset("VensimOutput/tltl/population.txt", " : E4A-220501 TLTL");
```
(note that the second parameter is a string that has to be ignored while reading the variable values).

We then create the ODE system corresponding to the Population sector.

```
@named pop = Earth4All.Population.population();
```
Finally, we compare and plot the values of the variable `POP` obtained by the Vensim implementation and the WorldDynamics implementation.

```
Earth4All.compare_and_plot("Too Little Too Late", e4a_sol, "Population Mp", pop.POP, vensim, 1980, 2100, 7681, 0.1, true)
```
If everything worked fine, the following figure should be produced.

```@raw html
<div align="center"><img src="../imgs/vensim_vs_worlddynamics/POP_tltl.png" width="500" height="500">
</div>
```
As it can be seen, the two curves are (almost) exactly the same.  The function `compare_and_plot` also print the maximum simmetric relative error, along with the values of the two curves, the iteration index, and the time instant corresponding to this maximum. In the above example, the function should print something similar to the following message.

```
(0.002385476673325227, 7282.516980299014, 7299.91, 7681) at t=2100.0
```

### Working with other sectors and/or other variables

In the above example, we worked with the Population sector. In case we want to work with other sectors of the model, we can use one or more of the following instructions.

```
@named cli = Earth4All.Climate.climate();
@named dem = Earth4All.Demand.demand();
@named ene = Earth4All.Energy.energy();
@named fin = Earth4All.Finance.finance();
@named foo = Earth4All.FoodLand.foodland();
@named inv = Earth4All.Inventory.inventory();
@named lab = Earth4All.LabourMarket.labour_market();
@named oth = Earth4All.Other.other();
@named out = Earth4All.Output.output();
@named pop = Earth4All.Population.population();
@named pub = Earth4All.Public.public();
@named wel = Earth4All.Wellbeing.wellbeing();
```

Moreover, we analysed the population variable, whose Vensim name is "Population Mp". In case we want to analyse other variables, we always have to use their exact Vensim name, as indicated in the variable and parameter interactive tables.

## Replicating the Giant Leap scenario

In order to simulate the Giant Leap scenario, we can execute a similar code.

```
e4a_sol = Earth4All.run_gl_solution();
vensim = Earth4All.read_vensim_dataset("VensimOutput/gl/population.txt", " : E4A-220501 GL");
@named pop = Earth4All.Population.population();
Earth4All.compare_and_plot("Giant Leap", e4a_sol, "Population Mp", pop.POP, vensim, 1980, 2100, 7681, 0.1, true)
```

If everything worked fine, the following figure should be produced.

```@raw html
<div align="center"><img src="../imgs/vensim_vs_worlddynamics/POP_gl.png" width="500" height="500"></div>
```
Moreover, a message similar to the following one should be printed.

```
(0.0019946923672592228, 5984.450944034332, 5996.4, 7681) at t=2100.0
```

## Comparing the two scenarios

In order to compare the dynamics of the variable in tthe two scenariso, we can use the `plot_two_sols` functions. For example, if we want to see the evolution of the variable `POP` in the two scenarios, we can execute the following code.

```
using ModelingToolkit
using PlotlyJS
using WorldDynamics
include("src/Earth4All.jl");
tltl_sol = Earth4All.run_tltl_solution();
gl_sol = Earth4All.run_gl_solution();
@named pop = Earth4All.Population.population();
Earth4All.plot_two_sols("TLTL", tltl_sol, "GL", gl_sol, pop, "Population Mp", 1980, 2100, 7681)
```

If everything worked fine, the following figure should be produced.

```@raw html
<div align="center"><img src="../imgs/tltl_vs_gl/POP_tltl_gl.png" width="500" height="500"></div>
```

By executing the analogue code for the average wellbeing index variable, instead, the following figure should be produced.

```@raw html
<div align="center"><img src="../imgs/tltl_vs_gl/AWBI_tltl_gl.png" width="500" height="500"></div>
```

## Modifying variable initial values and/or parameter values

The initial value of the variables and the value of the parameters can clearly be changed by modifying the Julia source code of Earth4All.jl (these values are contained in the `initialisations.jl` and `parameters.jl` files included in each sector folder). However, Earth4All.jl allows the user to change these values and run the Earth4All model without modifying the source code. Let us see how this can done by considering the following example.

Suppose that we want to change the minimum desired number of children, specified in the parameter `DNCM` of the Population sector. Currently, the value of this parameter is $1.2$ (see [the interactive table](https://worlddynamics.github.io/Earth4All.jl/variables/population.html#DNCM) of the Population sector), and suppose that we want to set this parameter to $2.2$. To this aim, we can execute the following code, which will show the evolution of the population variable and of the observed warming variable produced by the model with the new value of the `DNCM` parameter.

```
using Pkg
Pkg.activate(".");
Pkg.instantiate();
include("src/Earth4All.jl");
using ModelingToolkit
using WorldDynamics

pop_mod_pars = Earth4All.Population.getparameters();
pop_mod_pars[:DNCM] = 2.2;
sol = Earth4All.run_e4a_solution(;pop_pars=pop_mod_pars);
@named pop = Earth4All.Population.population();
@named cli = Earth4All.Climate.climate();
reference_variables = [(cli.OW, 0, 3, "OW"), (pop.POP, 0, 20000, "POP")];
@variables t;
plotvariables(sol, (t, 1980, 2100), reference_variables, title="DNCMIN=2.2", showlegend=true, colored=true)
```

If everything worked fine, the following figure should be produced.

```@raw html
<div align="center"><img src="../imgs/dncm_changed/OW_POP_dncm_changed.png" width="500" height="500"></div>
```

If, instead, we want to compare the evolution of the observed warming variable in the Too Little Too Late scenario and the same scenario with the new value of the `DNCM` parameter, we can execute the following code.

```
using Pkg
Pkg.activate(".");
Pkg.instantiate();
include("src/Earth4All.jl");
using ModelingToolkit
using WorldDynamics

tltl_sol = Earth4All.run_tltl_solution();
pop_mod_pars = Earth4All.Population.getparameters();
pop_mod_pars[:DNCM] = 2.2;
sol = Earth4All.run_e4a_solution(;pop_pars=pop_mod_pars);
@named cli = Earth4All.Climate.climate();
Earth4All.plot_two_sols("TLTL", tltl_sol, "DNCMIN=2.2", sol, cli, "OBserved WArming deg C", 1980, 2100, 7681)
```

If everything worked fine, the following figure should be produced.

```@raw html
<div align="center"><img src="../imgs/dncm_changed/OW_tltl_dncm_changed.png" width="500" height="500"></div>
```

### Working with other sectors and/or with variable initial values

In the above example, we worked with the climate and the population sectors and we changed only a parameter value. In case we want to work with other sectors and/or we want to change a variable initial value, we can use one or more of the following instructios.

```
cli_mod_inits = Earth4All.Climate.getinitialisations();
cli_mod_pars = Earth4All.Climate.getparameters();
dem_mod_inits = Earth4All.Demand.getinitialisations();
dem_mod_pars = Earth4All.Demand.getparameters();
ene_mod_inits = Earth4All.Energy.getinitialisations();
ene_mod_pars = Earth4All.Energy.getparameters();
fin_mod_inits = Earth4All.Finance.getinitialisations();
fin_mod_pars = Earth4All.Finance.getparameters();
foo_mod_inits = Earth4All.FoodLand.getinitialisations();
foo_mod_pars = Earth4All.FoodLand.getparameters();
inv_mod_inits = Earth4All.Inventory.getinitialisations();
inv_mod_pars = Earth4All.Inventory.getparameters();
lab_mod_inits = Earth4All.LabourMarket.getinitialisations();
lab_mod_pars = Earth4All.LabourMarket.getparameters();
oth_mod_inits = Earth4All.Other.getinitialisations();
oth_mod_pars = Earth4All.Other.getparameters();
out_mod_inits = Earth4All.Output.getinitialisations();
out_mod_pars = Earth4All.Output.getparameters();
pop_mod_inits = Earth4All.Population.getinitialisations();
pop_mod_pars = Earth4All.Population.getparameters();
pub_mod_inits = Earth4All.Public.getinitialisations();
pub_mod_pars = Earth4All.Public.getparameters();
wel_mod_inits = Earth4All.Wellbeing.getinitialisations();
wel_mod_pars = Earth4All.Wellbeing.getparameters();
```

In order to access and/or change a variable initial value or a parameter value, we always have to use the exact acronym of the variable or of the parameter, as indicated in the `Name` column of the variable and parameter interactive tables, preceded by a column, as we did in the instruction `pop_mod_pars[:DNCM] = 2.2;`. For example, if we want to change the initial value of the `ALbedo (1)` variable of the climate sector (which currently is $0.3094$) and set it equal to $0.35$, we can do it by executing the following instruction: `cli_mod_inits[:AL] = 0.35;`.
