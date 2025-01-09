function f = barycentric_formula(xi, fi, x) # Lagrange Barycentric
  n = length(xi);

  # Compute weights
  w = ones(1, n);
  for j = 1:n
    w(j) = prod(xi(j) - xi([1:j-1, j + 1:n]));
  endfor
  w = 1./w;

  # Numerator, denominator, exact
  num = zeros(size(x));
  den = num;
  exact = den;
  for j = 1:n
    x_diff = x - xi(j);
    term = w(j)./x_diff;
    num = num + fi(j) * term;
    den = den + term;
    exact(x_diff == 0) = j;

  # Finalize the fraction (Lagrange Barycentric Formula)
  f = num./den;
  k = find(exact);
  f(k) = fi(exact(k));
    endfor
end
