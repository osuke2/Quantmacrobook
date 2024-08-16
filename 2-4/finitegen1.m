clear;
clear global;
close all;
format short;

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
grid_a = linspace(a_min,a_max,na);

util2 = CRRA((1.0+rent).*grid_a, gamma);


% calculate all cases
obj = zeros(na, nw);

for i = 1:nw;
    for j = 1:na;
        cons = grid_w(i) - grid_a(j);
        if cons > 0.0
            obj (j,i) = CRRA(cons,gamma) + beta*CRRA((1+rent)*grid_a(j),gamma);
        else 
            obj (j,i) = -10000.0;
        end
    end
end

% policy function
pol = zeros(nw,1);
for i =1:nw
    [maxv, maxl] = max(obj(:,i)); % in i line,[the maximal index、the argument of that]
    pol(i) = grid_a(maxl); % change maxl as asset
    disp(['  maxv = ', num2str(maxv)]);
end
figure;
subplot(2,1,1);
plot(grid_w,pol, 'MarkerSize', 12, 'linewidth', 3);
xlabel('若年期の所得：w', 'Fontsize', 16);
ylabel('若年期の貯蓄：a', 'Fontsize', 16);
xlim([0, 1]);
ylim([0, 0.4]);
set(gca, 'Fontsize', 16);
grid on;
hold on;
subplot(2,1,2);
plot(grid_a,util2,'-o','color','red','MarkerEdgeColor','r','MarkerSize',12,'linewidth',3);
xlabel('老年期の資産','Fontsize',16);
ylabel('老年期の効用','Fontsize',16);
xlim([a_min,a_max]);
set(gca,'Fontsize',8);
grid on;
hold off;
      

       

