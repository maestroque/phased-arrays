addpath ..\src\
clear all;

c = 3e8;
f0 = 7.5e9;
lambda0 = c / f0;
theta0 = deg2rad(10);
phi0 = deg2rad(45);
u0 = sin(theta0)*cos(phi0);
v0 = sin(theta0)*sin(phi0);
Nx = 22;
Ny = 18;
dx = 0.7 * lambda0;
dy = 0.525 * lambda0;

theta = linspace(-pi/2, pi/2, 1000);
phi = linspace(-pi/2, pi/2, 1000);

[t, p] = meshgrid(theta, phi);

u = -1:0.005:1; 
v = -1:0.005:1;

[u, v] = meshgrid(u, v);

noTapering = @(y, Ny) 1;
isotropicRadPattern = @(u, v, polarization) 1;
polarization = "full";

notTapered = triangularArrayRadPattern(Nx, Ny, dx, dy, f0, u, v, u0, v0, noTapering, isotropicRadPattern, polarization);   
tapered = triangularArrayRadPattern(Nx, Ny, dx, dy, f0, u, v, u0, v0, @cosineSquaredTapering, isotropicRadPattern, polarization);   
notTaperedDipole = triangularArrayRadPattern(Nx, Ny, dx, dy, f0, u, v, u0, v0, noTapering, @electricDipoleRadPattern, polarization);   
taperedDipole = triangularArrayRadPattern(Nx, Ny, dx, dy, f0, u, v, u0, v0, @cosineSquaredTapering, @electricDipoleRadPattern, polarization); 
notTaperedDipoleCo = triangularArrayRadPattern(Nx, Ny, dx, dy, f0, u, v, u0, v0, noTapering, @electricDipoleRadPattern, "co");   
taperedDipoleCo = triangularArrayRadPattern(Nx, Ny, dx, dy, f0, u, v, u0, v0, @cosineSquaredTapering, @electricDipoleRadPattern, "co");
notTaperedDipoleCross = triangularArrayRadPattern(Nx, Ny, dx, dy, f0, u, v, u0, v0, noTapering, @electricDipoleRadPattern, "cross");   
taperedDipoleCross = triangularArrayRadPattern(Nx, Ny, dx, dy, f0, u, v, u0, v0, @cosineSquaredTapering, @electricDipoleRadPattern, "cross");

% Masking the data inside the unit circle of the u-v
notTapered(hypot(u, v) > 1) = NaN;
tapered(hypot(u, v) > 1) = NaN;
notTaperedDipole(hypot(u, v) > 1) = NaN;
taperedDipole(hypot(u, v) > 1) = NaN;
notTaperedDipoleCo(hypot(u, v) > 1) = NaN;
taperedDipoleCo(hypot(u, v) > 1) = NaN;
notTaperedDipoleCross(hypot(u, v) > 1) = NaN;
taperedDipoleCross(hypot(u, v) > 1) = NaN;

dipole = abs((u .^ 2 - u .^ 4 - u .^ 2 * v .^ 2 + v .^ 2) ./ (u .^ 2 + v .^ 2));
dipole(hypot(u, v) > 1) = NaN;
dipole(isinf(dipole)) = 4.1e5;
dipole = abs(dipole/max(dipole, [], "all"));

figure;
contourf(u, v, notTapered);
[u1, v1] = find(notTapered == max(notTapered, [], "all"));
hold on;
plot(u0, v0, 'ro'); % Plotting the point (u0, v0). Expected main lobe
plot(u(u1, u1), v(v1, v1), 'bo'); % Plotting the point (u1, v1). Actual main lobe
hold off;
xlabel('u (sin\theta cos\phi)');
ylabel('v (sin\theta sin\phi)');
title('Triangular-Grid Array Radiation Pattern', 'Uniform Tapering');
grid on;
axis tight;

