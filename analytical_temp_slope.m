% Lab 2
% ASEN 3802
% Kaitlyn Vigil
% 2/24/2026

%% Calculate H_an
% Define Function
function[H_an] = analytical_temp_slope(V,I,k,D)
    H_an = (V*I)/(k*(pi*D^2)/(4));
end
