function y = linearArrayRadPattern(Ny, dy, f, theta0, taperingFunction, elementRadPattern)
    c = 3e8;
    lambda = c/f;
    k = 2*pi/lambda;
    theta = linspace(-pi/2, pi/2, 1000);
    y = zeros(1, length(theta));
    for i = 1:Ny
        y = y + taperingFunction(i - Ny/2, Ny) * elementRadPattern(theta) * exp(1j*k*(i-1)*dy*sin(theta-theta0));
    end
    y = abs(y);
    y = 20*log10(y/max(y));
end