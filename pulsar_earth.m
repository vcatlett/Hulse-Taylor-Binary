clc;

x1p = zeros(360,1);
y1p = zeros(360,1);
x2p = zeros(360,1);
y2p = zeros(360,1);

%%% VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(0,'defaultfigurecolor','k');
h = figure;
hold on

gifname = 'Earth_Pulsar.gif';
texture1 = imread('star_surface.png');  % pulsar
texture1j = imread('jet_surface.png'); % pulsar jets
texture2 = imread('earth_surface.png');  % companion

n_cone = 50;       % number of cone points
h_cone = 50;       % height of cone
n_gpot = 100;       % number of g-potential points
plot_lim = 30;     % axis limits
m_d = 5;           % distance multiplier
view(15,30);       % viewing angle (alt, az) (0,90) for top view

%%% CONSTANTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_sol = 2E30;      % mass of Sun (kg)
r_sol = 6.957E8;   % radius of Sun (m)
G = 6.67E-11;      % gravitational constant (N kg-2 m2)

%%% PULSAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1 = 1.4398*m_sol; % stellar mass (kg)
r1 = 5;            % stellar radius (m)
p10 = [-10 0 0];   % starting position (saved) (origin = COM)
pos1 = [-10 0 0];  % position (changes)
theta_jet = 40;    % angle between rotation axis and jet (deg)
f_s1 = 18;          % rotation frequency (Hz) (true=16.9405)

%%% COMPANION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m2 = 1.3886*m_sol;   % stellar mass (kg)
m2_r = m2/(m1+m2);   % proportion of total mass
x20 = -m_d*(1-m2_r); % starting position (origin = COM)
r2 = 5;              % stellar radius (m)
p20 = [10 0 10];     % starting position (saved)
pos2 = [10 0 10];    % position (changes)

%%% BINARY ORBIT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_b = 7.75;                    % orbital period (hr)
e_b = 0.6171334;               % eccentricity
ax_a = 1950100;                % semi-major axis (km)
ax_b = ax_a*sqrt(1-e_b^2);     % semi-minor axis (km)
p_sep = 746600;                % periastron separation (km)
a_sep = 3153600;               % apastron separation (km)
p_v = 450;                     % Orbital v at per. relative to COM (km/s)
a_v = 110;                     % Orbital v at ap. relative to COM (km/s)

%%% STUFF FOR PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,y,z] = sphere;

% Pulsar
x10 = x.*r1 + pos1(1);
y10 = y.*r1 + pos1(2);
z10 = z.*r1 + pos1(3);

x1 = x.*r1 + pos1(1);
y1 = y.*r1 + pos1(2);
z1 = z.*r1 + pos1(3);

% Companion
x2 = x.*r2 + pos2(1);
y2 = y.*r2 + pos2(2);
z2 = z.*r2 + pos2(3);

% Jets
[cx10, cy10, cz10] = cone(n_cone, p10, theta_jet, h_cone);
cx20 = 2*p10(1)-cx10;
cy20 = 2*p10(2)-cy10;
cz20 = 2*p10(3)-cz10;

[cx1, cy1, cz1] = cone(n_cone, p10, theta_jet, h_cone);
cx2 = 2*p10(1)-cx1;
cy2 = 2*p10(2)-cy1;
cz2 = 2*p10(3)-cz1;


for t = 0:10:360
    
    % Keep track of things
    disp(t);
    
    % Reset figure
    clf;
    hold on
    view(15,30);
    set(gca,'Color','k');
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    xlim([-plot_lim plot_lim]);
    ylim([-plot_lim plot_lim]);
    zlim([-plot_lim plot_lim]);
    plot(x1p, y1p, 'r');
    plot(x2p, y2p, 'r');

    
    % Rotate the stars
    [x1, y1, z1] = rotate(x10, y10, z10, p10, t, 1, 'z');
    [cx1, cy1, cz1] = rotate(cx10, cy10, cz10, p10, t, 1, 'z');
    [cx2, cy2, cz2] = rotate(cx20, cy20, cz20, p10, t, 1, 'z');
    
    % Calculate and plot gravitational potential
    %[xg,yg,zg] = g_potential(G, [m1, m2], [pos1(1), pos2(1)], [pos1(2), pos2(2)], plot_lim, n_gpot, 50);
    
    % Plot the rotated pulsar
    %g1 = surf(xg,yg,zg,'FaceColor','b','FaceAlpha',0.5,'EdgeColor','b','EdgeAlpha',0.55);
    p1 = surf(x1, y1, z1, flipud(texture1),'FaceColor','texturemap','EdgeColor','none');
    j1a = surf(cx1, cy1, cz1, flipud(texture1j),'FaceColor','texturemap','FaceAlpha',0.5,'EdgeColor','none');
    j1b = surf(cx2, cy2, cz2, flipud(texture1j),'FaceColor','texturemap','FaceAlpha',0.5,'EdgeColor','none');
    
    % Plot the companion
    p2 = surf(x2, y2, z2, flipud(texture2),'FaceColor','texturemap','EdgeColor','none');
    
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256);
    
    % Write to the GIF File 
    if t == 0 
      imwrite(imind,cm,gifname,'gif', 'Loopcount',inf); 
    else 
      imwrite(imind,cm,gifname,'gif','DelayTime',0.1,'WriteMode','append'); 
    end
    hold off
end