%{
%File: inputvoltage.m
%Project: Autonomous Vehicles Lab | Kalman Filter
%File Created: Monday, 30th November 2020 2:03:42 PM
%Authors: Rudra Patel
%         Kojo Anyinam-Boateng
%Emails: rudra.patel@eleves.ec-nantes.fr
%        kojo.anyinam-boateng@eleves.ec-nantes.fr
%Version: 1.0
%Brief: Provides a sampled input for a duration D.
%-----
%Last Modified: Sunday, 6th December 2020 9:19:31 PM
%Modified By: Kojo Anyinam-Boateng
%-----
%Copyright ©2020 Rudra Patel & Kojo Anyinam-Boateng
%}

function u = inputvoltage(D, A, Delta, Ts)

    t = 0:Ts:D;
    f = 1 / Delta;
    u = A * 0.5 * (square(2 * pi * f * t));
    plot(t, u)

end
