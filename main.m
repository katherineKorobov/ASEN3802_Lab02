clc; clear; close all;

files = { ...
    "Aluminum_25V_240mA"
    "Aluminum_30V_290mA"
    "Brass_25V_237mA"
    "Brass_30V_285mA"
    "Steel_22V_203mA"
};

% Create structs to hold data
for i = 1:length(files)
    material(i) = struct("data", readmatrix("data\" + files{i}), ...
                         "t0", 0,"Hexp", 0,"Han", 0 );
end

material_names = ["Aluminum - 25V", "Aluminum - 30V", ...
             "Brass - 25V", "Brass - 30V", "Stainless Steel - 22V"];
x = linspace(0.0762, 0.1651, 8);

voltage = [25,30,25,30,22]; % [V]
current = [240,290,237,285,203]*10^-3; % [A]
k = [130, 130, 115, 115, 16.2]; % [W/(mC)]
D = ones(1,5)*0.0254; % [m]

%% Find Steady State Parameters

for i = 1:length(material)
    material(i).t0 = findT0(material(i).data);
    material(i).Hexp = calculateHexp(material(i).data);
    material(i).Han = analytical_temp_slope(voltage(i), current(i), k(i), D(i)); % [C/m]
end


figure();
% Plot experimental and for actual
for i = 1:length(material)
    plotSteadyState(material_names(i), x, material(i), i)

end

