include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function finance(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters GRCR = params[:GRCR] [description = "sGReoCR<0"]
    @parameters FSRT = params[:FSRT] [description = "Financial sector response time y"]
    @parameters NBOM = params[:NBOM] [description = "Normal bank operating margin 1/y"]
    @parameters NBBM = params[:NBBM] [description = "Normal basic bank margin 1/y"]
    @parameters NSR = params[:NSR] [description = "Normal signal rate 1/y"]
    @parameters IEFT = params[:IEFT] [description = "Inflation expectation formation time y"]
    @parameters I = params[:I] [description = "Inflation in 1980 1/y"]
    @parameters IPT = params[:IPT] [description = "Inflation perception time CB y"]
    @parameters UPT = params[:UPT] [description = "Unemployment perception time CB y"]
    @parameters INSR = params[:INSR] [description = "sINeoSR>0"]
    @parameters IT = params[:IT] [description = "Inflation target 1/y"]
    @parameters UT = params[:UT] [description = "Unemployment target"]
    @parameters UNSR = params[:UNSR] [description = "sUNeoSR<0"]
    @parameters SRAT = params[:SRAT] [description = "Signal rate adjustment time y"]

    @variables NCCR(t) [description = "Normal corporate credit risk 1/y"]
    @variables CBC(t)  [description = "Corporate borrowing cost 1/y"]
    @variables CCSD(t) = inits[:CCSD] [description = "Cost of capital for secured debt 1/y"]
    @variables TIR(t) [description = "3m interest rate 1/y"]
    @variables WBC(t) [description = "Working borrowing cost 1/y"]
    @variables GBC(t) [description = "Government borrowing cost 1/y"]
    @variables CBC(t) [description = "Corporate borrowing cost in 1980 1/y"]
    @variables TGIR(t) [description = "10 - year government interest rate 1/y"]
    @variables ELTI(t) = inits[:ELTI] [description = "Expected long term inflation 1/y"]
    @variables PI(t) = inits[:PI] [description = "Perceived inflation CB 1/y"]
    @variables PU(t) = inits[:PU] [description = "Perceived unemployment CB"]
    @varbiales ISR(t) [description = "Indicated signal rate 1/y"]  
    @variables CSR(t) [description = "Change in signal rate 1/y"]
    @variables CBSR(t) = inits[:CBSR] [description = "Central bank signal rate 1/y"]

    @variables OGR(t)
    @variables IR(t)

    eqs =[ 
        NCCR ~ 0.02 *(1 + GRCR * (OGR / 0.03 -1)) 
        CBC ~ CCSD + NCCR
        TIR ~ CBSR + NBBM
        WBC ~ CCSD
        GBC ~ TIR
        CBC ~ NSR + NBBM + NBOM + NCCR
        TGIR ~ GBC + ELTI
        ISR ~ NSR * (1 + INSR * (PI / IT - 1) + UNSR * (PU / UT - 1))
        CSR ~ (ISR - CBSR) / SRAT
    ]

    smooth!(eqs, CCSD, TIR+NBOM, FSRT)
    smooth!(eqs, ELTI, PICB, IEFT)
    smooth!(eqs, PI, IR, IPT)
    smooth!(eqs, PU, UR, UPT)
end

function finance_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables OGR(t) [description = "Output growth rate 1/y"] 
    @varibale IR(t) # DA ESPORTAREEE FALLOOOO
    @variable UR(t)
    
    eqs = [
        OGR ~ interpolate(t, tables[:OGR], ranges[:OGR])
    ]

    return ODESystem(eqs; name=name)
end