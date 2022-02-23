
% Calculates the components required for the filter design desired
% Outputs results as table for user.
% Two methods are used, one in the i for loop and the second in 
% the z for loop. The first method values are saved in table T
% and the second is saved in table S.

% George Caddick
% 25/5/21

function [T] = Cal_components(eq_n, wc, sf, n, H, fc)

c4_n(:,1) = eq_n(:,2);
% Creates array where 
% Column one is the coeffs calculated before
% Column two is C4_old
% Column three is C2_old
% Column four is C4_new
% Column five is C2_new
% Rows dependent on the order (order/2)

z = length(c4_n(:,1));
% C4
comp_n(1:z,1) = 10*10^-9;
if mod(n,2) ~= 0
    % c4
    comp_n(z,3) = c4_n (z,1)/(2*pi*fc*comp_n(z,1));    
    z = z - 1;
end



for i = 1:length(c4_n(:,1))
    
    % Q factor = root(b)/a where the coeffs are from bs^2 + as + 1
    Q_factor(i, 1) = (sqrt(eq_n(i,1))/eq_n(i,2));
   
%     % Q = R3/R2
%     R2 = 10000;
%     Q_factor(i,2) = Q_factor(i,1)*R2;
    
    c4_n(i,2) = c4_n(i,1)/2; % Calculates c4_old
    c4_n(i,3) = 1/c4_n(i,2); % Calculates c2_old
    c4_n(i,4) = c4_n(i,2)/(sf*wc); % Calculates c4_new
    c4_n(i,5) = c4_n(i,3)/(sf*wc); % Calculates c2_new
    
    
    % New Method for components
    % c4 >= c2*(4bi/ai^2)
    % c4 set to 10nF
end

for i = 1:z
    % c4
    % comp_n(i,1) = 10*10^-9;
    % c2
    comp_n(i,2) = comp_n(i,1)*((4*eq_n(i,1))/eq_n(i,2)^2);
    
    % R2 = (ai*C2 - sqrt((ai^2)*(C2^2) - 4*bi*C1*C2))/(4*pi*fc*C1*C2)
    % R3 = (ai*C2 + sqrt((ai^2)*(C2^2) - 4*bi*C1*C2))/(4*pi*fc*C1*C2)
    
    % R2
    comp_n(i,3) = ((eq_n(i,2)*comp_n(i,2) - sqrt((eq_n(i,2)^2)*(comp_n(i,2)^2)...
        - 4*eq_n(i,1)*comp_n(i,1)*comp_n(i,2)))/(4*pi*fc*comp_n(i,1)*comp_n(i,2)));
   
    % R3
    comp_n(i,4) = ((eq_n(i,2)*comp_n(i,2) + sqrt((eq_n(i,2)^2)*(comp_n(i,2)^2)...
        - 4*eq_n(i,1)*comp_n(i,1)*comp_n(i,2)))/(4*pi*fc*comp_n(i,1)*comp_n(i,2)));
    
    
end

% Tabulating Results
% Resistors = ones(m,1)*sf/1000;
m = length(c4_n(:,1));
R2 = 10000; % R2 = 10kohms
r2 = ones(m,1)*R2/1000;
C2 = c4_n(:,5)*10^9;
C4 = c4_n(:,4)*10^9;

VarNames = ["Q Factor","R2(kOhm)", "R3(kOhm)", "C2 Values (nF)", "C4 Values (nF)"];
T = table(Q_factor(:,1),r2, r2, C2, C4);
T.Properties.VariableNames = VarNames;

% Saving component values and equation to spreadsheet.
name_comp = ("Components_for_"+num2str(n)+"th_order_using_M1.xlsx");
writetable(T, name_comp);

p = size(H, 2);
poly_mat = cell(2,p);
for i = 1:p 
    poly_mat(1,i) = ({"s^"+num2str(p-i)});
    poly_mat(2,:) = num2cell(H);   
end
name_eq = ("Equation_coeffs_for_"+num2str(n)+"th_order.xlsx");
writecell(poly_mat, name_eq);

comp_name = ["Q Factor", "C2 (nF)", "C4 (nF)", "R2 (kOhm)", "R3 (kOhm)"];
c4_new = comp_n(:,1).*10^9;
c2_new = comp_n(:,2).*10^9;
r2_new = comp_n(:,3)./10^3;
r3_new = comp_n(:,4)./10^3;

S = table(Q_factor(:,1), c2_new, c4_new, r2_new, r3_new);
S.Properties.VariableNames = comp_name;
name_comp = ("Components_for_"+num2str(n)+"th_order_using_M2.xlsx");
writetable(S, name_comp);

name_SC = ("Components_for_"+num2str(n)+"th_order_for_SwitchedCapacitor.xlsx");
comp_name_SC = ["Q Factor", "R2 (kOhm)", "R3 (kOhm)"];

for i = 1:length(c4_n(:,1))
    % Q = R3/R2
    R2 = 100000;
    Q_factor(i,2) = Q_factor(i,1)*R2;
end

r2 = ones(m,1)*R2/1000;
r3 = Q_factor(:,2)/1000;

S_C = table(Q_factor(:,1), r2, r3);
S_C.Properties.VariableNames = comp_name_SC;
writetable(S_C, name_SC);

end