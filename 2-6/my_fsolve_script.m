% 目的関数を定義
fun1 = @(x) x^2 - 4;

% 初期値の設定
x0 = 1;

% fsolveを使用して解を求める
solution = fsolve(fun1, x0);

% 結果を表示
disp(solution);

% 目的関数を定義（2変数の連立方程式）
fun2 = @(x) [x(1)^2 + x(2)^2 - 10;
            x(1) - x(2) - 1];

% 初期値の設定
x0 = [1, 1];

% fsolveを使用して解を求める
solution = fsolve(fun2, x0);
disp(solution);

%すんご


