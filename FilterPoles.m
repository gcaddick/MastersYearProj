

%  Program to calculate the Poles and Transfer function of an
%  nth order Butterworth filter and then calulate the C2 and
%  C4 capacitors for the filter for each section (number of sections
%  depend on the order) and then presents the data as a table for user
%  to implement into the full filter. Also the frequency response of the
%  system is found and plotted.

% George Caddick
% 22/5/21

% Variables Used within code
clear all
close all

j = 1;
i = 0;

n = 2; % Order desired
fc = 500; % Cut off Frequency
sf = 10000; % Scaling factor for capcitors and resistors
wc = 2*pi*fc; % Angular frequency

[J, H, eq_n] = Cal_tf(n,fc);
[T] = Cal_components(eq_n, wc, sf, n, H, fc);
simulating_tf(H,n);
FreqResp(H, fc, n); % Frequency response of calculated filter
