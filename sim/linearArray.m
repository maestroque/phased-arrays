addpath ..\src\
clear all;

c = 3e8;
f0 = 7.6e9;
lambda0 = c / f0;
theta0 = deg2rad(90);
Ny = 92;
dy = 0.525 * lambda0;
theta = linspace(-pi/2, pi/2, 1000);

noTapering = @(y, Ny) 1;
isotropicRadPattern = @(theta) 1;

notTapered = linearArrayRadPattern(Ny, dy, f0, theta0, noTapering, isotropicRadPattern);
tapered = linearArrayRadPattern(Ny, dy, f0, theta0, @cosineSquaredTapering, isotropicRadPattern);

notTaperedDipole = linearArrayRadPattern(Ny, dy, f0, theta0, noTapering, @electricDipoleRadPattern);
taperedDipole = linearArrayRadPattern(Ny, dy, f0, theta0, @cosineSquaredTapering, @electricDipoleRadPattern);

figure;
plot(rad2deg(theta), notTapered);
hold on;
plot(rad2deg(theta), tapered)
xlabel('Theta (radians)');
ylabel('Normalized Gain');
title('Not tapered vs tapered');
grid on;
axis tight;

figure;
plot(rad2deg(theta), notTapered);
hold on;
plot(rad2deg(theta), notTaperedDipole)
xlabel('Theta (radians)');
ylabel('Normalized Gain');
title('Isotropic vs Electric Dipole');
legend;
grid on;
axis tight;