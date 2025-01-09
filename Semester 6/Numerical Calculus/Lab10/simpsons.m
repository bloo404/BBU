function I = simpsons(f, a, b, m)
  h = (b - a) / (m * 2);
  x = a:h:b;
  I = h / 3 * (f(a) + f(b) + 4*sum(f(x(2:2:end-1))) + 2*sum(f(x(3:2:end-2))));
end

