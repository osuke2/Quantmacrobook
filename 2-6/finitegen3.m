clear;
clear global;
close all;

global dim_app nw grid_w beta gamma rent

beta  = 0.985.^30;     
gamma = 2.0;           
rent  = 1.025.^30-1.0; 

nw    =  10;  
w_max = 1.0;  
w_min = 0.1;  


disp(' ');
disp('-+-+-+- Solve two period model using projection method -+-+-+-');

grid_w = linspace(w_min, w_max, nw)';

dim_app = 1;

coef_ini = [0.1, 0.35];

options = optimoptions('fsolve','Algorithm','levenberg-marquardt','MaxFunctionEvaluations',1000);

coef = fsolve(@resid_projection, coef_ini, options);

disp(' ');
disp('approximated theta0');
disp(coef(1));
disp('approximated theta1');
disp(coef(2));

coef1 = (beta*(1+rent))^(-1/gamma);
coef2 = 1.0/(1.0+coef1*(1+rent));

icept = 0.0;
slope = coef2;

disp(' ');
disp('true theta0');
disp(icept);
disp('true theta1');
disp(slope);

next_a = policy(coef, grid_w);

figure;
plot(grid_w,next_a,'-o','color','black','MarkerEdgeColor','k','MarkerSize',12,'linewidth',3);
xlabel('若年期の所得','Fontsize',16);
ylabel('若年期の貯蓄','Fontsize',16);
xlim([0,w_max]);
ylim([0,0.5]);
set(gca,'Fontsize',16);
grid on;


return;