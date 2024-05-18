function BW = linearArrayBeamwidth(y, theta)
    maxVal = max(y);
    indices = find(y >= maxVal - 3);
    BW = rad2deg(theta(indices(end)) - theta(indices(1)));
end