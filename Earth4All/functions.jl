using IfElse

"""
   `ramp(x, slope, startx, endx)`

Returns `0` until the `startx` and then slopes upward until `endx` and then holds constant. This function corresponds to the `RAMP` function in the `VENSIM` language.
"""
ramp(x, slope, startx, endx) = IfElse.ifelse(x > startx, IfElse.ifelse(x < endx, slope * (x - startx), slope * (endx - startx)), 0)
