function S = triangularArrayRadPattern(Nx, Ny, dx, dy, f, u, v, u0, v0, taperingFunction, elementRadPattern, polarization)
    c = 3e8;
    lambda = c/f;
    k = 2*pi/lambda;

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

    S = abs(elementRadPattern(u, v, polarization) .* S);
    S = 20*log10(S / max(S, [], "all"));
end