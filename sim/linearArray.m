addpath ..\src\
clear all;

c = 3e8;
f0 = 7.6e9;
f1 = 1.623 * f0;
fg = 1.9 * f0;
lambda0 = c / f0;
theta0 = deg2rad(10);
Ny = 92;
dy = 0.525 * lambda0;
theta = linspace(-pi/2, pi/2, 10000);

noTapering = @(y, Ny) 1;
isotropicRadPattern = @(theta) 1;

notTapered = linearArrayRadPattern(Ny, dy, f0, theta, theta0, noTapering, isotropicRadPattern);
tapered = linearArrayRadPattern(Ny, dy, f0, theta, theta0, @cosineSquaredTapering, isotropicRadPattern);

gratingLimit = linearArrayRadPattern(Ny, dy, f1, theta, theta0, noTapering, isotropicRadPattern);
grating1 = linearArrayRadPattern(Ny, dy, fg, theta, theta0, noTapering, isotropicRadPattern);
grating2 = linearArrayRadPattern(Ny, dy, 1.85*f0, theta, theta0, noTapering, isotropicRadPattern);

%%% Directivity Calculation

D2 = 10*log10(linearArrayDirectivity(10 .^ (notTapered ./ 20), theta))
D1 = 10*log10(linearArrayDirectivity(10 .^ (tapered ./ 20), theta))

notTaperedDipole = linearArrayRadPattern(Ny, dy, f0, theta, theta0, noTapering, @electricDipoleRadPattern);
taperedDipole = linearArrayRadPattern(Ny, dy, f0, theta, theta0, @cosineSquaredTapering, @electricDipoleRadPattern);

%%% Uniform Tapering - Radiation Pattern 

BW = linearArrayBeamwidth(notTapered, theta);
BW_l = rad2deg(theta0) - BW/2;
BW_h = rad2deg(theta0) + BW/2;
SLL = -13.27; % From the radiation plot data points

figure;
plot(rad2deg(theta), notTapered);
xline(10,'-',{'\theta_0 = 10^\circ'}, LabelVerticalAlignment='bottom', LabelOrientation='horizontal', Color='r');
xline([BW_l BW_h], '-', {"3dB Beamwidth = " + BW + "^\circ", ""}, LabelOrientation='horizontal', LabelHorizontalAlignment='left')
hold on;
yline(SLL, '--', "Max SLL = " + SLL + " dB")
xlabel('Angle \theta (degrees)');
ylabel('Normalized Gain S(\theta) (dB)');
title('Linear Phased Array - Uniform Amplitude Tapering');
grid on;
axis tight;

%%% Cosine-squared Tapering - Radiation Pattern and Comparison with Uniform

BW = linearArrayBeamwidth(tapered, theta);
BW_l = rad2deg(theta0) - BW/2;
BW_h = rad2deg(theta0) + BW/2;
SLL = -31.46; % From the radiation plot data points

figure;
plot(rad2deg(theta), notTapered, '--');
xline(10,'-',{'\theta_0 = 10^\circ'}, LabelVerticalAlignment='bottom', LabelOrientation='horizontal', Color='r');
xline([BW_l BW_h], '-', {"3dB Beamwidth = " + BW + "^\circ", ""}, LabelOrientation='horizontal', LabelHorizontalAlignment='left')
hold on;
plot(rad2deg(theta), tapered)
yline(SLL, '--', "Max SLL = " + SLL + " dB")
xlabel('Angle \theta (degrees)');
ylabel('Normalized Gain S(\theta) (dB)');
title('Linear Phased Array - Cosine-Squared Amplitude Tapering');
grid on;
axis tight;

figure;
plot(rad2deg(theta), notTapered);
hold on;
plot(rad2deg(theta), gratingLimit)
hold on;
plot(rad2deg(theta), grating2)
hold on;
plot(rad2deg(theta), grating1)
xline(-80, '--', {"Grating Lobe at -80^\circ"}, LabelOrientation='horizontal', LabelHorizontalAlignment='right', LabelVerticalAlignment='bottom')
xlabel('Angle \theta (degrees)');
ylabel('Normalized Gain S(\theta) (dB)');
title('Isotropic vs Electric Dipole');
legend('f_0', '1.623f_0', '1.85f_0', '1.9f_0');
grid on;
axis tight;