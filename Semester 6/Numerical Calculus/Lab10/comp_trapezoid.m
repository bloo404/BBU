function I = comp_trapezoid(f, a, b, n)
  h = (b - a) / n;
  x = a:h:b;
  I = h / 2 * (f(a) + f(b)) + h * sum(f(x(2:end-1)));
end
