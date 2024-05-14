function BW = linearArrayBeamwidth(y, theta)
    % Find the maximum value of the radiation pattern
    maxVal = max(y);
    
    % Find the indices where the radiation pattern is greater than or equal to 3 dB below the maximum value
    indices = find(y >= maxVal - 3);
    
    % Calculate the beamwidth as the difference between the maximum and minimum indices
    % theta(indices(end))
    % theta(indices(1))
    BW = rad2deg(theta(indices(end)) - theta(indices(1)));
end