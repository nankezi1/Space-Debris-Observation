function dydt = J2(~,SV)

mu = 3.986004418e14; % m3/c2
j2 = 1.082636023e-3; % first coefficient at zonal harmonics
R_Earth = 6378245; % mean equatorial Earth radius
r = sqrt( SV(1)^2 + SV(2)^2 + SV(3)^2 );
ro = r / R_Earth;


dydt = [SV(4), SV(5), SV(6),...
    -mu * SV(1) / r ^ 3 * (1 + 1.5 * j2 * ro ^ 2 * (1 - 5 * ( SV(3) / r ) ^2 )),...
    -mu * SV(2) / r ^ 3 * (1 + 1.5 * j2 * ro ^ 2 * (1 - 5 * ( SV(3) / r ) ^2 )),...
    -mu * SV(3) / r ^ 3 * (1 + 1.5 * j2 * ro ^ 2 * (1 - 5 * ( SV(3) / r ) ^2 ))]';

end