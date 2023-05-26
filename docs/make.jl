using Documenter

Home = "Home" => "index.md"

E4A = "The Earth4All model" => "The-Earth4All-model.md"

Sectors = "Sectors" => [
    "The-Climate-sector.md",
    "The-Demand-sector.md",
    "The-Energy-sector.md",
    "The-Finance-sector.md",
    "The-Food-and-land-sector.md",
    "The-Inventory-sector.md",
    "The-Labour-market-sector.md",
    "The-Other-performance-indicators-sector.md",
    "The-Output-sector.md",
    "The-Population-sector.md",
    "The-Public-sector.md",
    "The-Wellbeing-sector.md"
]

tut = "Tutorial" => "tutorial.md"

PAGES = [
    Home,
    E4A,
    Sectors,
    tut
]

makedocs(
    sitename="Earth4All documentation",
    authors="Pierluigi Crescenzi, Emanuele Natale, Aurora Rossi",
    pages=PAGES
)


# deploydocs(
#     repo = "github.com/worlddynamics/Earth4All.git",
# )
