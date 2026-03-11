%% Task 4: Model II

M = [3.09, 1.69, 6.468, 6.65, 19.78];
for i = 1:length(material)
    material(i).M = M(i); 
end

if plotTransientModel_2
    model_name = "Model II";
    for i = 1:length(material)
        
        % Getting the variables
        H = material(i).Hexp;
        T0 = material(i).t0;
        alpha = material(i).alpha;
        M = material(i).M;

      % II func
        u_II = @(x_val, t_val) T0 + H*x_val + sum(arrayfun(@(n) ((2*(M-H)*sin(((2*n-1)*pi/2))) / (L*((2*n-1)*pi/(2*L))^2)) * sin(((2*n-1)*pi/(2*L))*x_val) * exp(-(((2*n-1)*pi/(2*L))^2)*alpha*t_val), 1:10));
       
        % Plotting

        figure();
        hold on;

        plotTransientTemperatureSolution(x, u_II, material(i).data, material_names(i), model_name);
        hold off;
        
    end
end