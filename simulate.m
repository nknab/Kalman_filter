%{
%File: simulate.m
%Project: Autonomous Vehicles Lab | Kalman Filter
%File Created: Monday, 30th November 2020 4:12:35 PM
%Authors: Rudra Patel
%         Kojo Anyinam-Boateng
%Emails: rudra.patel@eleves.ec-nantes.fr
%        kojo.anyinam-boateng@eleves.ec-nantes.fr
%Version: 1.0
%Brief:
%-----
%Last Modified: Sunday, 6th December 2020 9:22:21 PM
%Modified By: Kojo Anyinam-Boateng
%-----
%Copyright ©2020 Rudra Patel & Kojo Anyinam-Boateng
%}

function [y, X] = simulates(u, G, T, Ts, L, x1)

    x = x1;
    A = [0 1; 0 -1 / T];
    B = [0; G / T];
    C = [1 0];
    D = 0;

    [Ad, Bd, Cd, Dd] = c2dm(A, B, C, D, Ts, 'zoh');

    n = length(u);
    y = zeros(1, n);
    X = zeros(2, n);

    for index = 1:n

        y(index) = Cd * x;
        X(:, index) = x;
        x = Ad * x + Bd * u(index);

    end

    y = round(y * L / 2 / pi) * 2 * pi / L;

    figure(1)
    subplot(3, 1, 1)
    plot(X(1, :));
    ylabel('theta')
    xlabel('Time in secs')
    title('State Model from The Simulator')

    subplot(3, 1, 2)
    plot(y);
    ylabel('y')
    xlabel('Time (s)')
    title('Measurement Model from The Simulator')

    subplot(3, 1, 3)
    plot(X(2, :));
    ylabel('Omega')
    xlabel('Time (s)')
    title('State Model from The Simulator')
end
