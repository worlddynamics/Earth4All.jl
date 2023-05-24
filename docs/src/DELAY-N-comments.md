# Delay N comments
## Summary
The implementation of the function `DELAY N` with variable delay is more complicated than expected. In this memorandum, we will try to explain the main problems that we still have to solve in order to get the correct implementation of `DELAY N` of order 1 and 3.

## First order delay
The following is the definition of `DELAY1` given in the `Vensim` documentation, which hopefully should give us some hints on how to implement `DELAY N` of first order with variable delay.

```jl
    DELAY1=LV/delay
    LV=INTEG(input-DELAY1,input*delay)
```
### Two implementations
Assuming that $\mathtt{input}(t) = t$ (that is, a straight line) and that $\mathtt{delay}(t) = \sqrt{1+\mathtt{input}(t)}$ (in order to have a positive relatively small varying delay), we can implement this function through an ODE system in two different ways.

1. We translate the above two equations by substituting the `DELAY1` expression into the last ODE. We thus obtain the following set of equations.
```jl
    D(input) ~ 1
    delay ~ sqrt(1+input)
    DELAY1 ~ LV/delay
    D(LV) ~ input-LV/delay
```
We call this approach the *LV approach* since it consists in specifying the derivative of `LV` and deriving the value of `DELAY1` from the value of `LV`.

2. We translate the above two equations by specifying the derivative of `DELAY1` and by using the derivative of `LV` *and* of `delay time`. Indeed, we have that
```math
\begin{align*}
D(\mathtt{DELAY1}) & = D(\mathtt{LV}/\mathtt{delay})\\
& = \frac{1}{\mathtt{delay}^2}(D(\mathtt{LV})\cdot\mathtt{delay}-\mathtt{LV}\cdot D(\mathtt{delay}))\\
& = \frac{1}{\mathtt{delay}^2}((\mathtt{input}-\mathtt{DELAY1})\cdot\mathtt{delay}-\mathtt{LV}\cdot D(\mathtt{delay}))\\
& = \frac{1}{\mathtt{delay}^2}((\mathtt{input}-\mathtt{DELAY1})\cdot\mathtt{delay}-(\mathtt{delay}\cdot\mathtt{DELAY1})D(\mathtt{delay}))\\
& = \frac{1}{\mathtt{delay}}(\mathtt{input}-\mathtt{DELAY1}-\mathtt{DELAY1}\cdot D(\mathtt{delay}))\\
& = \frac{1}{\mathtt{delay}}(\mathtt{input}-\mathtt{DELAY1}(1+D(\mathtt{delay})))
\end{align*}
```
We thus obtain the following set of equations (note that we have only three equations but the derivative of the delay is present in the right-hand side of the third equation).
```jl
    D(input) ~ 1
    delay ~ sqrt(1+input)
    D(DELAY1) ~ (1/delay)*(input-DELAY1*(1+D(delay)))
```


We call this approach the *RT approach* since, as we will see in the case of order $3$, it consists in specifying the derivative of two variables `RT1` and `RT2` and the derivative of `DELAY1` (in the case of order $1$ we have only this latter variable).

### Different results
The two above approaches are not equivalent. Indeed, by using the Euler method with time step equal to $0.25$ and with a time span equal to $(0,100)$, the value of `DELAY1` in the solution obtained with the LV approach is always a little bit smaller than the value of `DELAY1` in the solution obtained with the RT approach. This difference increases until the $18$-th step (when it is approximately equal to $0.026$) and then decreases and reaches the value $0.008820625$. Moreover, the value of `DELAY1` in the solution obtained with the RT approach is closer to the value of `DELAY1` given by using the function `DELAY N` of order $1$ in `Vensim`, while the value of `DELAY1` in the solution obtained with the LV approach is almost exactly equal to the value of `DELAY1` given by using the function `DELAY1` in `Vensim`. This suggests that the RT approach is closer to the correct implementation of the function `DELAY N` of order $1$ with variable delay.

## Third order delay
The following is the definition of `DELAY3` given in the `Vensim` documentation.
```jl
    DELAY3=LV3/DL
    LV3=INTEG(RT2-DELAY3,DL*input)
    RT2=LV2/DL
    LV2=INTEG(RT1-RT2,LV3)
    RT1=LV1/DL
    LV1=INTEG(input-RT1,LV3)
    DL=delay/3
```

By following the two previously described approaches, we obtain the following two sets of equations, respectively.

1. LV approach.
```jl
    D(input) ~ 1
    delay ~ sqrt(1+input)
    DELAY3 ~ (3/delay)*LV3
    D(LV3) ~ (3*LV2/delay)-DELAY3
    D(LV2) ~ (3*LV1/delay)-(3*LV2/delay)
    D(LV1) ~ input-3*LV1/delay
```
2. RT approach.
```jl
    D(input) ~ 1
    delay ~ sqrt(1+input)
    D(DELAY3) ~ (3/delay)*(RT2-DELAY3*(1+D(delay)/3))
    D(RT2) ~ (3/delay)*(RT1-RT2*(1+D(delay)/3))
    D(RT1) ~ (3/delay)*(input-RT1*(1+D(delay)/3))
```

Once again, the two above approaches are not equivalent. However, the value of `DELAY1` in the solution obtained with the RT approach is less close to the value of `DELAY1` given by using the function `DELAY N` of order $3$ in `Vensim`, while the value of `DELAY1` in the solution obtained with the LV approach is almost exactly equal to the value of `DELAY1` given by using the function `DELAY3` in `Vensim`. This suggests that the two approaches are still not the correct implementation of the function `DELAY N` of order $3$ with variable delay.

## Final observation

Both approaches seem to generates errors when applied to the `Earth4All` model. It might be that this is due to some programming error, but we suspect that it is due to the fact that we are using the derivative of the delay in the right hand side of several ODEs.
