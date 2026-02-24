function Hexp = calculateHexp(data_set)

    % Extract the last row where time is not NaN (this is at steady state)
    lastRow = data_set(~isnan(data_set(:, 1)), end);
    
    % Calculate the slope, Hexp, by taking two thermocouple points and two
    % x
    
    % x1 is at 3in away
    point1 = [3, lastRow(2)]; % [in, ]
    point2 = [6.5, lastRow(9)]; % [in, ]


    Hexp = (point2(2) - point1(2)) / (point1(2) - point1(1));
end