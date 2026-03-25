function [t_ss, fourier_num] = findSteadyStateTime(x, u, material_data, material_alpha, thermocouple_number)
    
    % The eighth and last thermocouple is the last to reach steady state.
    % Thus, the whole bar is at steady state once the eighth thermocouple reaches steady state. 
    
    thermocouple_distance = x(thermocouple_number);

    t = material_data(:,1); % [s]
    n_time = length(t);
         
    T_analytical = zeros(n_time, 1);

    for i = 1:n_time
        T_analytical(i) = u(thermocouple_distance, t(i)); % calculate the analytical solution at a single point over time
    end

    T_exp = material_data(:, thermocouple_number + 1); % retrieve thermocouple data from experiment
    
    % once the analytical model is within 5 % of the experimental steady
    % state solution, we have reached steady state and can extract the time

    % approximate steady state as the last value of the experimental data
    Texp_ss = material_data(end, 9);

    threshold = 0.05; % [= 5%]
    
    target_temp_above = Texp_ss * (1 + threshold);
    target_temp_below = Texp_ss * (1 - threshold);

    for i = 1:n_time
        if (T_analytical(i) <= target_temp_above) && (T_analytical(i) >= target_temp_below)      
        
            t_ss = t(i);
            break;
        end
    end

    fourier_num = (material_alpha * t_ss) / (thermocouple_distance^2);
        
end