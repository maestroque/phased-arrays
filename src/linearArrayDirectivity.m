function D = linearArrayDirectivity(arrayPattern, theta)
    D = 10*log10(2 ./ (sum(arrayPattern .^ 2 .* cos(theta) * (theta(2) - theta(1)))));
end