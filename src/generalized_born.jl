###########################################################
# TWO-DIMENSIONAL GENERALIZED BORN MODEL                  #
###########################################################

module GeneralizedBornModel

using Random

export init_model

# Model starts at origin 0, 0
function init_model(max_x, max_y, max_radius, num)
    rs = max_radius .* rand(num)
    xs = max_x .* rand(num)
    ys = max_y .* rand(num)
    Dict(:rs => rs, :xs => xs, :ys => ys)
end

end
