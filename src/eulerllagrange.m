% Fjäder 1: 0.24 26.1466
% Fjäder 2: 0.

function [dydt] = eulerllagrange(t,y)
    r = sqrt(y(1)^2+y(3)^2+y(5)^2);
    k = 26.1466;
    m = 0.5311;
    l_0 = 0.20;
    g = 9.82;

    dydt = [
        y(2);
        - k/m * (r-l_0)/r*y(1);
        y(4);
        - k/m * (r-l_0)/r*y(3);
        y(6);
        - k/m * (r-l_0)/r*y(5) - g;
    ];
end

