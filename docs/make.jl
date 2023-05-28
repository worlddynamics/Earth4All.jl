using Documenter

Home = "Home" => "index.md"

E4A = "The Earth4All model" => "earth4all.md"

Sectors = "Sectors" => [
    "climate.md",
    "demand.md",
    "energy.md",
    "finance.md",
    "foodland.md",
    "inventory.md",
    "labourmarket.md",
    "other.md",
    "output.md",
    "population.md",
    "public.md",
    "wellbeing.md"
]

tut = "Tutorial" => "tutorial.md"

PAGES = [
    Home,
    tut,
    E4A,
    Sectors,
]

makedocs(
    sitename="Earth4All documentation",
    authors="Pierluigi Crescenzi, Emanuele Natale, Aurora Rossi",
    pages=PAGES
)


# deploydocs(
#     repo = "github.com/worlddynamics/Earth4All.git",
# )
