function a = cosineSquaredTapering(y, Ny)
    if abs(y) >= Ny/2
        a = 0;
    else
        a = cos(pi*y/Ny) .^ 2;
    end
end