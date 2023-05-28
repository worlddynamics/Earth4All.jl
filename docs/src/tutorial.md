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
