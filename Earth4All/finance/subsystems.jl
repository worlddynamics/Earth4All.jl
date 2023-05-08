include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function finance(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters FSRT = params[:FSRT] [description = "Financial Sector Response Time y"]
    @parameters GRCR = params[:GRCR] [description = "sGReoCR<0: Growth Rate effect on Credit Risk"]
    @parameters IEFT = params[:IEFT] [description = "Inflation Expectation Formation Time y"]
    @parameters INSR = params[:INSR] [description = "sINeoSR>0: INflation effect on Signal Rate"]
    @parameters IPT = params[:IPT] [description = "Inflation Perception Time CB y"]
    @parameters IT = params[:IT] [description = "Inflation Target 1/y"]
    @parameters NBOM = params[:NBOM] [description = "Normal Bank Operating Margin 1/y"]
    @parameters NBBM = params[:NBBM] [description = "Normal Basic Bank Margin 1/y"]
    @parameters NSR = params[:NSR] [description = "Normal Signal Rate 1/y"]
    @parameters SRAT = params[:SRAT] [description = "Signal Rate Adjustment Time y"]
    @parameters UPTCB = params[:UPTCB] [description = "Unemployment Perception Time CB y"]
    @parameters UNSR = params[:UNSR] [description = "sUNeoSR<0: UNemployment effect on Signal Rate"]
    @parameters UT = params[:UT] [description = "Unemployment Target"]

    @variables CBC(t) [description = "Corporate Borrowing Cost 1/y"]
    @variables CBSR(t) = inits[:CBSR] [description = "Central Bank Signal Rate 1/y"]
    @variables CCSD(t) = inits[:CCSD] [description = "Cost of Capital for Secured Debt 1/y"]
    @variables CSR(t) [description = "Change in Signal Rate 1/y"]
    @variables GBC(t) [description = "Government Borrowing Cost 1/y"]
    @variables CBC1980(t) [description = "Corporate Borrowing Cost in 1980 1/y"]
    @variables ELTI(t) = inits[:ELTI] [description = "Expected Long Term Inflation 1/y"]
    @variables ISR(t) [description = "Indicated Signal Rate 1/y"]
    @variables NCCR(t) [description = "Normal Corporate Credit Risk 1/y"]
    @variables PEIN(t) = inits[:PEIN] [description = "Perceived Inflation CB 1/y"]
    @variables PU(t) = inits[:PU] [description = "Perceived Unemployment CB"]
    @variables TGIR(t) [description = "10-year Government Interest Rate 1/y"]
    @variables TIR(t) [description = "3m Interest Rate 1/y"]
    @variables WBC(t) [description = "Working Borrowing Cost 1/y"]

    @variables IR(t)
    @variables OGR(t)
    @variables UNRA(t)

    eqs = []

    add_equation!(eqs, CBC ~ CCSD + NCCR)
    add_equation!(eqs, CBC1980 ~ NSR + NBBM + NBOM + NCCR)
    smooth!(eqs, CCSD, TIR + NBOM, FSRT)
    add_equation!(eqs, D(CBSR) ~ CSR)
    add_equation!(eqs, CSR ~ (ISR - CBSR) / SRAT)
    smooth!(eqs, ELTI, PEIN, IEFT)
    add_equation!(eqs, GBC ~ TIR)
    add_equation!(eqs, ISR ~ NSR * (1 + INSR * (PEIN / IT - 1) + UNSR * (PU / UT - 1)))
    add_equation!(eqs, NCCR ~ 0.02 * (1 + GRCR * (OGR / 0.03 - 1)))
    smooth!(eqs, PEIN, IR, IPT)
    smooth!(eqs, PU, UNRA, UPTCB)
    add_equation!(eqs, TGIR ~ GBC + ELTI)
    add_equation!(eqs, TIR ~ CBSR + NBBM)
    add_equation!(eqs, WBC ~ CCSD)

    return ODESystem(eqs; name=name)
end

function finance_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables IR(t) [description = "Inventory.Inflation Rate 1/y"]
    @variables OGR(t) [description = "Output.Output Growth Rate 1/y"]
    @variables UNRA(t) [description = "Labour market.UNemployment RAte"]

    eqs = []

    add_equation!(eqs, IR ~ WorldDynamics.interpolate(t, tables[:IR], ranges[:IR]))
    add_equation!(eqs, OGR ~ WorldDynamics.interpolate(t, tables[:OGR], ranges[:OGR]))
    add_equation!(eqs, UNRA ~ WorldDynamics.interpolate(t, tables[:UNRA], ranges[:UNRA]))

    return ODESystem(eqs; name=name)
end
