function t_0 = findT0(data_set)

    initial_temp = data_set(1, 2:8);
    t_0 = mean(initial_temp); 

end