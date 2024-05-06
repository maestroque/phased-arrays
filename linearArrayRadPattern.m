function y = linearArrayRadPattern(Ny, dy, f, theta0)
    c = 3e8;
    lambda = c/f;
    k = 2*pi/lambda;
    theta = linspace(-pi/2, pi/2, 1000);
    y = zeros(1, length(theta));
    for i = 1:Ny
        y = y + exp(1j*k*(i-1)*dy*lambda*sin(theta-theta0));
    end
    y = abs(y);
    y = y/max(y);
    figure;
    plot(theta, y);
    xlabel('Theta (radians)');
    ylabel('Normalized Gain');
    title('Linear Array Radiation Pattern');
    grid on;
    axis tight;
end