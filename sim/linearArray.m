addpath ..\src\
clear all;

c = 3e8;
f0 = 7.6e9;
lambda0 = c / f0;
theta0 = deg2rad(10);
Ny = 92;
dy = 0.525 * lambda0;
theta = linspace(-pi/2, pi/2, 1000);

noTapering = @(y, Ny) 1;
isotropicRadPattern = @(theta) 1;

notTapered = linearArrayRadPattern(Ny, dy, f0, theta0, noTapering, isotropicRadPattern);
tapered = linearArrayRadPattern(Ny, dy, f0, theta0, @cosineSquaredTapering, isotropicRadPattern);

figure;
plot(rad2deg(theta), notTapered);
hold on;
plot(rad2deg(theta), tapered)
xlabel('Theta (radians)');
ylabel('Normalized Gain');
% title(plotName);
grid on;
axis tight;