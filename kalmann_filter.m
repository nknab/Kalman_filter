function [X_e] = kalmann_filter(y,u,G,T,Ts,L,x1_0,p1_0,q)

A = [0 1; 0 -1/T];
B = [0;G/T];
C = [1 0];
D = [0];

x=x1_0;
P=p1_0;
R =(2*pi/L)^2/12;

[Ad,Bd,Cd,Dd]=c2dm(A,B,C,D,Ts,'zoh');
H = Cd;
X_e = zeros(2, length(u));
for i = 1 : length(u)
    %Prediction
    y_e = H*x;
    Cxy = P*H';
    Cyy = H*P*H' + R;
    K = Cxy*inv(Cyy);

    %Estimation
    x_e = x + K*(y(i)-y_e);
    X_e(:,i) = x_e;
    p_e = P - K*H*P;

    %state Prediction
    x = Ad*x_e + Bd*u(i);
    P = Ad*p_e*Ad' + Bd'*q*Bd;
end
end