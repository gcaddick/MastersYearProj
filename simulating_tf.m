
% Simulates the response, using simulink of the nth order filter
% with cut off frequency of fc
% Outputs displayed a plots of amplitude versus time, displaying
% the filtered signal and the non-filtered signal

% George Caddick
% 25/5/21

function simulating_tf(H,n)

options = simset('SrcWorkspace','current');
TransFcn = H;
Freqs_checked = [200, 500, 800, 5000]';
for i=1:4
    frequency = Freqs_checked(i);
    sim('sim_tf',[], options);
    figure(i);
    plot(ans.tout, ans.Signal);
    hold on 
    plot(ans.tout, ans.SignalFiltered);
    xlabel("Time (s)");
    ylabel("Amplitude");
    ylim([-1.5 1.5]);
    
    title("Shows the signal filtered and not filtered at a frequency of "...
        +num2str(frequency)+"Hz");
    legend("UnFiltered", "Filtered");
    tit = (num2str(n)+"th_Order_at_"+num2str(frequency)+"Hz.jpg");
    saveas(gcf, tit);
    
end
assignin('base', 'ans', ans);
hold off
end