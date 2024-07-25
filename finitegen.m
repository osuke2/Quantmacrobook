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

figure;
plot(grid_a,util2,'-o','color','red','MarkerEdgeColor','r','MarkerSize',12,'linewidth',3);
xlabel('老年期の資産','Fontsize',16);
ylabel('老年期の効用','Fontsize',16);
xlim([a_min,a_max]);
set(gca,'Fontsize',8);
grid on;

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


      

       

