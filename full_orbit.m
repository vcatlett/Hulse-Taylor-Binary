function [o1, o2] = full_orbit(p10, p20, ax_a, ax_b, m_d, com, t_o, d_theta, d_r)
    x1p = zeros(360,1);
    y1p = zeros(360,1);
    z1p = zeros(360,1);
    x2p = zeros(360,1);
    y2p = zeros(360,1);
    z2p = zeros(360,1);
    
    for t = 1:1:360
        [pos1_p, pos2_p, shift1_p, shift2_p] = binary_orbit_evolving(t, p10, p20, ax_a, ax_b, m_d, com, d_theta, d_r);
        x1p(t) = pos1_p(1);
        y1p(t) = pos1_p(2);
        z1p(t) = pos1_p(3);

        x2p(t) = pos2_p(1);
        y2p(t) = pos2_p(2);
        z2p(t) = pos2_p(3);
    end
    
    o1 = [x1p, y1p, z1p];
    o2 = [x2p, y2p, z2p];
end