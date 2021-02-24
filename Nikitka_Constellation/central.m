function dydt = central(~, SV)

mu = 3.986004418e14; % m3/c2

r = sqrt( SV(1)^2 + SV(2)^2 + SV(3)^2 );


dydt = [SV(4), SV(5), SV(6),...
    -mu * SV(1) / r ^ 3,...
    -mu * SV(2) / r ^ 3,...
    -mu * SV(3) / r ^ 3]';

end