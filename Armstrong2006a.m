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
pricevector = [p1A; p2A];


ns = (1 - ((2*alpha1 - 2*gamma1A ) * (2*alpha2 - 2*gamma2A )) / (4*t1*t2))^(-1)*[1,(2*alpha1-2*gamma1A)/(2*t1); (2*alpha2-2*gamma2A)/(2*t2), 1]*[1/2-(alpha1-gamma1A)/(2*t1);1/2-(alpha2-gamma2A)/(2*t2)];
I = [1, 0; 0, 1];
rmatrix = [0, gamma1A+gamma2A; gamma1A+gamma2A, 0];

equations = (I+ matrix4*rmatrix)*ns == -matrix4*pricevector;

sol = solve(equations, [p1A, p2A]);
disp(sol.p1A)
disp(sol.p2A)