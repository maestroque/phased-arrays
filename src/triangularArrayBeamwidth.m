function [BW_t, BW_p] = triangularArrayBeamwidth(y, u, v, u0, v0)
    [u0_index, v0_index] = find(y == 0);
    u_indices = find(y(v0_index, :) >= - 3);
    v_indices = find(y(:, u0_index) >= - 3);

    u_min = u(u_indices(1), u_indices(1));
    u_max = u(u_indices(end), u_indices(end));
    v_min = v(v_indices(1), v_indices(1));
    v_max = v(v_indices(end), v_indices(end));
    
    % Lambda to transpose from u-v to theta-phi
    uv2tp = @(u, v) [rad2deg(asin(sqrt(u.^2 + v.^2))), rad2deg(atan2(v, u))];

    a1 = uv2tp(u0, v_min);
    a2 = uv2tp(u0, v_max);
    a3 = uv2tp(u_min, v0);
    a4 = uv2tp(u_max, v0);
    a = [a1; a2; a3; a4];

    BW_t = max(a(:, 1)) - min(a(:, 1))
    BW_p = max(a(:, 2)) - min(a(:, 2))
end