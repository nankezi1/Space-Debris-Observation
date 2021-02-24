clear all;

consts = initializeConstants;

%% Simulation parameters
N_debris = 1e4;
alt_min = 700e3;
alt_max = 1000e3;

%% Random debris generation

% tasks:add layers and real particles' desity, add infor about particles

% r = a + (b-a).*rand(N,1).
rho = (consts.rEarth + alt_min) + (alt_max - alt_min)*rand(1,N_debris);
theta = -pi/2 + pi*rand(1,N_debris);
phi = 2*pi*rand(1,N_debris);

r_spherical = [rho; theta; phi];

r(1,:) = rho.*cos(theta).*cos(phi);
r(2,:) = rho.*cos(theta).*sin(phi);
r(3,:) = rho.*sin(theta);

v_mag = sqrt(consts.muEarth/norm(r(:,1)));

for i = 1:size(r,2)
    v_temp = find_perp(r(:,i));
    v(:,i) = v_temp/norm(v_temp)*v_mag;
end

rv =[r;v];

for i = 1:size(r,2)
    debris_oe(:,i) = rv2oe(rv(:,i), consts); 
end

figure('Name','Environment');
earth_sphere('m');
hold on;
plot3(r(1,:), r(2,:), r(3,:), 'k*', 'MarkerSize', 0.1);
legend('Earth', 'Debris');

%% Debris propagation - fast model

% Simulation parameters
StartDate = juliandate(datetime(2020,2,23,0,0,0)); % Start modeling
Duration = 1; % Modeling time in days
TimeStep = 100; % Time step of the modeling in seconds
dt_vector = 0:TimeStep:Duration*86400;
date_vector = StartDate + dt_vector;

for i = 1:size(rv,2)
    for k = 1:length(dt_vector)
        r_debris_ECI(i,k,:) = prop_simple(debris_oe(1,i), debris_oe(2,i), debris_oe(3,i), debris_oe(4,i), dt_vector(k));
    end
end

%% Satellite

