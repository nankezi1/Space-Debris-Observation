function [Rsat, Omega] = prop_simple(sma0_km, inc0_deg, Omega0_deg, u0_deg, t)

Re = 6378.254; % mean Earth equtorial radius [km]
mu = 3.986e5; % Earth gravitation parameter [km3/s2]
J2 = 1.082626e-3; % First zonal harmonic coefficient in the expansion of the Earth's gravity field
deg2rad = pi/180;

inc = inc0_deg * deg2rad;
Omega0 = Omega0_deg * deg2rad;
u0 = u0_deg * deg2rad;

Omega_p = -1.5*(J2*mu^(1/2)*Re^2)/(sma0_km^(7/2))*cos(inc);
wd = sqrt(mu/sma0_km^3)*(1-1.5*J2*(Re/sma0_km)^2*(1-4*cos(inc)^2));

u = u0 + t.*wd;
Omega = Omega0 + Omega_p.*t;

Rsat  = [sma0_km.*(cos(u).*cos(Omega) - sin(u).*cos(inc).*sin(Omega)); sma0_km.*(cos(u).*sin(Omega) + sin(u).*cos(inc).*cos(Omega)); ...
         sma0_km.*(sin(u).*sin(inc))];

end