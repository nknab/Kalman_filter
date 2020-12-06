%{
%File: kal.m
%Project: Autonomous Vehicles Lab | Kalman Filter
%File Created: Monday, 30th November 2020 5:43:20 PM
%Authors: Rudra Patel
%         Kojo Anyinam-Boateng
%Emails: rudra.patel@eleves.ec-nantes.fr
%        kojo.anyinam-boateng@eleves.ec-nantes.fr
%Version: 1.0
%Brief:
%-----
%Last Modified: Sunday, 6th December 2020 9:26:11 PM
%Modified By: Kojo Anyinam-Boateng
%-----
%Copyright ©2020 Rudra Patel & Kojo Anyinam-Boateng
%}

function [xe] = kal(y, u, G, T, Ts, L, x1_0, p1_0, q)

    A = [0 1; 0 -1 / T];
    B = [0; G / T];
    C = [1 0];
    D = [0];

    x = x1_0;
    P = p1_0;
    R = (2 * pi / L)^2/12;
    n = length(u);

    [Ad, Bd, Cd, Dd] = c2dm(A, B, C, D, Ts, 'zoh');
    Cd = Cd;
    xe = zeros(2, n);

    for index = 1:n
        %Prediction
        y_e = Cd * x;
        Cxy = P * Cd';
        Cyy = Cd * P * Cd' + R;
        K = Cxy * inv(Cyy);

        %Estimation
        x_e = x + K * (y(index) - y_e);
        xe(:, index) = x_e;
        p_e = P - K * Cd * P;

        %state Prediction
        x = Ad * x_e + Bd * u(index);
        P = Ad * p_e * Ad' + Bd' * q * Bd;
    end

end
