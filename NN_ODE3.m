% Main script: Solving ODE using Neural Networks
clear all; close all;

%% Problem Definition
% ODE: dΨ/dx = e^(-2x) - 2Ψ
% Initial condition: Ψ(0) = 0.1
% Domain: x ∈ [0, 2]

%% Initial condition
A = 0.1;

%% Network Parameters
N = 5;          % Number of hidden neurons
learning_rate = 0.01;
max_its = 10000;
tol = 1e-5;

%% Initialize Network Parameters
% Random initialization with Xavier/Glorot initialization
rng(42); % For reproducibility
v = randn(N, 1) * sqrt(2/1);  % Input weights
v2 = randn(N, 1) * sqrt(2/1);  % Input weights
theta = randn(N, 1) * sqrt(2/1);  % Hidden biases
theta2 = randn(N, 1) * sqrt(2/1);  % Hidden biases
w = randn(N, 1) * sqrt(2/N);  % Output weights

%% Generate Training Points
nx = 50;
xgrid = linspace(0, 2, nx)';

%% Training Loop
tic;
fprintf('Training Neural Network...\n');
for it = 1:max_its
    % Forward Pass
    [Psi, dPsi] = forward_pass(xgrid, v, v2, theta, theta2, w, A);
    
    % Compute Target (from RHS of ODE)
    target = exp(-2*xgrid) - 2*Psi;
    
    % Compute Error
    error = mean((dPsi - target).^2);
    
    if mod(it, 1000) == 0
        fprintf('it %d: Error = %.6f\n', it, error);
    end
    
    if error < tol
        break;
    end
    
    % Backpropagation (using numerical gradients for simplicity)
    [grad_v, grad_v2, grad_theta, grad_theta2, grad_w] = compute_gradients(xgrid, v, v2, theta, theta2, w, target, A);
    
    % Update Parameters
    v = v - learning_rate * grad_v;
    v2 = v2-learning_rate * grad_v2;
    theta = theta - learning_rate * grad_theta;
    theta2 = theta2 - learning_rate * grad_theta2;
    w = w - learning_rate * grad_w;
end
toc;
%% Evaluate and Plot Results
nx_test = 50;
x_test = linspace(0, 2, nx_test)';
[Psi_nn, ~] = forward_pass(x_test, v, v2, theta, theta2, w, A);

% Compute analytical solution
Psi_analytical = exp(-2*x_test).*(x_test + 0.1);

% Plotting
figure('Position', [100, 100, 1200, 400]);

plot(x_test, Psi_nn, 'b-', 'LineWidth', 2);
hold on;
plot(x_test, Psi_analytical, 'r--', 'LineWidth', 2);
xlabel('x');
ylabel('\Psi(x)');
title('Solution Comparison');
legend('Neural Network', 'Analytical');
grid on;

figure('Position', [100, 100, 1200, 400]);
error = abs(Psi_nn - Psi_analytical);
plot(x_test, error, 'k-', 'LineWidth', 2);
xlabel('x');
ylabel('Absolute Error');
title('Error Analysis');
grid on;

%% Helper Functions
function [Psi, dPsi] = forward_pass(x, v, theta, v2, theta2, w, A)
    N = length(v);
    n_points = length(x);
    
    x_broadcast = repmat(x, 1, N);  % [n_points × N]
    v_broadcast = repmat(v', n_points, 1);
    v2_broadcast = repmat(v2', n_points, 1);
    theta_broadcast = repmat(theta', n_points, 1);
    theta2_broadcast = repmat(theta2', n_points, 1);

    z = v_broadcast .* x_broadcast + theta_broadcast;
    y = sigmoid(z);  
    
    dydx = v_broadcast .* sigmoid_derivative(z);  

    z2 = v2_broadcast .* y + theta2_broadcast; 
    y2 = sigmoid(z2);
    dy2dx = sigmoid_derivative(z2) .* v2_broadcast .* dydx;
   

    Nx = y2 * w;
    dNdx = dy2dx * w;
    

    Psi = A + x .* Nx;  % [n_points × 1]
    dPsi = Nx + x .* dNdx;  % [n_points × 1]    
end

function [grad_v, grad_v2,grad_theta, grad_theta2, grad_w] = compute_gradients(x, v, v2, theta, theta2, w, target, A)
    % Compute gradients using numerical differentiation
    epsilon = 1e-6;
    N = length(v);
    grad_v = zeros(size(v));
    grad_v2 = zeros(size(v));
    grad_theta = zeros(size(theta));
    grad_theta2 = zeros(size(theta));
    grad_w = zeros(size(w));


    % Gradient for v
    for i = 1:N
        v_plus = v; v_plus(i) = v_plus(i) + epsilon;
        v_minus = v; v_minus(i) = v_minus(i) - epsilon;
        [~, dPsi_plus] = forward_pass(x, v_plus, v2, theta, theta2, w, A);
        [~, dPsi_minus] = forward_pass(x, v_minus, v2, theta, theta2, w, A);
        grad_v(i) = mean((dPsi_plus - target).^2 - (dPsi_minus - target).^2) / (2*epsilon);
        v2_plus = v2; v2_plus(i) = v2_plus(i) + epsilon;
        v2_minus = v; v2_minus(i) = v2_minus(i) - epsilon;
        [~, dPsi2_plus] = forward_pass(x, v, v2_plus, theta, theta2, w, A);
        [~, dPsi2_minus] = forward_pass(x, v, v2_minus, theta, theta2, w, A);
        grad_v2(i) = mean((dPsi2_plus - target).^2 - (dPsi2_minus - target).^2) / (2*epsilon);
    end
    
    % Gradient for theta
    for i = 1:N
        theta_plus = theta; theta_plus(i) = theta_plus(i) + epsilon;
        theta_minus = theta; theta_minus(i) = theta_minus(i) - epsilon;
        [~, dPsi_plus] = forward_pass(x, v, v2, theta_plus, theta2, w, A);
        [~, dPsi_minus] = forward_pass(x, v, v2, theta_minus, theta2, w, A);
        grad_theta(i) = mean((dPsi_plus - target).^2 - (dPsi_minus - target).^2) / (2*epsilon);
        theta2_plus = theta; theta2_plus(i) = theta2_plus(i) + epsilon;
        theta2_minus = theta; theta2_minus(i) = theta2_minus(i) - epsilon;
        [~, dPsi2_plus] = forward_pass(x, v, v2, theta, theta2_plus, w, A);
        [~, dPsi2_minus] = forward_pass(x, v, v2, theta, theta2_minus, w, A);
        grad_theta2(i) = mean((dPsi2_plus - target).^2 - (dPsi2_minus - target).^2) / (2*epsilon);
    end
    
    % Gradient for w
    for i = 1:N
        w_plus = w; w_plus(i) = w_plus(i) + epsilon;
        w_minus = w; w_minus(i) = w_minus(i) - epsilon;
        [~, dPsi_plus] = forward_pass(x, v, v2, theta, theta2, w_plus, A);
        [~, dPsi_minus] = forward_pass(x, v, v2, theta, theta2, w_minus, A);
        grad_w(i) = mean((dPsi_plus - target).^2 - (dPsi_minus - target).^2) / (2*epsilon);
        
    end
end

function y = sigmoid(x)
    y = 1 ./ (1 + exp(-x));
end

function dy = sigmoid_derivative(x)
    s = sigmoid(x);
    dy = s .* (1 - s);
end