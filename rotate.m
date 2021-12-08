function [xr, yr, zr] = rotate(x,y,z,xyz0,theta,f,axis)
    s = size(x);
    theta = f*theta;
    
    xr = zeros(s);
    yr = zeros(s);
    zr = zeros(s);
    
    if axis == 'x'
        rot = [1 0 0; 0 cosd(theta) -sind(theta); 0 sind(theta) cosd(theta)];
    elseif axis == 'y'
        rot = [cosd(theta) 0 sind(theta); 0 1 0; -sind(theta) 0 cosd(theta)];
    else
        rot = [cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
    end
    
    for i=1:1:s(1)
        for j=1:1:s(2)
            xyz_rot = [x(i,j)-xyz0(1) y(i,j)-xyz0(2) z(i,j)-xyz0(3)]*rot;
            
            xr(i,j) = xyz_rot(1)+xyz0(1);
            yr(i,j) = xyz_rot(2)+xyz0(2);
            zr(i,j) = xyz_rot(3)+xyz0(3);

        end
    end
end