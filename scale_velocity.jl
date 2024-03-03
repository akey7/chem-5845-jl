using Plots
using Distributions

kb = 1.380649e-23
kg_per_amu = 1.661e-27

function scale(temp_k, mass_amu)
    sqrt(2*kb*temp_k/mass_amu/kg_per_amu)
end

function maxwell_pdf(velocities, temp_k, mass_amu)
    sigma = scale(temp_k, mass_amu)

    function pdf(v)
        sqrt(2/π)*(v^2*exp(-v^2/(2*sigma^2))) / sigma^3
    end

    pdf.(velocities)
end

function maxwell_rvs(temp_k, mass_amu, size)
    sigma = scale(temp_k, mass_amu)
    dist = sigma * Chi(3)
    rand(dist, size)
end

velocities = collect(range(0, 2000, 100))
ys = maxwell_pdf(velocities, 300.0, 32.0)
rvs = maxwell_rvs(300.0, 32.0, 1000000)
histogram(rvs, bins=100, normalize=true, alpha=0.5, color=:orange, label="Random Values")
pdf_plot = plot!(velocities, ys, title="Maxwell-Boltzmann Distribution", xlabel="v (m/s)", ylabel="P(v)", linewidth=3, color=:blue, label="PDF")
display(pdf_plot)
readline()
