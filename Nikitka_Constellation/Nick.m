clear all;

% Input data: h, inc, RAAN, u

h = 1150; % orbit altitute, km
% The orbit is circular, ecc = 0
inc = 53; % degrees
RAAN = 0; % degrees
u = 0; % argument of latitude = AOP + anomly

% Standard notation for Walker constellation
T = 1600; % Total number of spacecrafts in constellation
P = 32;  % Number of orbital planes
F = 1;   % Phasing parameter
PU = 360/T; % Phasing unit
F = F*PU;
RAAN_change = 180/(P-1);
u_change = 360/(T/P);

sat = zeros(P, T/P,4);

% tic;
for i = 1:P
    for j = 1:T/P
        sat(i,j,1) = h;
        sat(i,j,2) = inc;
        sat(i,j,3) = RAAN + RAAN_change*(i-1);
        sat(i,j,4) = u + u_change*(j-1);
    end
end

% Simulation parameters
StartDate = juliandate(datetime(2019,1,1,0,0,0)); % Start modeling
Duration = 1; % Modeling time in days
TimeStep = 100; % Time step of the modeling in seconds
dt_vector = 0:TimeStep:Duration*86400;
date_vector = StartDate + dt_vector;

for i = 1:P
    for j = 1:T/P
        for k = 1:length(dt_vector)
            Rsat_ECI(i,j,k,:) = prop_simple(sat(i,j,1), sat(i,j,2), sat(i,j,3), sat(i,j,4), dt_vector(k));
            Rsad_ECI = prop_simple(sat(i,j,1), sat(i,j,2), sat(i,j,3), sat(i,j,4), dt_vector(k));
            Rsat_ECEF(i,j,k,:) = ECItoECEF(date_vector(k), Rsad_ECI);
            [latgc(i,j,k), latgd(i,j,k) ,lon(i,j,k) ,hellp(i,j,k)] = ijk2ll(Rsat_ECEF(i,j,k,1), Rsat_ECEF(i,j,k,2), Rsat_ECEF(i,j,k,3));
        end
    end
end

% toc;