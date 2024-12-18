syms t1 t2 alpha1 alpha2 p1 p2

% LHS 
matrix1 = [2*t2, alpha1+alpha2; alpha1+alpha2, 2*t1];
prices = [p1; p2];

%RHS
constantvector = [t1*t2-alpha1*alpha2; t1*t2-alpha1*alpha2];
matrix2 = [t2, alpha1; alpha2, t1];
matrix3 = 1/(4*t1*t2-alpha1^2-2*alpha1*alpha2-alpha2^2)*[2*t1, -alpha1-alpha2; -alpha1-alpha2, 2*t2];

%solve
eqns = matrix1 * prices == constantvector + matrix2 * (matrix3 * constantvector + matrix3 * matrix2 * prices);

sol = solve(eqns, [p1, p2]);
disp(sol.p1)
disp(sol.p2)

syms gamma1A gamma2A gamma1B gamma2B p1A p2A p1B p2B


matrix4 = -(1 - ((2*alpha1 - 2*gamma1A ) * (2*alpha2 - 2*gamma2A )) / (4*t1*t2))^(-1)* [1/(2*t1), (2*alpha2-2*gamma2A)/(4*t1*t2); (2*alpha1-2*gamma1A)/(4*t1*t2), 1/(2*t2)];
pricevectorA = [p1A; p2A];


ns = (1 - ((2*alpha1 - 2*gamma1A ) * (2*alpha2 - 2*gamma2A )) / (4*t1*t2))^(-1)*[1,(2*alpha1-2*gamma1A)/(2*t1); (2*alpha2-2*gamma2A)/(2*t2), 1]*[1/2-(alpha1-gamma1A)/(2*t1);1/2-(alpha2-gamma2A)/(2*t2)];
I = [1, 0; 0, 1];
rmatrixA = [0, gamma1A+gamma2A; gamma1A+gamma2A, 0];

equations = (I+ matrix4*rmatrixA)*ns == -matrix4*pricevectorA;

sol = solve(equations, [p1A, p2A]);
disp('symmetric p:');
disp(sol.p1A)
disp(sol.p2A)

matrix4A = -(1 - ((2*alpha1 - gamma1A-gamma1B ) * (2*alpha2 - gamma2A-gamma2B )) / (4*t1*t2))^(-1)* [1/(2*t1), (2*alpha2-gamma2A-gamma2B)/(4*t1*t2); (2*alpha1-gamma1A-gamma1B)/(4*t1*t2), 1/(2*t2)];
matrix4B = -(1 - ((2*alpha1 - gamma1A-gamma1B ) * (2*alpha2 - gamma2A-gamma2B )) / (4*t1*t2))^(-1)* [1/(2*t1), (2*alpha2-gamma2A-gamma2B)/(4*t1*t2); (2*alpha1-gamma1A-gamma1B)/(4*t1*t2), 1/(2*t2)];
pricevectorB = [p1B; p2B];


nsA = (1 - ((2*alpha1 - gamma1A - gamma1B ) * (2*alpha2 - gamma2A - gamma2B )) / (4*t1*t2))^(-1)*[1,(2*alpha1-gamma1A-gamma1B)/(2*t1); (2*alpha2-gamma2A-gamma2B)/(2*t2), 1]*[1/2-(p1A-p1B+alpha1-gamma1B)/(2*t1);1/2-(p2A-p2B+alpha2-gamma2B)/(2*t2)];
nsB = (1 - ((2*alpha1 - gamma1A - gamma1B ) * (2*alpha2 - gamma2A - gamma2B )) / (4*t1*t2))^(-1)*[1,(2*alpha1-gamma1A-gamma1B)/(2*t1); (2*alpha2-gamma2A-gamma2B)/(2*t2), 1]*[1/2-(p1B-p1A+alpha1-gamma1A)/(2*t1);1/2-(p2B-p2A+alpha2-gamma2A)/(2*t2)];

rmatrixB = [0, gamma1B+gamma2B; gamma1B+gamma2B, 0];

eqns2 = (I+ matrix4A*rmatrixA)*nsA == -matrix4A*pricevectorA;
eqns3 = (I+ matrix4B*rmatrixB)*nsB == -matrix4B*pricevectorB;

sol = solve(eqns2, [p1A, p2A]);
disp('連立方程式:');
disp(sol.p1A)
disp(sol.p2A)
sol = solve(eqns3, [p1B, p2B]);
disp(sol.p1B)
disp(sol.p2B)

