function plotAllModels(x, u, material_data, material_name, model_name, i)
    t = material_data(:,1); % [s]
    T_analytical = zeros(size(t));

    for j = 1:length(t)            
        T_analytical(j) = u(x, t(j));
    end
    
    % Model Temperature
    plot(t, T_analytical, "-", 'LineWidth', 1.5); % Plot analytical data
    
    % Experimental Temperature
    if model_name == "Model III"
        plot(t, material_data(:, 9), 'r-', 'LineWidth', 1.5); % Plotting experimental data
        
        % Shaded Error Region
        p = patch([t; flip(t)], [material_data(:,9)+2; flip(material_data(:,9)-2)], [0.5, 0.5, 0.5]);
        p.FaceAlpha = 0.2; % transparency
        p.EdgeColor = [0.5, 0.5, 0.5]; % grey border
    end
    title(material_name + "'s Model Comparison at 8th Thermo-Couple");
    grid on;

    legend("Model IA", "Model IB", "Model II", "Model III", "Experimental Transient Behavior", "Error", "Location",'southeast');
    xlabel("Times [s]");
    ylabel('Temperature [{\circ}C]')
    
    hold off;
end