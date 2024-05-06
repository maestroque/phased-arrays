function y = triangularArrayRadPattern(Nx, Ny, dx, dy, f, theta0, phi0)
    % Nx, Ny: number of elements in x and y direction
    % dx, dy: distance between elements in x and y direction
    % f: frequency
    % theta0, phi0: direction of main beam
    
    c = 3e8;
    lambda = c/f;
    
    % Calculate the position of each element
    x = (0:Nx-1)*dx;
    y = (0:Ny-1)*dy;
    [X, Y] = meshgrid(x, y);
    
    % Calculate the distance from each element to the origin
    R = sqrt(X.^2 + Y.^2);
    
    % Calculate the angle of each element
    theta = atan2(R, ones(Ny, Nx)*R(1, 1));
    phi = atan2(Y, X);
    
    % Calculate the phase difference between each element and the first
    % element
    delta = 2*pi/lambda*(R.*cos(theta)*cos(phi0)*sin(theta0) + R.*sin(theta)*sin(phi));
    
    % Calculate the array factor
    AF = 1/Nx/Ny*sum(exp(1i*delta), 'all');
    
    % Calculate the radiation pattern
    y = abs(AF);

    surf(X, Y, y)

end