###########################################################
# TWO-DIMENSIONAL GENERALIZED BORN MODEL                  #
###########################################################

module GeneralizedBornModel

using Random

export init_model

# Model starts at origin 0, 0
function init_model(radius::Float64, spacing::Float64, size_x::Float64, size_y::Float64)
    rows = collect(range(start=radius, stop=size_y, step=size_y / spacing))
    cols = collect(range(start=radius, stop=size_x, step=size_x / spacing))
    grid_matrix = [(row, col) for row in rows, col in cols]
    grid_vector = reshape(grid_matrix, length(rows) * length(cols))
    [t[i] for t in grid_vector, i in 1:2]
end

end
