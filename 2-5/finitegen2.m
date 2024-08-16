clear;
clear global;
close all;
format short;

global w beta gamma rent

beta = 0.985.^30;
gamma = 2.0;
rent = 1.025.^30-1.0;

nw = 10;
w_max = 10;
w_min =0.1;
na = 40;
a_max = 1.0;
a_min = 0.025;

grid_w = linspace(w_min,w_max,nw);
%貯蓄並べる
a_gs = zeros(nw,1);
%探す、パッケージでeasy!
for i = 1:nw
    w = grid_w(i);
    [a_gs(i),fval] = fminbnd(@obj_two_period,w*0.01, w*2.0);
end

a_ss = zeros(nw,1);

for i = 1:nw
    w = grid_w(i);
    % 0.0は初期値：詳細は"help fminsearch"
    [a_ss(i), fval] = fminsearch(@obj_two_period, 0.0);
end
figure;
plot(grid_w, a_gs, '-o', 'MarkerSize', 12, 'linewidth', 3); hold('on');
plot(grid_w, a_ss, '--d', 'MarkerSize', 12, 'linewidth', 3); hold('off');
xlabel('若年期の所得：w', 'Fontsize', 16);
ylabel('若年期の貯蓄：a', 'Fontsize', 16);
xlim([0, w_max]);
ylim([0, 0.4]);
legend('fminbnd','fminsearch','Location','NorthWest');
set(gca, 'Fontsize', 16);
grid on;