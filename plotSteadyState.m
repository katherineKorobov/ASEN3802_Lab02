function plotSteadyState(material_name, x, material, plot_number)
    
    thermal_vals = material.data(end, 2:end);
    
    p = polyfit(x, thermal_vals, 1);
    y_fit = polyval(p, x);
    
    subplot(3, 2, plot_number);

    hold on;
    plot(x, y_fit, 'b', "LineWidth", 1);
    plot(x, y_fit + 2, 'b--', "LineWidth", 0.5);
    plot(x, y_fit -2, 'b--', "LineWidth", 0.5, 'HandleVisibility','off');
    scatter(x, thermal_vals,'m', "LineWidth", 1.5);
    xlabel("Distance [m]");
    ylabel('Temperature [deg C]');
    title(material_name);
    legend("Linear Fit", "Error","Experimental Data", "Location", "southeast");
    hold off;

end