% first exercise
[A,b] = matrix_system(5);

n = 1000;
[A,b] = matrix_system(1000);
x0 = zeros(size(b));
maxnit = 100;
error = inv(10)^5;


[x, nit] = jacobi_iteration(A, b, x0, maxnit, error)

[x2, nit2] = gauss_iteration(A, b, x0, maxnit, error)

% second exercise
A = [10,7,8,7;7,5,6,5;8,6,10,9;7,5,9,10]
b = [32;23;33;31]

% a)
x = A./b

% b)
til_b = [32.1;22.9;33.1;30.9]
til_x = A./til_b

value = (norm(b - til_b)./norm(b))
value2 = (norm(x - til_x)./norm(x))

% c)
til_A = [10,7,8.1,7.2;7.8,5.04,6,5;8,5.98,9.89,9;6.99,4.99,9,9.98]
x3 = til_A./b

til_x2 = til_A./til_b

value_A = norm(A - til_A)./norm(A)

% value_B = (norm(b - til_b)./norm(b))
% value_X = (norm(x3 - x)./norm(x3))
cond = norm(A)*norm(inv(A))
