using IfElse

function delay_n(eqs, D, x, rt, lv, delay, order)
   append!(eqs, [rt[1] ~ lv[1] / (delay / order)])
   append!(eqs, [D(lv[1]) ~ x - rt[1]])
   for d in 2:order
      append!(eqs, [rt[d] ~ lv[d] / (delay / order)])
      append!(eqs, [D(lv[d]) ~ rt[d-1] - rt[d]])
   end
end

"""
   `ramp(x, slope, startx, endx)`

Returns `0` until the `startx` and then slopes upward until `endx` and then holds constant. This function corresponds to the `RAMP` function in the `VENSIM` language.
"""
ramp(x, slope, startx, endx) = IfElse.ifelse(x > startx, IfElse.ifelse(x < endx, slope * (x - startx), slope * (endx - startx)), 0)

"""
   smoothi!(eqs, x, input, delay_time)
   Returns a exponential smooth of the input.
"""
function smoothi!(eqs, x, input, delay_time)
   append!(eqs, [D(x) ~ (input - x) / delay_time])
end