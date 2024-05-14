function S = triangularArrayRadPattern(Nx, Ny, dx, dy, f, u0, v0, taperingFunction)
    % Nx, Ny: number of elements in x and y direction
    % dx, dy: distance between elements in x and y direction
    % f: frequency
    % theta0, phi0: direction of main beam

    c = 3e8;
    lambda = c/f;
    k = 2*pi/lambda;

    [u, v] = meshgrid(-1:0.01:1, -1:0.01:1);

    S = zeros(size(u));
    for r = 1:Nx
        for l = 1:Ny
            psi = (dx*(r-1)*u0 + dy*(l-1)*v0);
            if mod(l - 1, 2) == 0
                S = S + taperingFunction(r - Nx/2, Nx) * taperingFunction(l - Ny/2, Ny) * exp(1j * k * (dx*(r-1) * (u - u0) + dy*(l-1)*(v-v0)));
            else
                S = S + taperingFunction(r - Nx/2, Nx) * taperingFunction(l - Ny/2, Ny) * exp(1j * k * (dx*(r-1/2)*u + dy*(l-1)*v - psi));
            end
        end
    end

    S = abs(S);
    S = 10*log10(S / max(S, [], "all"));
    figure;
    contourf(u, v, S);
    xlabel('Theta (radians)');
    ylabel('Normalized Gain');
    title('Linear Array Radiation Pattern');
    grid on;
    axis tight;

end