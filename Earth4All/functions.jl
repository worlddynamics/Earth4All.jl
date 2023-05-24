using IfElse
using PlotlyJS

"""
   `add_equation(eqs, equation)`

Adds `equation` to the list `eqs` of equations.
"""
function add_equation!(eqs, equation)
   append!(eqs, [equation])
end

"""
   `delay_n!(eqs, x, rt, lv, delay, order)`
   
Returns an N'th order exponential delay.
"""
function delay_n!(eqs, x, rt, lv, delay, order)
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
   `smooth!(eqs, x, input, delay_time)`

Returns a exponential smooth of the input.
"""
function smooth!(eqs, x, input, delay_time)
   append!(eqs, [D(x) ~ (input - x) / delay_time])
end

"""
   `clip(returnifgte, returniflt, inputvalue, threshold)`

Returns `returnifgte` if the value `inputvalue` is greater than the threshold `threshold`, `returniflt` otherwise. This function corresponds to the `CLIP` (also called `FIFGE`) function in the `DYNAMO` language.
"""
clip(returnifgte, returniflt, inputvalue, threshold) = IfElse.ifelse(inputvalue ≥ threshold, returnifgte, returniflt)

"""
   `step(inputvalue, returnifgte, threshold)`

Returns `0` if the value `inputvalue` is smaller than the threshold `threshold`, `returnifgte` otherwise. This function corresponds to the `STEP` function in the `DYNAMO` language.
"""
step(inputvalue, returnifgte, threshold) = clip(returnifgte, zero(returnifgte), inputvalue, threshold)


"""
   `pulse(inputvalue, start, width)`

Returns 1.0, starting at time start, and lasting for interval width; 0.0 is returned at all other times. If width is passed as 0 it will be treated as though it were the current value of TIME STEP. This function corresponds to the `PULSE` function in the `VENSIM` language.
"""
pulse(inputvalue, start, width) = IfElse.ifelse(inputvalue >= start, 1, 0) * IfElse.ifelse(inputvalue < (start + width), 1, 0)

interpolate(x, x₁, xₙ, y₁, yₙ) = y₁ + (x - x₁) * ((yₙ - y₁) / (xₙ - x₁))

"""
   `interpolate(x, yvalues, xrange)`

