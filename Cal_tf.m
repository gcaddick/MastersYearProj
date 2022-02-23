
% Calculates the poles, the polynomial of the denominator for the transfer
% function and the new coefficients according to s=s/wc
%
% Outputs these coeffiecients as an array, H

% George Caddick
% 25/5/21

function [J, H, eq_n] = Cal_tf(n, fc)
j = 1;
i = 0;

[~,p,~]=buttap(n); % Calulates the zeros, z, the poles, p, and the gain ,k.
wc = 2*pi*fc; % Angular frequency
% Seperates the poles into pairs and calculates the polynomial from
% the pole pairs

if mod(n,2) == 0
    
    eq_n = zeros(n/2, 3);
    for i = 1:2:n
        p_n = p(i:i+1);
        eq_n(j,:) = poly(p_n); 
        j = j + 1;
    end

    tf_coef = 1;

    % Mulitples all the polynomials to gain the denominator
    % of the system trasnfer function
    for j=1:n/2
        tf_coef = conv(tf_coef, eq_n(j,:));
    end

    m = length(tf_coef);
    g = 1;

    % Calulates the new coefficients using s=s/wc
    for i = m-1:-1:0
        wc_n(g) = wc^i;   
        H(g) = tf_coef(g)/wc_n(g);
        g = g + 1;
    end    
    
    
end

if mod(n,2) ~= 0
    
    eq_n = zeros((n+1)/2, 3); % If odd, this will correct for odd n
    
    for i = 1:2:n-1 % If odd, this will correct for odd n
        p_n = p(i:i+1);
        eq_n(j,:) = poly(p_n); 
        j = j + 1;
    end
    
    eq_n(j,2:3) = poly(p(n));

    tf_coef = 1;

    % Mulitples all the polynomials to gain the trasnfer function
    for j=1:n/2
        tf_coef = conv(tf_coef, eq_n(j,:));
    end
    
    % If odd, s^2 equals zero for final polynomial,
    % therefore above equation will cause final s^n-1 
    % coeff to be zero, this work around removes odd
    % order s^2 coeff.
    tf_coef = conv(tf_coef, eq_n(size(eq_n,1),2:3));
    
    m = length(tf_coef);
    g = 1;

    % Calulates the new coefficients using s=s/wc
    for i = m-1:-1:0
        wc_n(g) = wc^i;   
        H(g) = tf_coef(g)/wc_n(g);
        g = g + 1;
    end   
end
J = H';
end



