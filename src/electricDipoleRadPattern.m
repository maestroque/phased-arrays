function y = electricDipoleRadPattern(u, v, polarization)
    if polarization == "full"
        y = (u .^ 2 - u .^ 4 - u .^ 2 * v .^ 2 + v .^ 2) ./ (u .^ 2 + v .^ 2);
        y(isinf(y)) = 4.1e5;
    elseif polarization == "co"
        y = (u .^ 2 - u .^ 4 - u .^ 2 * v .^ 2) ./ (u .^ 2 + v .^ 2);
        y(isinf(y)) = 4.1e5;
    elseif polarization == "cross"
        y = v .^ 2 ./ (u .^ 2 + v .^ 2);
        y(isinf(y)) = 4.1e5;
    end
end