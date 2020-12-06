%{
%File: stationarykal.m
%Project: Autonomous Vehicles Lab | Kalman Filter
%File Created: Sunday, 6th December 2020 11:50:01 AM
%Authors: Rudra Patel
%         Kojo Anyinam-Boateng
%Emails: rudra.patel@eleves.ec-nantes.fr
%        kojo.anyinam-boateng@eleves.ec-nantes.fr
%Version: 1.0
%Brief:
%-----
%Last Modified: Sunday, 6th December 2020 9:30:14 PM
%Modified By: Kojo Anyinam-Boateng
%-----
%Copyright ©2020 Rudra Patel & Kojo Anyinam-Boateng
%}

function [XS] = stationarykal(y, u, G, T, Ts, L, x1_0, p1_0, q)
    % This function is used to for stationary kalmann filter

    A = [0 1; 0 -1 / T];
    B = [0; G / T];
    C = [1 0];
    D = [0];
    R = (2 * pi / L)^2/12;
    [Ad, Bd, Cd, Dd] = c2dm(A, B, C, D, Ts, 'zoh');

    [K, P, ~, ~] = dlqe(Ad, Bd, Cd, q, R); % Constant Kalman Gain
    H = Cd;
    x = x1_0;

    X_e = zeros(2, length(u));

    for i = 1:length(u)
        % State prediction
        % Observation Prediction
        y_e = H * x;
        % Update the state estimate with Measurement
        X_e = x + K * (y(i) - y_e);
        XS(:, i) = X_e;
        % Update the error in co-variance
        p_e = P - K * H * P;
        %state Prediction
        x = Ad * X_e + Bd * u(i);
    end

end
