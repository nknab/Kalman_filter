%{
%File: main.m
%Project: Autonomous Vehicles Lab | Kalman Filter
%File Created: Thursday, 19th November 2020 8:14:28 AM
%Authors: Rudra Patel
%         Kojo Anyinam-Boateng
%Emails: rudra.patel@eleves.ec-nantes.fr
%        kojo.anyinam-boateng@eleves.ec-nantes.fr
%Version: 1.0
%Brief:
%-----
%Last Modified: Sunday, 6th December 2020 9:24:23 PM
%Modified By: Kojo Anyinam-Boateng
%-----
%Copyright ©2020 Rudra Patel & Kojo Anyinam-Boateng
%}

clear all
close all
clc

A1 = 0.1;
Ts = 1 * 10^ - 3;
Delta = 100 * 10^ - 3;
D1 = 1;
G = 50;
T = 20 * 10^ - 3;
Tf = 20 * 10^ - 3;
L = 512;
q = 5;
x1 = [0; 0];
x1_0 = [1.5; 0];
p1_0 = [(2 * pi)^2/12 0; 0 0];

u = inputvoltage(D1, A1, Delta, Ts);

[y, x] = simulate(u, G, T, Ts, L, x1);

[xe] = kal(y, u, G, Tf, Ts, L, x1_0, p1_0, q);
thetaError = xe(1, :) - x(1, :);

figure(2)
subplot(2, 1, 1)
plot ((0:Ts:D1), xe(1, :), 'r');

hold on
plot ((0:Ts:D1), x(1, :), 'b');
ylabel('theta')
xlabel('Time in seconds')
title('Comparing the state vector using the Kalmann filter ')

subplot(2, 1, 2)
plot ((0:Ts:D1), thetaError);
ylabel('Error')
xlabel('Time in seconds')
title('Comparing the Error using the Kalmann filter ')

[X2] = stationarykal(y, u, G, T, Ts, L, x1_0, p1_0, q);
figure(3)
subplot(2, 1, 1)
plot ((0:Ts:D1), X2(1, :), 'r');

hold on
plot ((0:Ts:D1), x(1, :), 'b');
ylabel('theta')
xlabel('Time in seconds')
title('Comparing the state vector using the Stationary Kalmann filter ')
errortheta2 = X2(1, :) - x(1, :);
subplot(2, 1, 2)
plot ((0:Ts:D1), errortheta2);
ylabel('Error')
xlabel('Time in secomds')
title('Comparing the Error when the Stationary Kalmann filter ')
