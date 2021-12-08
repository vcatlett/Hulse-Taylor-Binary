set(0,'defaultfigurecolor','k');
h3 = figure();
hold on;
set(gca,'Color','k');
xlabel('X');
ylabel('Y');
tmax = 125;
xlim([0 tmax]);
ylim([-0.25 1.25]);
gifname = 'Earth_Pulsar_Signal.gif';

ft = @(t) max(sind(9.*t-100)*mod(ceil((9.*t-100)/90),2),0)+rand(1)/10;
ft0 = zeros(tmax+1,1);

for t = 0:1:tmax
   
    disp(t);
    t0 = 0:1:t;
    ft0(t+1) = ft(t);
    
    plot(t0, ft0(1:t+1), '-cyan','LineWidth',3);

    % Write to the GIF File 
    frame = getframe(h3); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256);
    if t == 0 
      imwrite(imind,cm,gifname,'gif', 'Loopcount',inf); 
    else 
      imwrite(imind,cm,gifname,'gif','DelayTime',3*4/tmax,'WriteMode','append'); 
    end
end
hold off;