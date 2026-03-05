clc, clear, close all

%% Task 1: Aluminum 25 V, Th8
% Define Variables (from Part 1)
T0 = 16.6286; % [C]
H = 91.0858; % [C/m]

L = 0.149225; % (m) or 5.875 (in)
x = 0.123825; % (m) or 4.875 (in)

k = 130; % [W/(mK)]
rho = 2810; % [kg/m^3]
cp = 960; % [J/(kgK)]

alpha = k/(cp*rho);

Nmax = 10;
t_values = [1, 1000]; % seconds

u = zeros(length(t_values), Nmax);

for j = 1:length(t_values)
    
    t = t_values(j);
 
    for N = 1:Nmax
        
        s = 0;
        
        for n = 1:N
            
            lambda = (2*n-1)*pi/(2*L);
            bn = (8*H*L)/((2*n-1)^2*pi^2) * (-1)^n;
            
            s = s + bn*sin(lambda*x)*exp(-lambda^2*alpha*t);
        end
        
        u(j,N) = T0 + H*x + s;
        
    end
end

N_vals = 1:Nmax;

plot(N_vals, u(1,:))
hold on
plot(N_vals, u(2,:))

xlabel('Number of Modes (n)')
ylabel('Temperature at Th8')
legend('t = 1 s','t = 1000 s')
title('Temperature vs Number of Modes at Thermocouple 8')