eq1  = p1A == -(4*alpha1*alpha2^2 + 4*alpha1^2*alpha2 + 2*alpha1^2*gamma1A + alpha1*gamma2B^2 + 2*alpha2*gamma1B^2 - 2*alpha1^2*gamma2B - 4*alpha2^2*gamma1B + gamma1A*gamma1B^2 - gamma1B*gamma2B^2 - gamma1B^2*gamma2B - 4*alpha2^2*p1B - gamma2B^2*p1B + gamma2B^2*t1 + 8*t1^2*t2 + 2*alpha1*alpha2*gamma1A - 6*alpha1*alpha2*gamma1B - 4*alpha1*alpha2*gamma2B - 3*alpha1*gamma1A*gamma1B - alpha1*gamma1A*gamma2B - 2*alpha2*gamma1A*gamma1B + 3*alpha1*gamma1B*gamma2B + 4*alpha2*gamma1B*gamma2B - 4*alpha1*alpha2*p1B + gamma1A*gamma1B*gamma2B - 8*alpha1*alpha2*t1 - 2*alpha1*gamma1A*p1B - 2*alpha2*gamma1A*p1B + 2*alpha1*gamma2B*p1B + 2*alpha2*gamma1B*p1B + 4*alpha2*gamma2B*p1B - 2*alpha1*gamma1A*t1 + 2*alpha2*gamma1A*t1 + 6*alpha1*gamma2B*t1 + 4*alpha2*gamma1B*t1 - 2*alpha2*gamma2B*t1 + gamma1A*gamma1B*p1B + gamma1A*gamma2B*p1B - gamma1B*gamma2B*p1B + gamma1A*gamma1B*t1 - 3*gamma1A*gamma2B*t1 - 3*gamma1B*gamma2B*t1 + 4*alpha1*p2B*t1 - 4*alpha2*p2B*t1 - 4*alpha1*t1*t2 - 4*alpha2*t1*t2 - 4*gamma1A*p2B*t1 - 2*gamma1B*p2B*t1 + 2*gamma2B*p2B*t1 - 4*gamma1A*t1*t2 + 6*gamma1B*t1*t2 + 2*gamma2B*t1*t2 + 8*p1B*t1*t2)/(4*alpha1^2 + 8*alpha1*alpha2 - 4*alpha1*gamma1B - 4*alpha1*gamma2B + 4*alpha2^2 - 4*alpha2*gamma1B - 4*alpha2*gamma2B + gamma1B^2 + 2*gamma1B*gamma2B + gamma2B^2 - 16*t1*t2);
eq2  = p2A == -(4*alpha1*alpha2^2 + 4*alpha1^2*alpha2 + 2*alpha1*gamma2B^2 + alpha2*gamma1B^2 - 4*alpha1^2*gamma2B - 2*alpha2^2*gamma1B + 2*alpha2^2*gamma2A - gamma1B*gamma2B^2 + gamma2A*gamma2B^2 - gamma1B^2*gamma2B - 4*alpha1^2*p2B - gamma1B^2*p2B + gamma1B^2*t2 + 8*t1*t2^2 - 4*alpha1*alpha2*gamma1B + 2*alpha1*alpha2*gamma2A - 6*alpha1*alpha2*gamma2B + 4*alpha1*gamma1B*gamma2B - 2*alpha1*gamma2A*gamma2B - alpha2*gamma1B*gamma2A + 3*alpha2*gamma1B*gamma2B - 3*alpha2*gamma2A*gamma2B - 4*alpha1*alpha2*p2B + gamma1B*gamma2A*gamma2B - 8*alpha1*alpha2*t2 + 4*alpha1*gamma1B*p2B - 2*alpha1*gamma2A*p2B + 2*alpha1*gamma2B*p2B + 2*alpha2*gamma1B*p2B - 2*alpha2*gamma2A*p2B - 2*alpha1*gamma1B*t2 + 2*alpha1*gamma2A*t2 + 4*alpha1*gamma2B*t2 + 6*alpha2*gamma1B*t2 - 2*alpha2*gamma2A*t2 + gamma1B*gamma2A*p2B - gamma1B*gamma2B*p2B + gamma2A*gamma2B*p2B - 3*gamma1B*gamma2A*t2 - 3*gamma1B*gamma2B*t2 + gamma2A*gamma2B*t2 - 4*alpha1*p1B*t2 + 4*alpha2*p1B*t2 - 4*alpha1*t1*t2 - 4*alpha2*t1*t2 + 2*gamma1B*p1B*t2 - 4*gamma2A*p1B*t2 - 2*gamma2B*p1B*t2 + 2*gamma1B*t1*t2 - 4*gamma2A*t1*t2 + 6*gamma2B*t1*t2 + 8*p2B*t1*t2)/(4*alpha1^2 + 8*alpha1*alpha2 - 4*alpha1*gamma1B - 4*alpha1*gamma2B + 4*alpha2^2 - 4*alpha2*gamma1B - 4*alpha2*gamma2B + gamma1B^2 + 2*gamma1B*gamma2B + gamma2B^2 - 16*t1*t2);
eq3  = p1B == -(4*alpha1*alpha2^2 + 4*alpha1^2*alpha2 + alpha1*gamma2A^2 + 2*alpha2*gamma1A^2 + 2*alpha1^2*gamma1B - 2*alpha1^2*gamma2A - 4*alpha2^2*gamma1A - gamma1A*gamma2A^2 + gamma1A^2*gamma1B - gamma1A^2*gamma2A - 4*alpha2^2*p1A - gamma2A^2*p1A + gamma2A^2*t1 + 8*t1^2*t2 - 6*alpha1*alpha2*gamma1A + 2*alpha1*alpha2*gamma1B - 4*alpha1*alpha2*gamma2A - 3*alpha1*gamma1A*gamma1B + 3*alpha1*gamma1A*gamma2A - alpha1*gamma1B*gamma2A - 2*alpha2*gamma1A*gamma1B + 4*alpha2*gamma1A*gamma2A - 4*alpha1*alpha2*p1A + gamma1A*gamma1B*gamma2A - 8*alpha1*alpha2*t1 - 2*alpha1*gamma1B*p1A + 2*alpha1*gamma2A*p1A + 2*alpha2*gamma1A*p1A - 2*alpha2*gamma1B*p1A + 4*alpha2*gamma2A*p1A - 2*alpha1*gamma1B*t1 + 6*alpha1*gamma2A*t1 + 4*alpha2*gamma1A*t1 + 2*alpha2*gamma1B*t1 - 2*alpha2*gamma2A*t1 + gamma1A*gamma1B*p1A - gamma1A*gamma2A*p1A + gamma1B*gamma2A*p1A + gamma1A*gamma1B*t1 - 3*gamma1A*gamma2A*t1 - 3*gamma1B*gamma2A*t1 + 4*alpha1*p2A*t1 - 4*alpha2*p2A*t1 - 4*alpha1*t1*t2 - 4*alpha2*t1*t2 - 2*gamma1A*p2A*t1 - 4*gamma1B*p2A*t1 + 2*gamma2A*p2A*t1 + 6*gamma1A*t1*t2 - 4*gamma1B*t1*t2 + 2*gamma2A*t1*t2 + 8*p1A*t1*t2)/(4*alpha1^2 + 8*alpha1*alpha2 - 4*alpha1*gamma1A - 4*alpha1*gamma2A + 4*alpha2^2 - 4*alpha2*gamma1A - 4*alpha2*gamma2A + gamma1A^2 + 2*gamma1A*gamma2A + gamma2A^2 - 16*t1*t2);
eq4  = p2B == -(4*alpha1*alpha2^2 + 4*alpha1^2*alpha2 + 2*alpha1*gamma2A^2 + alpha2*gamma1A^2 - 4*alpha1^2*gamma2A - 2*alpha2^2*gamma1A + 2*alpha2^2*gamma2B - gamma1A*gamma2A^2 - gamma1A^2*gamma2A + gamma2A^2*gamma2B - 4*alpha1^2*p2A - gamma1A^2*p2A + gamma1A^2*t2 + 8*t1*t2^2 - 4*alpha1*alpha2*gamma1A - 6*alpha1*alpha2*gamma2A + 2*alpha1*alpha2*gamma2B + 4*alpha1*gamma1A*gamma2A + 3*alpha2*gamma1A*gamma2A - 2*alpha1*gamma2A*gamma2B - alpha2*gamma1A*gamma2B - 3*alpha2*gamma2A*gamma2B - 4*alpha1*alpha2*p2A + gamma1A*gamma2A*gamma2B - 8*alpha1*alpha2*t2 + 4*alpha1*gamma1A*p2A + 2*alpha1*gamma2A*p2A + 2*alpha2*gamma1A*p2A - 2*alpha1*gamma2B*p2A - 2*alpha2*gamma2B*p2A - 2*alpha1*gamma1A*t2 + 4*alpha1*gamma2A*t2 + 6*alpha2*gamma1A*t2 + 2*alpha1*gamma2B*t2 - 2*alpha2*gamma2B*t2 - gamma1A*gamma2A*p2A + gamma1A*gamma2B*p2A + gamma2A*gamma2B*p2A - 3*gamma1A*gamma2A*t2 - 3*gamma1A*gamma2B*t2 + gamma2A*gamma2B*t2 - 4*alpha1*p1A*t2 + 4*alpha2*p1A*t2 - 4*alpha1*t1*t2 - 4*alpha2*t1*t2 + 2*gamma1A*p1A*t2 - 2*gamma2A*p1A*t2 - 4*gamma2B*p1A*t2 + 2*gamma1A*t1*t2 + 6*gamma2A*t1*t2 - 4*gamma2B*t1*t2 + 8*p2A*t1*t2)/(4*alpha1^2 + 8*alpha1*alpha2 - 4*alpha1*gamma1A - 4*alpha1*gamma2A + 4*alpha2^2 - 4*alpha2*gamma1A - 4*alpha2*gamma2A + gamma1A^2 + 2*gamma1A*gamma2A + gamma2A^2 - 16*t1*t2);

