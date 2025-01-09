% backward substitution
vec = [2,4,2; 0,-1,1; 0,0,-1]
b = [8;0;-1]

x = back_subst(vec, b)

% forward substitution
vec2 = [1,0,0; 1/2,1,0; 1/2,1,1]
b2 = [8;4;3]

x2 = forw_subst(vec2, b2)

% P*A = L*U
% p-perm, A-matrix, L-lower, U-upper

A = [2,1,-1,-2;4,4,1,3;-6,-1,10,10;-2,1,8,4];
b_1 = [2;4;-5;1];

% LUP decomposition
[L,U,P] = lu(A)

if(P*A == L*U)
  display("yes")
else
  display("no")
end

res = P*b_1
y_res = forw_subst(L, res)
x_res = back_subst(U, y_res)

% Gaussian elimination
mat = [-3,-1,5; -2,2,1; 1,-1,1];
b = [-5;2;-1];

% compute pivot
% divide nr by pivot * R1 and substract from R2 then the same for R3

gauss_elim_part_piv(A, b_1)