Returns the value of a function with input `x`, by linearly interpolating the function itself through the table `yvalues` and the range `xrange`. If `x` is out of the range, the value at the corresponding extremity is returned. This function corresponds to the `TABHL` function in the `DYNAMO` language. This latter function receives a table (that is, `yvalues`), a value (that is, `x`), a left and a right extreme of an interval (that is, `xrange`), and an increment value.
"""
function interpolate(x, yvalues::Tuple{Vararg{Float64}}, xrange::Tuple{Float64,Float64})
   interpolate(x, collect(yvalues), collect(LinRange(xrange[1], xrange[2], length(yvalues))))
end

function interpolate(x, yvalues::Vector{Float64}, xvalues::Vector{Float64})
   # y gets the min y value if less than the min x range
   #   or the max y value if greater than the max x range
   y = (x < xvalues[1]) * yvalues[1] + (x ≥ xvalues[end]) * yvalues[end]

   # in case x is inside the range, y gets the interpolated value
   for i ∈ 1:length(yvalues)-1
      y += (x ≥ xvalues[i]) * (x < xvalues[i+1]) * interpolate(x, xvalues[i], xvalues[i+1], yvalues[i], yvalues[i+1])
   end

   return y
end

function interpolate1(x, pairs::Vector{Tuple{Float64,Float64}})
   interpolate(x, map(t -> t[end], pairs), map(t -> t[1], pairs))
end

function withlookup(x, pairs::Vector{Tuple{Float64,Float64}})
   interpolate(x, map(t -> t[end], pairs), map(t -> t[1], pairs))
end

function print_endo_vars(sys)
   println("| Vensim name | Name | Initial value |")
   println("| --- | --- | --- |")
   for s in ModelingToolkit.get_states(sys)
      if (ModelingToolkit.getdescription(s) != "")
         try
            v = round(ModelingToolkit.getdefault(s), digits=4)
            println("| ", ModelingToolkit.getdescription(s), " | `", string(s), "` | ", v, " |")
         catch err
            println("| ", ModelingToolkit.getdescription(s), " | `", string(s), "` |  |")
         end
      end
   end
end

function print_ps(sys)
   println("| Vensim name | Name | Value | Sector |")
   println("| --- | --- | --- | --- |")
   for s in ModelingToolkit.get_ps(sys)
      println("| ", ModelingToolkit.getdescription(s), " | `", string(s), "` | ", round(ModelingToolkit.getdefault(s), digits=4), " | ", nameof(sys), " |")
   end
end

function print_exo_vars(sys)
   println("| Vensim name | Name | Initial value |")
   println("| --- | --- | --- |")
   for s in ModelingToolkit.get_states(sys)
      desc = ModelingToolkit.getdescription(s)
      if (desc != "")
         desc_split = split(desc, ".")
         println("| ", desc_split[2], " | `", string(s), "` | ", desc_split[1], " |")
      end
   end
end

function read_vensim_dataset(fn, to_be_removed)
   f::IOStream = open(fn, "r")
   ds = Dict{String,Array{Float64}}()
   for line in eachline(f)
      split_line::Vector{String} = split(line, "\t")
      s = replace(split_line[1], "\"" => "")
      s = replace(s, to_be_removed => "")
      s = replace(s, " (Year)" => "")
      s = replace(s, "\$" => "dollar")
      v::Array{Float64} = Array{Float64}(undef, length(split_line) - 1)
      for i in 2:lastindex(split_line)
         v[i-1] = parse(Float64, split_line[i])
      end
      ds[lowercase(s)] = v
   end
   close(f)
   return ds
end

function check_descriptions_vars(vs_ds, sys)
   nsv = ModelingToolkit.namespace_variables(sys)
   for v in nsv
      d = ModelingToolkit.getdescription(v)
      if (d != "" && !startswith(d, "LV functions") && !startswith(d, "RT functions"))
         if (get(vs_ds, lowercase(ModelingToolkit.getdescription(v)), "") == "")
            println(ModelingToolkit.getdescription(v))
         end
      end
   end
end

function check_descriptions_ps(vs_ds, sys)
   nsp = ModelingToolkit.namespace_parameters(sys)
   for p in nsp
      d = ModelingToolkit.getdescription(p)
      if (d != "")
         if (get(vs_ds, lowercase(d), "") == "")
            println(d)
         end
      end
   end
end

function compare(a, b, pepsi)
   max_re = -1
   max_re_a = 0
   max_re_b = 0
   max_re_i = 0
   for i in 1:lastindex(a)
      # re = abs(a[i] - b[i]) / (abs(b[i]) + pepsi)
      re = 0
      if (a[i] != 0 || b[i] != 0)
         re = (2 * abs(a[i] - b[i])) / (abs(a[i]) + abs(b[i]))
      end
      if (re > max_re)
         max_re = max(max_re, re)
         max_re_a = a[i]
         max_re_b = b[i]
         max_re_i = i
      end
   end
   return max_re, max_re_a, max_re_b, max_re_i
end

function mre_sys(sol, sys, vs_ds, pepsi, nt, verbose, do_plot)
   nsv = ModelingToolkit.namespace_variables(sys)
   max_re = 0.0
   for v in nsv
      d = ModelingToolkit.getdescription(v)
      if (d != "" && d != "Time instants" && !startswith(d, "LV functions") && !startswith(d, "RT functions"))
         re, _, _, _ = Earth4All.compare(sol[v][1:nt], vs_ds[lowercase(d)], pepsi)
         max_re = max(max_re, re)
         if (verbose)
            println(d, " ", re, " (", max_re, ")")
         end
         if (do_plot)
            savefig(compare_and_plot(sol, d, v, vs_ds, 1980, 2100, nt, pepsi, true), "../figures/" * string(v) * ".png")
         end
      end
   end
   return max_re
end

function check_solution(sol, pepsi, nt, verbose, do_plot)
   sector_name = ["climate", "demand", "energy", "finance", "foodland", "inventory", "labourmarket", "other", "output", "population", "public", "wellbeing"]
   sector_system = system_array()
   max_re = 0.0
   for s in 1:lastindex(sector_name)
      println("=========" * uppercase(sector_name[s]) * "=======")
      vs_ds = Earth4All.read_vensim_dataset("../VensimOutput/tltl/" * sector_name[s] * ".txt")
      re = Earth4All.mre_sys(sol, sector_system[s], vs_ds, pepsi, nt, verbose, do_plot)
      println(re)
      max_re = max(max_re, re)
   end
   println("=========MAXIMUM RE=======")
   println(max_re)
   return max_re
end

function system_array()
   r = []
   @named cli = Earth4All.Climate.climate()
   @named dem = Earth4All.Demand.demand()
   @named ene = Earth4All.Energy.energy()
   @named fin = Earth4All.Finance.finance()
   @named foo = Earth4All.FoodLand.foodland()
   @named inv = Earth4All.Inventory.inventory()
   @named lab = Earth4All.LabourMarket.labour_market()
   @named oth = Earth4All.Other.other()
   @named out = Earth4All.Output.output()
   @named pop = Earth4All.Population.population()
   @named pub = Earth4All.Public.public()
   @named wel = Earth4All.Wellbeing.wellbeing()
   append!(r, [cli, dem, ene, fin, foo, inv, lab, oth, out, pop, pub, wel])
   return r
end

function compare_and_plot(sol, desc, fy, ly, nt, pepsi)
   sector_name = ["climate", "demand", "energy", "finance", "foodland", "inventory", "labourmarket", "other", "output", "population", "public", "wellbeing"]
   sector_system = system_array()
   for s in 1:lastindex(sector_name)
      println("=========" * uppercase(sector_name[s]) * "=======")
      vs_ds = Earth4All.read_vensim_dataset("../VensimOutput/tltl/" * sector_name[s] * ".txt")
      isv, v = is_system_var(desc, sector_system[s])
      if (isv)
         return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi, true)
      end
   end
end

function is_system_var(desc, sys)
   nsv = ModelingToolkit.namespace_variables(sys)
   for v in nsv
      d = ModelingToolkit.getdescription(v)
      if (d != "" && d != "Time instants" && !startswith(d, "LV functions") && !startswith(d, "RT functions"))
         if (lowercase(d) == lowercase(desc))
            return true, v
         end
      end
   end
   return false, nothing
end

function compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi, do_plot)
   r = compare(sol[v][1:nt], vs_ds[lowercase(desc)], pepsi)
   println(r, " at t=", sol.t[r[4]])
   if (do_plot)
      x = range(fy, ly, length=nt)
      trace1 = scatter(x=x, y=sol[v], name="WorldDynamics", line=attr(color="royalblue", dash="dash"))
      trace2 = scatter(x=x, y=vs_ds[lowercase(desc)], name="Vensim", line=attr(color="firebrick", dash="dot"))
      return plot([trace1, trace2], Layout(title=desc))
   end
end
