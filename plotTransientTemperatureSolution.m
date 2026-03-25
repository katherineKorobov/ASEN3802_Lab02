function plotTransientTemperatureSolution(x, u, material_data, material_name, model_name)
    t_max = max(material_data(:,1));
    t = linspace(0, t_max, 100); % [s]
    
     for i = 1:length(x)      
         T_analytical = zeros(size(t));

        for j = 1:length(t)            
            T_analytical(j) = u(x(i), t(j));

        end

        plot(t, T_analytical, 'b-', 'LineWidth', 1.5); % Plot analytical data
        plot(material_data(:, 1), material_data(:, (i+1)), 'r-', 'LineWidth', 1.5); % Plotting experimental data

     end
     
     legend("Analytical Transient Solution","Experimental Transient Behavior", "Location",'southeast');
     xlabel("Times [s]");
     ylabel('Temperature [{\circ}C]')
     title(model_name + " for " + material_name);
     grid on;
end