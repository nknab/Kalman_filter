function u = inputvoltage(D,A,Delta,Ts)
%Ts = 10^(-3);
%D  = 100 * 10^(-3);
%A = 0.1;
t=0:Ts:D;
f = 1/Delta;
u = A*0.5*(square(2*pi*f*t));
plot(t,u)
end



