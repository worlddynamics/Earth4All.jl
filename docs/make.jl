using Documenter

Home = "Home" => "index.md"

E4A = "The Earth4All model" => "earth4all.md"

tut = "Tutorial" => "tutorial.md"

PAGES = [
    Home,
    tut,
    E4A,
]

makedocs(
    sitename="Earth4All.jl documentation",
    authors="Pierluigi Crescenzi, Emanuele Natale, Aurora Rossi",
    pages=PAGES
)


# deploydocs(
#     repo = "github.com/worlddynamics/Earth4All.git",
# )
