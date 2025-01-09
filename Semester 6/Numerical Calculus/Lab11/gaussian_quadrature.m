function [I, g_nodes, g_coeff] = gaussian_quadrature(f, n, g_type)
  alpha = zeros(n, 1);
  switch g_type
    case 1 # Legendre
      beta = [2,(4 - (1:n-1).^(-2)).^(-1)];
    case 2
      beta = [pi, 1/2, 1/4 * ones(1, n-2)];
    case 3
      beta = [pi/2, 1/4];
#    case 4
#      a = 0
#      alpha = [2*(1:n - 1) + a + 1]
#      beta = [gamma(1 + a), (1:n - 1) * ((1:n - 1) + a)]
#    case 5
#      beta = [sqrt(pi), (1:n - 1)*1/2]
  endswitch

  J = diag(alpha) + diag(sqrt(beta(2:n)), 1) + diag(sqrt(beta(2:n)), -1);
  [v, d] = eig(J);
  g_nodes = diag(d);
  g_coeff = beta(1) * v(1,:).^2;
  I = g_coeff * f(g_nodes);
end
