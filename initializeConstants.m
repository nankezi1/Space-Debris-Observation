function consts = initializeConstants()

% The script initializes common constants

disp('Initializing constants for orbital dynamics simulation');

% Constants
consts.rEarth = 6371009;                                            % Earth radius, [m]
consts.rMars = 3396e3;                                              % Mars radius, [m]
consts.rEarth_equatorial = 6.378136300e6;                           % mean Earth equtorial radius, [m]
consts.muEarth = 3.986004415e14;                                    % Earth stadard gravitational parameter, [m^3 / s^2]
consts.muSun = 132712440017.987 * 10^9;                             % Sun gravitational parameter, [m3/s2]
consts.AstronomicUnit = 149597870691;                               % AstronomicUnit, [m]
consts.EarthMeanMotion = sqrt(consts.muSun/consts.AstronomicUnit^3);% mean motion of the Earth, [rad/s]
consts.J2 = 1.082626e-3;                                            % First zonal harmonic coefficient in the expansion of the Earth's gravity field
consts.deg2rad = pi/180;                                            % conversion from degrees to radians
consts.rad2deg = 180/pi;                                            % conversion from radians to degrees
consts.km2m = 1000;                                                 % conversion from kilometers to meters
consts.m2km = 1e-3;                                                 % conversion from meters to kilometers
consts.omegaEarth = 7.29211585275553e-005;                          % Earth self revolution angular vecocity [rad/s] 
consts.wEarth = [0; 0; 7.29211514670698e-05];                       % Earth rotational velocity, rad/s
consts.day2sec = 86400;                                             % conversion from days to seconds
consts.g = 9.80665;                                                 % gravitational acceleration on Earth, m/s^2

% consts.delta_MJD_GMAT = 2430000.0; % backward convertion from modified Julian days in GMAT to Julian days
% consts.EarthSMA = 149598023; % semi-major axis of the Earth orbit [km]

disp('Done.');