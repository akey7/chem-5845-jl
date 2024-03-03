using Plots
using Distributions

kb = 1.380649e-23
kg_per_amu = 1.661e-27

function scale(temp_k, mass_amu)
    sqrt(2*kb*temp_k/mass_amu/kg_per_amu)
end

function maxwell_boltzmann_pdf(velocities, temp_k, mass_amu)
    sigma = scale(temp_k, mass_amu)

    function pdf(v)
        sqrt(2/π)*(v^2*exp(-v^2/(2*sigma^2))) / sigma^3
    end

    pdf.(velocities)
end

velcoities = collect(range(0, 2000, 100))
ys = maxwell_boltzmann_pdf(velcoities, 300.0, 32.0)
pdf_plot = plot(velcoities, ys, title="Maxwell-Boltzmann Distribution", xlabel="v (m/s)", ylabel="P(v)", linewidth=2, color="red")
display(pdf_plot)
readline()
