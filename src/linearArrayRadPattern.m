function y = linearArrayRadPattern(Ny, dy, f, theta, theta0, taperingFunction, elementRadPattern)
    c = 3e8;
    lambda = c/f;
    k = 2*pi/lambda;
    
    y = zeros(1, length(theta));
    for i = 1:Ny
        y = y + taperingFunction(i - Ny/2, Ny) * elementRadPattern(theta) .* exp(1j*k*(i-1)*dy*sin(theta-theta0));
    end
    y = abs(y);
    y = 20*log10(y/max(y));
end