function D = triangularArrayDirectivity(arrayPattern, u, v)
    visiblePatternPow = 10 .^ (arrayPattern(hypot(u, v) <= 1) ./ 20);
    dsum = sum(visiblePatternPow .^ 2 .* (u(2, 2) - u(1, 1)) .* (v(2, 2) - v(1, 1)));
    D = 10*log10(4*pi / dsum)
end