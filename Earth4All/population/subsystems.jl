include("../functions.jl")
@register ramp(x, slope, startx, endx)

@variables t
D = Differential(t)

function population(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    ORDER = 10
    @parameters CMFR = params[:CMFR] [description = "Cost of Max Fertility Reduction (share of GDP)"]
    @parameters DNC80 = params[:DNC80] [description = "DNC in 1980"]
    @parameters DNCA = params[:DNCA] [description = "DNCalfa<0"]
    @parameters DNCG = params[:DNCG] [description = "DNCgamma"]
    @parameters DNCM = params[:DNCM] [description = "DNCmin"]
    @parameters EIP = params[:EIP] [description = "Exogenous Introduction Period y"]
    @parameters EIPF = params[:EIPF] [description = "Exogenous Introduction Period Flag"]
    @parameters FADFS = params[:FADFS] [description = "Fraction Achieving Desired Family Size"]
    @parameters FP = params[:FP] [description = "Fertile Period"]
    @parameters FW = params[:FW] [description = "Fraction Women"]
    @parameters GEFR = params[:GEFR] [description = "Goal for Extra Fertility Reduction"]
    @parameters GEPA = params[:GEPA] [description = "Goal for Extra Pension Age y"]
    @parameters LEA = params[:LEA] [description = "LEalfa"]
    @parameters LEEPA = params[:LEEPA] [description = "sLEeoPa>0: Life Expectancy Effect on Pension Age"]
    @parameters LEG = params[:LEG] [description = "LEgamma"]
    @parameters LEMAX = params[:LEMAX] [description = "LEmax"]
    @parameters MFM = params[:MFM] [description = "Max Fertility Multiplier"]
    @parameters MLEM = params[:MLEM] [description = "Max Life Expectancy Multiplier"]
    # @parameters ORDER = params[:ORDER] [description = "Order of delay functions"]
    @parameters OW2022 = params[:OW2022] [description = "Observed Warming in 2022 deg C"]
    @parameters OWELE = params[:OWELE] [description = "sOWeoLE<0: Observed Warming Effect on Life Expectancy"]
    @parameters SSP2FA2022F = params[:SSP2FA2022F] [description = "SSP2 Family Action from 2022 Flag"]
    @parameters TAHI = params[:TAHI] [description = "Time to adapt to higher income y"]

    @variables A0020(t) = inits[:A0020] [description = "Aged 0-20 years Mp"]
    @variables A2040(t) = inits[:A2040] [description = "Aged 20-40 years Mp"]
    @variables A20PA(t) [description = "Aged 20-Pension Age Mp"]
    @variables A4060(t) = inits[:A4060] [description = "Aged 40-60 years Mp"]
    @variables A60PL(t) = inits[:A60PL] [description = "Aged 60+ in 1980 Mp"]
    @variables BIRTHR(t) [description = "Birth Rate 1/y"]
    @variables BIRTHS(t) [description = "Births Mp/y"]
    @variables CEFR(t) [description = "Cost of Extra Fertility Reduction (share of GDP)"]
    @variables DEATHR(t) [description = "Death Rate 1/y"]
    @variables DEATHS(t) [description = "Deaths Mp/y"]
    @variables DNC(t) [description = "Desired No of Children"]
    @variables DR(t) [description = "Dependency Ratio p/p"]
    @variables EFR(t) [description = "Extra Fertility Reduction"]
    @variables EGDPP(t) = inits[:EGDPP] [description = "Effective GDP per Person kDollar/p/y"]
    @variables EPA(t) = inits[:EPA] [description = "Extra Pension Age y"]
    @variables FM(t) [description = "Fertility Multiplier"]
    @variables GDPP(t) [description = "GDP per Person kDollar/p/y"]
    @variables LE(t) = inits[:LE] [description = "Life Expectancy y"]
    @variables LE60(t) [description = "LE at 60 y"]
    @variables LEM(t) [description = "Life Expectancy Multiplier"]
    @variables (LV_DEATHS(t))[1:ORDER] = fill(inits[:DEATHS], ORDER) [description = "LV functions for deaths Mp/y"]
    @variables (LV_PASS20(t))[1:ORDER] = fill(inits[:PASS20], ORDER) [description = "LV functions for passing 20 Mp/y"]
    @variables (LV_PASS40(t))[1:ORDER] = fill(inits[:PASS40], ORDER) [description = "LV functions for passing 40 Mp/y"]
    @variables (LV_PASS60(t))[1:ORDER] = fill(inits[:PASS60], ORDER) [description = "LV functions for passing 60 Mp/y"]
    @variables OF(t) [description = "Observed Fertility"]
    @variables OP(t) [description = "On Pension Mp"]
    @variables PA(t) = inits[:PA] [description = "Pension Age y"]
    @variables PASS20(t) [description = "Passing 20 Mp/y"]
    @variables PASS40(t) = inits[:PASS40] [description = "Passing 40 Mp/y"]
    @variables PASS60(t) = inits[:PASS60] [description = "Passing 60 Mp/y"]
    @variables PGR(t) [description = "Population Growth Rate Mp"]
    @variables POP(t) [description = "Population Mp"]
    @variables PW(t) [description = "Pensioners per Worker p/p"]
    @variables (RT_DEATHS(t))[1:ORDER] = fill(inits[:DEATHS], ORDER) [description = "RT functions for deaths Mp/y"]
    @variables (RT_PASS20(t))[1:ORDER] = fill(inits[:PASS20], ORDER) [description = "RT functions for passing 20 Mp/y"]
    @variables (RT_PASS40(t))[1:ORDER] = fill(inits[:PASS40], ORDER) [description = "RT functions for passing 40 Mp/y"]
    @variables (RT_PASS60(t))[1:ORDER] = fill(inits[:PASS60], ORDER) [description = "RT functions for passing 60 Mp/y"]
    @variables WELE(t) [description = "Warming Effect on Life Expectancy"]

    @variables GDP(t)
    @variables IPP(t)
    @variables OW(t)

    eqs = [
        D(A0020) ~ BIRTHS - PASS20
        D(A2040) ~ PASS20 - PASS40
        A20PA ~ A2040 + A4060 + A60PL - OP
        D(A4060) ~ PASS40 - PASS60
        D(A60PL) ~ PASS60 - DEATHS
        BIRTHR ~ BIRTHS / POP
        BIRTHS ~ A2040 * FW * (OF / FP)
        CEFR ~ CMFR * GEFR
        DEATHR ~ DEATHS / POP
        DEATHS ~ RT_DEATHS[ORDER]
        DNC ~ ((DNCM + (DNC80 - DNCM) * exp(-DNCG * (EGDPP - inits[:EGDPP]))) * (1 + DNCA * (EGDPP - inits[:EGDPP]))) * (1 - EFR) * FM
        DR ~ (A0020 + A60PL) / (A2040 + A4060)
        EFR ~ ramp(t, GEFR / IPP, 2022, 2022 + IPP)
        EPA ~ ramp(t, (GEPA - inits[:EPA]) / IPP, 2022, 2022 + IPP)
        D(EGDPP) ~ (GDPP - EGDPP) / TAHI
        FM ~ IfElse.ifelse(SSP2FA2022F > 0, IfElse.ifelse(t > 2022, 1 + ramp(t, (MFM - 1) / 78, 2022, 2100), 1), 1)
        GDPP ~ GDP / POP
        LE ~ ((LEMAX - (LEMAX - inits[:LE]) * exp(-LEG * (EGDPP - inits[:EGDPP]))) * (1 + LEA * (EGDPP - inits[:EGDPP]))) * WELE * LEM
        LE60 ~ LE - 60
        LEM ~ IfElse.ifelse(SSP2FA2022F > 0, IfElse.ifelse(t > 2022, 1 + ramp(t, (MLEM - 1) / 78, 2022, 2100), 1), 1)
        OF ~ DNC * FADFS
        OP ~ A60PL * (LE - PA) / (LE - 60)
        PA ~ IfElse.ifelse(LE < inits[:LE], inits[:PA], inits[:PA] + LEEPA * (LE + EPA - inits[:LE]))
        PASS20 ~ RT_PASS20[ORDER]
        PASS40 ~ RT_PASS40[ORDER]
        PASS60 ~ RT_PASS60[ORDER]
        PGR ~ BIRTHR - DEATHR
        POP ~ A0020 + A2040 + A4060 + A60PL
        PW ~ OP / A20PA
        WELE ~ IfElse.ifelse(t > 2022, max(0, 1 + OWELE * (OW / OW2022 - 1)), 1)
    ]
    delay_n(eqs, D, BIRTHS, RT_PASS20, LV_PASS20, 20, ORDER)
    delay_n(eqs, D, PASS20, RT_PASS40, LV_PASS40, 20, ORDER)
    delay_n(eqs, D, PASS40, RT_PASS60, LV_PASS60, 20, ORDER)
    delay_n(eqs, D, PASS60, RT_DEATHS, LV_DEATHS, LE60, ORDER)

    return ODESystem(eqs; name=name)
end

function population_support(; name, params=_params, inits=_inits, tables=_tables, ranges=_ranges)
    @variables GDP(t) [description = "GDP GDollar/y"]
    @variables IPP(t) [description = "Introduction period for policy y"]
    @variables OW(t) [description = "Observed warming deg C"]

    eqs = [
        GDP ~ interpolate(t, tables[:GDP], ranges[:GDP])
        IPP ~ interpolate(t, tables[:IPP], ranges[:IPP])
        OW ~ interpolate(t, tables[:OW], ranges[:OW])
    ]

    return ODESystem(eqs; name=name)
end
