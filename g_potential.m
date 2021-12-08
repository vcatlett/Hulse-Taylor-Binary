function [x,y,z] = g_potential(G, m, x0, y0, lim, n, norm)
    %intx = linspace(x0(1)-lim, y0(1)+lim, n);
    %inty = linspace(x0(2)-lim, y0(2)+lim, n);
    intx = linspace(-lim, lim, n);
    inty = linspace(-lim, lim, n);
    [x, y] = meshgrid(intx, inty);
    sm = size(m);
    s = size(x);
    z = zeros(s);
    
    for k=1:1:sm(2)
        for i=1:1:s(2)
            for j=1:1:s(2)
                r_ij = sqrt(((x(i,j)-x0(k))^2)+((y(i,j)-y0(k))^2));
                z(i,j) = z(i,j) - G.*m(k)./r_ij;
            end
        end
    end
    
    c_norm = abs(min(min(z)));
    z = z.*norm.*1E-21;%./c_norm;
end