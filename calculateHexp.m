function Hexp = calculateHexp(data_set)

    % Extract the last row where time is not NaN (this is at steady state)
    last_idx = find(~isnan(data_set(:, 1)), 1, "last");
    lastRow = data_set(last_idx, :);
   
    x = linspace(0.0762, 0.1651, 8);
    thermal_vals = lastRow(2:end);

    p = polyfit(x, thermal_vals, 1);
    Hexp = p(1);
    
end