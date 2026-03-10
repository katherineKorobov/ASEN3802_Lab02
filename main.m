clc; clear; close all;

files = { ...
    "Aluminum_25V_240mA"
    "Aluminum_30V_290mA"
    "Brass_25V_237mA"
    "Brass_30V_285mA"
    "Steel_22V_203mA"
};

voltage = [25,30,25,30,22]; % [V]
current = [240,290,237,285,203]*10^-3; % [A]
k = [130, 130, 115, 115, 16.2]; % [W/(mC)]
density = [2810, 2810, 8500, 8500, 8000];
c_p = [960, 960, 380, 380, 500];


% Create structs to hold data
for i = 1:length(files)
    material(i) = struct("data", readmatrix("data\" + files{i}), ...
                         "Voltage", voltage(i), "Current", current(i), ...
                         "k", k(i), "alpha", k(i)/(density(i)*c_p(i)) ,"t0", 0,"Hexp", 0,"Han", 0 );
end

material_names = ["Aluminum - 25V", "Aluminum - 30V", ...
             "Brass - 25V", "Brass - 30V", "Stainless Steel - 22V"];
x = linspace(0.0762, 0.1651, 8);
D = ones(1,5)*0.0254; % [m]

%% Find Steady State Parameters
for i = 1:length(material)
    material(i).t0 = findT0(material(i).data);
    material(i).Hexp = calculateHexp(material(i).data);
    material(i).Han = analytical_temp_slope(voltage(i), current(i), k(i), D(i)); % [C/m]
end

%% Plotting 
plotSteadyState = 0;
plotTransientModel_1A = 1;
plotTransientModel_1B = 1;
plotTransientModel_2 = 1;

if plotSteadyState
    figure();
    for i = 1:length(material)
        plotSteadyState(material_names(i), x, material(i), i) % Plot experimental and actual
    end
end

n = linspace(1,10, 10);
L = 0.149225; % [m] 5.875 in
lambda = ((2 .* n -1)*pi) ./ (2*L);

if plotTransientModel_1A
    
    model_name = "Model 1A";
    for i = 1:length(material)
        
        figure();
        hold on;

        H_an = material(i).Han;
        T_0 = material(i).t0;
        alpha = material(i).alpha;
        b_n = ((8*H_an*L) ./ ((2 .* n - 1).^2 .* pi^2)) .* (-1).^n; 
   
        u1_analytical = @(x,t) T_0 + H_an*x + sum(b_n .* sin(lambda .* x) .* exp(-(lambda.^2) .* alpha .* t));
        
        plotTransientTemperatureSolution(x, u1_analytical, material(i).data, material_names(i), model_name);
        hold off;

    end

end

if plotTransientModel_1B
    model_name = "Model 1B";
    for i = 1:length(material)
        
        % getting the variables
        H = material(i).Hexp;

        T0 = material(i).t0;

        alpha = material(i).alpha;
        
      %1B func
        u_IB = @(x_val, t_val) T0 + H*x_val + sum(arrayfun(@(n) ((-2*H*sin(((2*n-1)*pi/2))) / (L*((2*n-1)*pi/(2*L))^2)) * sin(((2*n-1)*pi/(2*L))*x_val) * exp(-(((2*n-1)*pi/(2*L))^2)*alpha*t_val), 1:10));

        %plotting

        figure();
        hold on;

        plotTransientTemperatureSolution(x, u_IB, material(i).data, material_names(i), model_name);
        
        title(['Model 1B for ', material_names(i)]);
        %xlabel('Time (sec)'); ylabel('Temperature (C)');
        %grid on;

        %legend('Transient Temp Solution', 'Experimental Data', Location='southwest');
    end
end

