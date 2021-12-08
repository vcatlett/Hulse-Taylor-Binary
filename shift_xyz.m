function [x1, y1, z1] = shift_xyz(x, y, z, shift)
    x1 = x+shift(1);
    y1 = y+shift(2);
    z1 = z+shift(3);
end