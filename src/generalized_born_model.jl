###########################################################
# TWO-DIMENSIONAL GENERALIZED BORN MODEL                  #
###########################################################

module GeneralizedBornModel

using Random

export init_model

# Initialize the model
function init_model(radius::Float64, row_and_col_count::Int, size_x::Float64, size_y::Float64)
    rows = collect(range(start=radius, stop=size_y, step=size_y / row_and_col_count))
    cols = collect(range(start=radius, stop=size_x, step=size_x / row_and_col_count))
    grid_matrix_1 = [(row, col) for row ∈ rows, col ∈ cols]
    grid_vector = reshape(grid_matrix_1, length(rows) * length(cols))
    grid_matrix_2 = [t[i] for t in grid_vector, i in 1:2]

    Dict(:xs => grid_matrix_2, :r => radius)
end

function delta_g_solv(model)
    grid = model[:xs]
    pairs = [(i, j) for i ∈ eachindex(grid[:, 1]), j ∈ eachindex(grid[:, 1])]
end

end
