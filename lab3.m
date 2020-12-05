close all
clear all
clc

%% 1.1 
N = 4000;
m = 0.95;

gauss = randn(N,1);
[n_gauss,b_gauss] = hist(gauss,N);
bar(b_gauss,n_gauss/(b_gauss(2)-b_gauss(1))/sum(N),1);

uniform = 2*sqrt(3)*(rand(N,1)-0.5);
[n_uniform,b_uniform] = hist(uniform,N);
bar(b_uniform,n_uniform/(b_uniform(2)-b_uniform(1))/sum(N),1)

G_mixture = randn(N,1)*sqrt(1-m*m)+m;
k = find(rand(N,1)>0.5);
G_mixture(k) = G_mixture(k) -2*m;
[n_gmix,b_gmix] = hist(G_mixture,N);
bar(b_gmix,n_gmix/(b_gmix(2)-b_gmix(1))/sum(N),1)

figure(1);

subplot(3,1,1);
plot(b_gauss,n_gauss,'--g');
xline(mean(b_gauss,'all'),'-k','mean');
xline(std(b_gauss),'--k','std');
xline(-std(n_gauss),'--k','std');
title("normal disribution with mean " + mean(b_gauss) + " and std " + std(b_gauss));


subplot(3,1,2);
plot(b_uniform,n_uniform,'--b');
xline(mean(b_uniform,'all'),'-k','mean');
xline(std(n_uniform),'--k','std');
xline(-std(n_gauss),'--k','std');
title("uniform disribution with mean " + mean(b_uniform) + " and std " + std(b_uniform));


subplot(3,1,3);
plot(b_gmix,n_gmix,'--r');
xline(mean(b_gmix,'all'),'-k','mean');
xline(std(b_gmix),'--k','std');
xline(-std(b_gmix),'--k','std');
title("Gaussian mixturer disribution with mean " + mean(b_gmix) + " and std " + std(b_gmix));

%%1.2
nr = 200;
sigma_1 = 2;
sigma_2 = 5;
rho = 0.9;
P0 = 0.91;
C = [(sigma_1)^2,rho*(sigma_1*sigma_2);rho*(sigma_1*sigma_2),(sigma_2)^2];
theta = linspace(0,2*pi,100);

X = sqrt(-2*log(1-P0))*chol(C,'lower')*[cos(theta);sin(theta)]+m*ones(1,length(theta));
x= chol(C,'lower')*randn(length(C),nr) + m*ones(1,nr);

figure(2);
plot(x(1,:),x(2,:),'*'); 
hold on
plot(X(1,:),X(2,:)); 
title("Joint Distribution with 91%confidence ellipse");





















