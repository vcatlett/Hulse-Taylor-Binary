function [X,Y,Z] = cone(n, xyz0, theta_jet, h)
    r = linspace(0,1, n) ;
    th = linspace(0,2*pi, n) ;
    [R,T] = meshgrid(r,th) ;
    X = R.*cos(T) + xyz0(1);
    Y = R.*sin(T) + xyz0(2);
    Z = R*h + xyz0(3);
    
    [X, Y, Z,] = rotate(X, Y, Z, xyz0, theta_jet, 1, 'x');
    [X, Y, Z,] = rotate(X, Y, Z, xyz0, theta_jet, 1, 'y');
end