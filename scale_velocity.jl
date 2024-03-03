using Plots
using Distributions

kb = 1.380649e-23
kg_per_amu = 1.661e-27

function scale(temp_k, mass_amu)
    sqrt(2*kb*temp_k/mass_amu/kg_per_amu)
end

function maxwell_boltzmann_pdf(vs, temp_k, mass_amu)
    
end
