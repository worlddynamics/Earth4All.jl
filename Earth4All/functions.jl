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
   println("| Stella name | Name | Initial value |")
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
   println("| Stella name | Name | Value |")
   println("| --- | --- | --- |")
   for s in ModelingToolkit.get_ps(sys)
      println("| ", ModelingToolkit.getdescription(s), " | `", string(s), "` | ", round(ModelingToolkit.getdefault(s), digits=4), " |")
   end
end

function print_exo_vars(sys)
   println("| Stella name | Name | Initial value |")
   println("| --- | --- | --- |")
   for s in ModelingToolkit.get_states(sys)
      desc = ModelingToolkit.getdescription(s)
      if (desc != "")
         desc_split = split(desc, ".")
         println("| ", desc_split[2], " | `", string(s), "` | ", desc_split[1], " |")
      end
   end
end

function read_vensim_dataset(fn)
   f::IOStream = open(fn, "r")
   ds = Dict{String,Array{Float64}}()
   for line in eachline(f)
      split_line::Vector{String} = split(line, "\t")
      s = replace(split_line[1], "\"" => "")
      s = replace(s, " : E4A-220501 GL" => "")
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

function check_descriptions(vs_ds, sys)
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

function compare(a, b, pepsi)
   max_re = 0
   max_re_a = 0
   max_re_b = 0
   max_re_i = 0
   for i in 1:lastindex(a)
      re = abs(a[i] - b[i]) / (abs(b[i]) + pepsi)
      if (re > max_re)
         max_re = max(max_re, re)
         max_re_a = a[i]
         max_re_b = b[i]
         max_re_i = i
      end
   end
   return max_re, max_re_a, max_re_b, max_re_i
end

function mre_sys(sol, sys, vs_ds, pepsi, nt, verbose)
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
      end
   end
   return max_re
end

function check_model()
   println("=========COMPUTING SOLUTION=======")
   e4a_sol = Earth4All.e4a_run_solution()
   println("=========SOLUTION COMPUTED=======")
   vs_ds_cli = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/climate.txt")
   @named cli = Earth4All.Climate.climate()
   println("=========CLIMATE=======")
   Earth4All.check_descriptions(vs_ds_cli, cli)
   max_re = Earth4All.mre_sys(e4a_sol, cli, vs_ds_cli, 0.1, true)
   println("Maximum relative error: ", max_re)
   vs_ds_ene = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/energy.txt")
   @named ene = Earth4All.Energy.energy()
   println("=========ENERGY=======")
   Earth4All.check_descriptions(vs_ds_ene, ene)
   vs_ds_fin = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/finance.txt")
   @named fin = Earth4All.Finance.finance()
   println("=========FINANCE=======")
   Earth4All.check_descriptions(vs_ds_fin, fin)
   vs_ds_fl = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/foodland.txt")
   @named fl = Earth4All.FoodLand.foodland()
   println("=========FOOD AND LAND=======")
   Earth4All.check_descriptions(vs_ds_fl, fl)
   vs_ds_inv = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/inventory.txt")
   @named inv = Earth4All.Inventory.inventory()
   println("=========INVENTORY=======")
   Earth4All.check_descriptions(vs_ds_inv, inv)
   vs_ds_oth = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/other.txt")
   @named oth = Earth4All.Other.other()
   println("=========OTHER=======")
   Earth4All.check_descriptions(vs_ds_oth, oth)
   vs_ds_pop = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/population.txt")
   @named pop = Earth4All.Population.population()
   println("=========POPULATION=======")
   Earth4All.check_descriptions(vs_ds_pop, pop)
   vs_ds_pub = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/public.txt")
   @named pub = Earth4All.Public.public()
   println("=========PUBLIC=======")
   Earth4All.check_descriptions(vs_ds_pub, pub)
   vs_ds_wb = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/wellbeing.txt")
   @named wb = Earth4All.Wellbeing.wellbeing()
   println("=========WELLBEING=======")
   Earth4All.check_descriptions(vs_ds_wb, wb)
end

function compare_and_plot(sol, desc, fy, ly, nt, pepsi)
   println("=========CLIMATE=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/climate.txt")
   @named cli = Earth4All.Climate.climate()
   isv, v = is_system_var(desc, cli)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========DEMAND=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/demand.txt")
   @named dem = Earth4All.Demand.demand()
   isv, v = is_system_var(desc, dem)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========ENERGY=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/energy.txt")
   @named ene = Earth4All.Energy.energy()
   isv, v = is_system_var(desc, ene)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========FINANCE=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/finance.txt")
   @named fin = Earth4All.Finance.finance()
   isv, v = is_system_var(desc, fin)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========FOOD AND LAND=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/foodland.txt")
   @named foo = Earth4All.FoodLand.foodland()
   isv, v = is_system_var(desc, foo)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========INVENTORY=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/inventory.txt")
   @named inv = Earth4All.Inventory.inventory()
   isv, v = is_system_var(desc, inv)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========LABOUR MARKET=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/labourmarket.txt")
   @named lab = Earth4All.LabourMarket.labour_market()
   isv, v = is_system_var(desc, lab)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========OTHER=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/other.txt")
   @named oth = Earth4All.Other.other()
   isv, v = is_system_var(desc, oth)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========OUTPUT=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/output.txt")
   @named lab = Earth4All.Output.output()
   isv, v = is_system_var(desc, lab)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========POPULATION=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/population.txt")
   @named pop = Earth4All.Population.population()
   isv, v = is_system_var(desc, pop)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========PUBLIC=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/public.txt")
   @named pub = Earth4All.Public.public()
   isv, v = is_system_var(desc, pub)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   end
   println("=========WELLBEING=======")
   vs_ds = Earth4All.read_vensim_dataset("/Users/piluc/Desktop/E4AStella/vensim_output/wellbeing.txt")
   @named wel = Earth4All.Wellbeing.wellbeing()
   isv, v = is_system_var(desc, wel)
   if (isv)
      return compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
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

function compare_and_plot(sol, desc, v, vs_ds, fy, ly, nt, pepsi)
   println(compare(sol[v][1:nt], vs_ds[lowercase(desc)], pepsi))
   x = range(fy, ly, length=nt)
   trace1 = scatter(x=x, y=sol[v], mode="lines", name="WorldDynamics")
   trace2 = scatter(x=x, y=vs_ds[lowercase(desc)], mode="lines", name="Vensim")
   return plot([trace1, trace2], Layout(title=desc))
end