figure;
surf(u, v, notTaperedDipole);
[u1, v1] = find(notTaperedDipole == max(notTaperedDipole, [], "all"));
hold on;
plot(u0, v0, 'ro'); % Plotting the point (u0, v0). Expected main lobe
plot(u(u1, u1), v(v1, v1), 'bo'); % Plotting the point (u1, v1). Actual main lobe
hold off;
shading interp;
xlabel('u (sin\theta cos\phi)');
ylabel('v (sin\theta sin\phi)');
title('Triangular-Grid Array Radiation Pattern', 'Uniform Tapering - Dipole');
grid on;
axis tight; 

figure;
contourf(u, v, tapered);
[u1, v1] = find(tapered == max(tapered, [], "all"));
hold on;
plot(u0, v0, 'ro'); % Plotting the point (u0, v0). Expected main lobe
plot(u(u1, u1), v(v1, v1), 'bo'); % Plotting the point (u1, v1). Actual main lobe
hold off;
shading interp;
xlabel('u (sin\theta cos\phi)');
ylabel('v (sin\theta sin\phi)');
title('Triangular-Grid Array Radiation Pattern', 'Cosine-Squared Tapering');
grid on;
axis tight; 

figure;
contourf(u, v, taperedDipole);
[u1, v1] = find(taperedDipole == max(taperedDipole, [], "all"));
hold on;
plot(u0, v0, 'ro'); % Plotting the point (u0, v0). Expected main lobe
plot(u(u1, u1), v(v1, v1), 'bo'); % Plotting the point (u1, v1). Actual main lobe
hold off;
shading interp;
xlabel('u (sin\theta cos\phi)');
ylabel('v (sin\theta sin\phi)');
title('Triangular-Grid Array Radiation Pattern', 'Cosine-Squared Tapering - Dipole');
grid on;
axis tight; 

figure;
subplot(2, 2, 1);
contourf(u, v, notTaperedDipoleCo);
hold on;
plot(u0, v0, 'ro'); % Plotting the point (u0, v0)
hold off;
shading interp;
xlabel('u (sin\theta cos\phi)');
ylabel('v (sin\theta sin\phi)');
title({'Triangular-Grid Array Radiation Pattern', 'Uniform Tapering', 'Dipole - Co-polarization Component'});
grid on;
axis tight;

% subplot(2, 2, 2);
% contourf(u, v, taperedDipoleCo);
% hold on;
% plot(u0, v0, 'ro'); % Plotting the point (u0, v0)
% hold off;
% shading interp;
% xlabel('u (sin\theta cos\phi)');
% ylabel('v (sin\theta sin\phi)');
% title({'Triangular-Grid Array Radiation Pattern', 'Cosine-Squared Tapering', 'Dipole - Co-polarization Component'});
% grid on;
% axis tight;

% figure;
subplot(2, 2, 2);
contourf(u, v, notTaperedDipoleCross);
hold on;
plot(u0, v0, 'ro'); % Plotting the point (u0, v0)
hold off;
shading interp;
xlabel('u (sin\theta cos\phi)');
ylabel('v (sin\theta sin\phi)');
title({'Triangular-Grid Array Radiation Pattern', 'Uniform Tapering', 'Dipole - Cross-polarization Component'});
grid on;
axis tight;

% subplot(2, 2, 2);
% contourf(u, v, taperedDipoleCross);
% hold on;
% plot(u0, v0, 'ro'); % Plotting the point (u0, v0)
% hold off;
% shading interp;
% xlabel('u (sin\theta cos\phi)');
% ylabel('v (sin\theta sin\phi)');
% title({'Triangular-Grid Array Radiation Pattern', 'Cosine-Squared Tapering', 'Dipole - Cross-polarization Component'});
% grid on;
% axis tight;

figure;
contourf(u, v, electricDipoleRadPattern(u, v, "full") ./ max(electricDipoleRadPattern(u, v, "full"), [], "all"));
shading interp;
xlabel('u (sin\theta cos\phi)');
ylabel('v (sin\theta sin\phi)');
title('Dipole Radiation Pattern');
grid on;
axis tight; 
