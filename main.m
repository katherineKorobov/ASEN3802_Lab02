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

%% Find Steady State Parameters

x = linspace(1.375, )

for i = 1:length(material)
    material(i).t0 = findT0(material(i).data);
    material(i).Hexp = calculateHexp(material(i).data, material(i).t0);
end