sol = solve([eq1,eq2,eq3,eq4],[p1A,p1B,p2A,p2B]);
disp('p1A:');
disp(sol.p1A);
disp('p1B:');
disp(sol.p1B);
disp('p2A:');
disp(sol.p2A);
disp('p2B:');
disp(sol.p2B);






% substitute: gamma1A = gamma1B, gamma2B = gamma2A
p1A_simplified = subs(sol.p1A, [gamma1B, gamma2B], [gamma1A, gamma2A]);

% simplify
p1A_simplified = simplify(p1A_simplified);

disp('Simplified p1A:');
disp(p1A_simplified);

sol.n1A = (1 - ((2*alpha1 - 2*gamma1A ) * (2*alpha2 - 2*gamma2A )) / (4*t1*t2))^(-1)*((1/2-(sol.p1A-sol.p1B+alpha1-gamma1B)/(2*t1))+((2*alpha1-gamma1A-gamma1B)/(2*t1))*(1/2-(sol.p2B-sol.p2A+alpha2-gamma2A)/(2*t2)));
sol.n2A = (1 - ((alpha1 - gamma1A ) * (alpha2 - gamma2A )) / (t1*t2))^(-1)*(((2*alpha2-gamma2A-gamma2B)/(2*t2))*(1/2-(sol.p1A-sol.p1B+alpha1-gamma1B)/(2*t1))+(1/2-(sol.p2B-sol.p2A+alpha2-gamma2A)/(2*t2)));
sol.piA = (gamma1A*sol.n2A+sol.p1A)*sol.n1A + (gamma2A*sol.n1A+sol.p2A)*sol.n2A;
disp('piA:');
disp(sol.piA);

