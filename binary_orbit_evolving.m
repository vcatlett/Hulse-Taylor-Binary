function [p1, p2, shift1, shift2] = binary_orbit_evolving(t, xyz10, xyz20, a, b, s, com, d_theta, dr)
    a = a-dr*t;
    b = b-dr*t;
    
    disp(a);
    disp(b);

    m = s/a;
    x1 = m.*a.*cosd(t)-xyz10(1);
    y1 = m.*(b.*sind(t));
    z1 = m.*0;
    
    x2 = m.*a.*cosd(t+180)-xyz20(1);
    y2 = -m.*(b.*sind(t));
    z2 = m.*0;
    
    [x1, y1, z1] = rotate(x1, y1, z1, com, 0,1,'z');
    [x2, y2, z2] = rotate(x2, y2, z2, com, 45, 1, 'y');
    
    p1 = [x1, y1, z1];
    p2 = [x2, y2, z2];
    shift1 = [x1-xyz10(1), y1-xyz10(2), z1-xyz10(3)];
    shift2 = [x2-xyz20(1), y2-xyz20(2), z2-xyz20(3)];
end