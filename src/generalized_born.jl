###########################################################
# TWO-DIMENSIONAL GENERALIZED BORN MODEL                  #
###########################################################

module GeneralizedBornModel

using Random

export init_model

# Model starts at origin 0, 0
function init_model(radius::Float64, row_count::Int64, col_count::Int64)
    rows = collect(range(start=radius, stop=row_count * radius, step=radius))
    cols = collect(range(start=radius, stop=col_count * radius, step=radius))
    grid_matrix = [(row, col) for row in rows, col in cols]
    grid_vector = reshape(grid_matrix, row_count * col_count)
    [t[i] for t in grid_vector, i in 1:2]
end

end
