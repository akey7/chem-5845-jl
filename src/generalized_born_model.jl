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
    xs = [t[i] for t in grid_vector, i in 1:2]
    rs = radius .+ zeros(Float64, length(xs[:, 1]))

    Dict(:xs => xs, :rs => rs)
end

# # Calculate ΔG of solvation, assuming no overlap between spheres
# function delta_g_solv(model::Dict, epsilon::Float64)
#     xs = model[:xs]
#     rs 
#     n = length(xs[:, 1])
    
#     a = -0.5 * (1 - 1/epsilon)
#     b = 0

#     for i ∈ 1:n-1
#         for j ∈ i+1:n
            
#         end
#     end

#     c = sum()
# end

end
