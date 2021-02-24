clear variables;
tic;

%% Initial conditions

% OE
sma = 6700;
inc = 45;
RAAN = 0;
u = 0;

% SV
SV0 = [6700000, 0, 0 ,...
       0, 5.4540e+03 , 5.4540e+03];

t_days = 1; % days 
dt_vector = 0:30:t_days*86400;

%% Modeling
% Analytical J2 
[Rsat, Omega] = prop_simple(sma,inc,RAAN,u,dt_vector);
Rsat = Rsat';
toc;

% Numerical J2 
dt = [0 , t_days*86400];
low_tol = odeset('RelTol',2e-5,'AbsTol',1e-5);
[t_J2,SV_J2] = ode45(@J2, dt_vector, SV0, low_tol);

% Numerical Central
dt = [0 , t_days*86400];
low_tol = odeset('RelTol',2e-5,'AbsTol',1e-5);
[t_central,SV_central] = ode45(@central, dt_vector, SV0, low_tol);


% GMAT J2 
GMAT = importdata('GMAT_final_hope.txt');

sma_GMAT = sqrt((GMAT(:,1)*1000).^2 + (GMAT(:,2)*1000).^2 + (GMAT(:,3)*1000).^2);
sma_Analytical = sqrt((Rsat(:,1)*1000).^2 + (Rsat(:,2)*1000).^2 + (Rsat(:,3)*1000).^2);
sma_Numerical = sqrt(SV_J2(:,1).^2 + SV_J2(:,2).^2 + SV_J2(:,3).^2);
sma_Numerical_central = sqrt(SV_central(:,1).^2 + SV_central(:,2).^2 + SV_central(:,3).^2);


%% Errors between solutions
Error_GN = [GMAT(:,1)*1000 - SV_J2(:,1),...
            GMAT(:,2)*1000 - SV_J2(:,2),...
            GMAT(:,3)*1000 - SV_J2(:,3)];

Error_GA = [GMAT(:,1)*1000 - Rsat(:,1)*1000,...
            GMAT(:,2)*1000 - Rsat(:,2)*1000,...
            GMAT(:,3)*1000 - Rsat(:,3)*1000];

Error_NA = [SV_J2(:,1) - Rsat(:,1)*1000,...
            SV_J2(:,2) - Rsat(:,2)*1000,...
            SV_J2(:,3) - Rsat(:,3)*1000];


%% Figures
figure(1);
plot3(Rsat(:,1)*1000, Rsat(:,2)*1000, Rsat(:,3)*1000, 'r');
hold on;
plot3(SV_J2(:,1), SV_J2(:,2), SV_J2(:,3), 'g');
hold on;
plot3(GMAT(:,1)*1000, GMAT(:,2)*1000, GMAT(:,3)*1000, 'b');
legend('Red - Analytic, Green - Numerical, Blue - GMAT')
title('Modeling of orbital propagation for 1 day in ECI coordinates');

figure(2);
plot(dt_vector, Error_GN(:,1),'r',...
     dt_vector, Error_GN(:,2),'g',...
     dt_vector, Error_GN(:,3),'b')
legend('Error (GMAT - Numerical), x coordinate [m]',...
       'Error (GMAT - Numerical), y coordinate [m]',...
       'Error (GMAT - Numerical), z coordinate [m]');
title('Differences between modeling results: GMAT J2 - Numerical J2');

figure(3);
plot(dt_vector, Error_GA(:,1),'r',...
     dt_vector, Error_GA(:,2),'g',...
     dt_vector, Error_GA(:,3),'b')
legend('Error (GMAT - Analytical), x coordinate [m]',...
       'Error (GMAT - Analytical), y coordinate [m]',...
       'Error (GMAT - Analytical), z coordinate [m]');
title('Differences between modeling results: GMAT J2 - Analytical J2');

figure(4);
plot(dt_vector, Error_NA(:,1),'r',...
     dt_vector, Error_NA(:,2),'g',...
     dt_vector, Error_NA(:,3),'b')
legend('Error (Numerical - Analytical), x coordinate [m]',...
       'Error (Numerical - Analytical), y coordinate [m]',...
       'Error (Numerical - Analytical), z coordinate [m]');
title('Differences between modeling results: Numerical J2 - Analytical J2');


figure(5);
plot(dt_vector, sma_GMAT,'r',...
     dt_vector, sma_Analytical,'g',...
     dt_vector, sma_Numerical,'b');
 legend('SMA - GMAT  [m]',...
       'SMA - Analytical  [m]',...
       'SMA - Numerical  [m]');
title('Semi-major axis');

%% Figures
figure(6);
plot3(SV_central(:,1)*1000, SV_central(:,2)*1000, SV_central(:,3)*1000, 'r');
