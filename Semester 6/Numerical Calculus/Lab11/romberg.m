function [I, nfen] = romberg(f, a, b, err, nrmax)
  R = zeros(nrmax);
  h = b - a;
  R(1,1) = h/2 * sum(f([a,b]));
  nfen = 2;

  for k = 2:nrmax
    x = a + ((1 : 2^(k - 2)) - 0.5) * h;
    R(k, 1) = 0.5 * (R(k - 1, 1) + h * sum(f(x)));
    nfen = nfen + length(x);

    for j = 2:k
      R(k, j) = (4^(j - 1) * R(k, j - 1) - R(k - 1, j - 1)) / (4^(j - 1) - 1);
    endfor

    if abs(R(k, k) - R(k-1, k-1)) < err
      I = R(k, k)
      R(1:k, 1:k)
      return
    endif
    h = h/2

  endfor

  error('too difficult');
end
