function plotAllModels(x, u, material_data, material_name, model_name)
    t_max = max(material_data(:,1));
    t = linspace(0, t_max, t_max); % [s]
    

     for i = 1:length(x)      
         T_analytical = zeros(size(t));

        for j = 1:length(t)            
            T_analytical(j) = u(x(i), t(j));

        end

        plot(t, T_analytical, 'LineWidth', 1.5); % Plot analytical data
        if model_name == "Model III"
            plot(material_data(:, 1), material_data(:, 9), 'r-', 'LineWidth', 1.5); % Plotting experimental data
        end
        title(material_name + "'s Model Comparison at 8th Thermo-Couple");
        grid on;

     end
     legend("Model IA", "Model IB", "Model II", "Model III", "Experimental Transient Behavior", "Location",'southeast');
     xlabel("Times [s]");
     ylabel('Temperature [{\circ}C]')
  
end