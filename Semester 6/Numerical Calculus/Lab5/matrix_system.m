function [A, b]=matrix_system(n)
  A = 5 * eye(n) + diag(-1 * ones(1, n - 1), 1) + diag(-1*ones(1,n-1) , -1);
  b = 3 * ones(n,1) + [1; zeros(n-2,1); 1];
end
