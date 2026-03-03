function plotTransientTemperatureSolution(material_name, x, u, material_data)
    t_max = max(material_data(:,1));
    t = linspace(0, t_max, t_max); % [s]
    
    hold on;

     for i = 1:length(x)      
         T_analytical = zeros(size(t));

        for j = 1:length(t)            
            T_analytical(j) = u(x(i), t(j));

        end

        plot(t, T_analytical, 'b-'); % Plot analytical data
        plot(material_data(:, 1), material_data(:, (i+1)), 'r-'); % Plotting experimental data

     end
  
end