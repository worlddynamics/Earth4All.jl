_inits = Dict{Symbol,Float64}(
    :N2OA => 1.052,
    :CH4A => 2.5,
    :CO2A => 2600,
    :ISCEGA => 12,
    :PWA => 0.4,
    :EHS => 0,
)
#
_inits[:AL] = (_inits[:ISCEGA] * _params[:ALIS] + (_params[:GLSU] - _inits[:ISCEGA]) * _params[:ALGAV]) / _params[:GLSU]


getinitialisations() = copy(_inits)
