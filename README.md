# Earth4All.jl
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://worlddynamics.github.io/Earth4All.jl/)

Repository of the Julia implementation of the [Earth4All model](https://earth4all.life/the-science-rp/) using the [WorldDynamics framework](https://github.com/worlddynamics/WorldDynamics.jl).

## How to run the model 

### Prerequisites

[Install Julia](https://julialang.org/) and clone the repository: 
```sh
git clone https://github.com/worlddynamics/Earth4All
```

### Setting up the environment

After starting the Julia REPL in the repository folder, we can instantiate the environment by running
```jl
julia> using Pkg
julia> Pkg.activate(".")
julia> Pkg.instantiate()
```

We can then load the `Earth4All` module and run a scenario (e.g. "Too Little Too Late") with 
```jl
julia> include("src/Earth4All.jl")
julia> sol = Earth4All.run_gl_solution()
```

## Acknowledgments 

This work has been supported by the French government, through the UCAJEDI and UCA DS4H Investments in the Future projects managed by the National Research Agency (ANR) with the reference number ANR-15-IDEX-0001 and ANR-17-EURE-0004.

<img src="https://indico.gssi.it/event/2/images/6-GSSI-Logo-R.png" style="width:270px;"/>

<img src="https://ds4h.univ-cotedazur.fr/medias/photo/uca-ds4h-france2030_1674577606814-png?ID_FICHE=1055467" style="width:500px;"/>

### How to cite this work
This work can be provisionally cited as follows:
```
@software{pierluigi_crescenzi_2023_e4a,
  author       = {Pierluigi Crescenzi and Aurora Rossi and contributors},
  title        = {Julia implementation of the Earth4All model using WorldDynamics.jl},
  month        = may,
  year         = 2023,
  url          = {https://github.com/worlddynamics/Earth4All}
}
```
