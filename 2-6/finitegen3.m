clear;
clear global;
close all;

global dim_app nw grid_w beta gamma rent

beta  = 0.985.^30;     % 割引因子
gamma = 2.0;           % 相対的危険回避度
rent  = 1.025.^30-1.0; % 純利子率

nw    =  10;  % 所得グリッドの数
w_max = 1.0;  % 所得グリッドの最大値
w_min = 0.1;  % 所得グリッドの最小値

tic % 計算時間をカウント開始

disp(' ');
disp('-+-+-+- Solve two period model using projection method -+-+-+-');

grid_w = linspace(w_min, w_max, nw)';

dim_app = 1;

coef_ini = [0.1, 0.35];

options = optimoptions('fsolve','Algorithm','levenberg-marquardt','MaxFunctionEvaluations','1000')

coef = fsolve(@resid_projection, coef_ini, options);

disp(' ');
disp('approximated psi0');
disp(coef(1));
disp('approximated psi1');
disp(coef(2));

coef1 = (beta*(1+rent))^(-1/gamma);
coef2 = 1.0/(1.0+coef1*(1+rent));

icept = 0.0;
slope = coef2;

disp(' ');
disp('true psi0');
disp(icept);
disp('true psi1');
disp(slope);