piA_simplified = subs(sol.piA, [gamma1A, gamma2A, gamma1B, gamma2B], [0,0,0,0]);
disp('Simplified piA:');
disp(piA_simplified);

dfgamma1A = diff(piA, gamma1A);
dfgamma1B = diss (piA, gamma1B);

gammaA_max = solve(dfgammaA == 0, gamma1A);
gammaB_max = solve(dfgammaB == 0, gamma1B);


sol.n1B = (1 - ((2*alpha1 - 2*gamma1A ) * (2*alpha2 - 2*gamma2A )) / (4*t1*t2))^(-1)*((1/2-(sol.p1A-sol.p1B+alpha1-gamma1B)/(2*t1))+((2*alpha1-gamma1A-gamma1B)/(2*t1))*(1/2-(sol.p2B-sol.p2A+alpha2-gamma2A)/(2*t2)));
sol.n2B = (1 - ((alpha1 - gamma1A ) * (alpha2 - gamma2A )) / (t1*t2))^(-1)*(((2*alpha2-gamma2A-gamma2B)/(2*t2))*(1/2-(sol.p1A-sol.p1B+alpha1-gamma1B)/(2*t1))+(1/2-(sol.p2B-sol.p2A+alpha2-gamma2A)/(2*t2)));
sol.piB = (gamma1A*sol.n2A+sol.p1A)*sol.n1A + (gamma2A*sol.n1A+sol.p2A)*sol.n2A;
