include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function population(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @parameters CMFR = params[:CMFR] [description = "Cost of Max Fertility Reduction (share of GDP)"]
    @parameters DNC80 = params[:DNC80] [description = "DNC in 1980"]
    @parameters DNCA = params[:DNCA] [description = "DNCalfa<0"]
    @parameters DNCG = params[:DNCG] [description = "DNCgamma"]
    @parameters DNCM = params[:DNCM] [description = "DNCmin"]
    @parameters EIP = params[:EIP] [description = "Exogenous Introduction Period y"]
    @parameters EIPF = params[:EIPF] [description = "Exogenous Introduction Period Flag"]
    @parameters FP = params[:FP] [description = "Fertile Period"]
    @parameters FW = params[:FW] [description = "Fraction Women"]
    @parameters GEFR = params[:GEFR] [description = "Goal for Extra Fertility Reduction"]
    @parameters MFM = params[:MFM] [description = "Max fertility multiplier"]
    @parameters MLEM = params[:MLEM] [description = "Max life expectancy multiplier"]
    @parameters SSP2FA2022F = params[:SSP2FA2022F] [description = "SSP2 Family Action from 2022 Flag"]
    @parameters TAHI = params[:TAHI] [description = "Time to adapt to higher income y"]

    @variables A0020(t) = inits[:A0020] [description = "Aged 0-20 years Mp"]
    @variables A2040(t) = inits[:A2040] [description = "Aged 20-40 years Mp"]
    @variables A4060(t) = inits[:A4060] [description = "Aged 40-60 years Mp"]
    @variables A60PL(t) = inits[:A60PL] [description = "Aged 60+ in 1980 Mp"]
    @variables CEFR(t) [description = "Cost of Extra Fertility Reduction (share of GDP)"]
    @variables DNC(t) [description = "Desired No of Children"]
    @variables DYING(t) = inits[:DYING] [description = "Dying Mp/y"]
    @variables EFR(t) [description = "Extra Fertility Reduction"]
    @variables EGDPP(t) = inits[:EGDPP] [description = "Effective GDP per Person kDollar/p/y"]
    @variables FM(t) [description = "Fertility Multiplier"]
    @variables GDPP(t) [description = "GDP per Person kDollar/p/y"]
    @variables PASS20(t) = inits[:PASS20] [description = "Passing 20 Mp/y"]
    @variables PASS40(t) = inits[:PASS40] [description = "Passing 40 Mp/y"]
    @variables PASS60(t) = inits[:PASS60] [description = "Passing 60 Mp/y"]
    @variables POP(t) [description = "Population Mp"]

    @variables GDP(t) [description = "GDP GDollar/y"]
    @variables IPP(t) [description = "Introduction period for policy y"]

    eqs = [
        CEFR ~ CMFR * GEFR
        DNC ~ ((DNCM + (DNC80 - DNCM) * exp(-DNCG * (EGDPP - inits[:EGDPP]))) * (1 + DNCA * (EGDPP - inits[:EGDPP]))) * (1 - EFR) * FM
        EFR ~ ramp(t, GEFR / IPP, 2022, 2022 + IPP)
        D(EGDPP) ~ (GDPP - EGDPP) / TAHI
        FM ~ IfElse.ifelse(SSP2FA2022F > 0, IfElse.ifelse(t > 2022, 1 + ramp(t, (MFM - 1) / 78, 2022, 2100), 1), 1)
        GDPP ~ GDP / POP
        POP ~ t  # A0020 + A2040 + A4060 + A60PL
        #
        GDP ~ interpolate(t, tables[:GDP], ranges[:GDP])
        IPP ~ interpolate(t, tables[:IPP], ranges[:IPP])
    ]

    return ODESystem(eqs; name=name)
end
