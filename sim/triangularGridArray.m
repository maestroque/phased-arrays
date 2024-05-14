addpath ..\src\
clear all;

c = 3e8;
f0 = 7.5e9;
lambda0 = c / f0;
theta0 = deg2rad(10);
phi0 = deg2rad(45);
Nx = 22;
Ny = 18;
dx = 0.7 * lambda0;
dy = 0.525 * lambda0;

noTapering = @(y, Ny) 1;

triangularArrayRadPattern(Nx, Ny, dx, dy, f0, sin(theta0)*cos(phi0), sin(theta0)*sin(phi0), noTapering);   
triangularArrayRadPattern(Nx, Ny, dx, dy, f0, sin(theta0)*cos(phi0), sin(theta0)*sin(phi0), @cosineSquaredTapering);   
