% Lab 2
% ASEN 3802
% Kaitlyn Vigil
% 2/24/2026

clc; clear; close all;

%% Calculate H_an
% Define Function
function[H_an] = analytical_temp_slope(V,I,k,D)
    H_an = (V*I)/(k*(pi*D^2)/(4));
end

% Define Varibles [Al1, Al2, Brass1, Brass2, SS_T303]
V = [25,30,25,30,22]; % [V]
I = [240,290,237,285,203]*10^-3; % [A]
k = [130, 130, 115, 115, 16.2]; % [W/(mC)]
D = ones(1,5)*0.0254; % [m]

% Call Function
for i = 1:length(D)
    H_an(i) = analytical_temp_slope(V(i), I(i), k(i), D(i)); % [C/m]
end
