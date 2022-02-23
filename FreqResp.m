
% Calculates the frequency response of transfer function 1/H
% 
% Outputs these as figure 20,21 and 22
% 
% Figure 20 shows the Bode plot of the system
% 
% Figure 21 shows the response of the system in terms of frequency in Hz 
% and magnitude in dB
% 
% Figure 22 shows the response in terms of absolute magnitude and 
% frequency in Hz
%
% figure 23 shows the group delay vs normalised frequency

% George Caddick
% 25/5/21

function FreqResp(H, fc, n)
l = tf(1, H);
[mag, phase, wout] = bode(l);

figure(20);
bode(l);
grid on
title("Bode Plot of "+num2str(n)+...
    "th order butterworth filter, with a cut of frequency of "...
    +num2str(fc)+"Hz")

figure(21);
semilogx((wout/(2*pi)), (20*log10(abs(squeeze(mag)))));
grid on
xlabel("Frequency, Hz");
ylabel("Magnitude, dB")
title("Plot of "+num2str(n)+...
    "th order butterworth filter, with a cut of frequency of "...
    +num2str(fc)+"Hz")
tit_21 = ("log_dBvsFreq_of_"+num2str(n)+"th.jpg");
saveas(figure(21), tit_21);

figure(22);
plot((wout/(2*pi)), (20*log10(abs(squeeze(mag)))));
xlim([0 1500])
grid on
xlabel("Frequency, Hz");
ylabel("Magnitude, dB")
title("Plot of "+num2str(n)+...
    "th order butterworth filter, with a cut of frequency of "...
    +num2str(fc)+"Hz")
tit_22 = ("dBvsFreq_of_"+num2str(n)+"th.jpg");
saveas(figure(22), tit_22);

figure(23);
[gd, w] = grpdelay(1, H);
plot(w/pi, gd);
title(["Shows the Group delay of the "+num2str(n)+"th order filter"])
ylabel("Group Delay (samples)")
xlabel("Normalised Freqency (\times\pi rad/sample)")
grid on
tit_23 = ("GroupDelay_of_"+num2str(n)+"th.jpg");
saveas(figure(23), tit_23);

end
