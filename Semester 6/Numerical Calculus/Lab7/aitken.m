function [p,n] = aitken(x, xi, fi)
  p = zeros(length(xi), length(xi));
  for i = 1:length(xi)
    p(i, 1) = fi(i);
    for j = 1:i-1
      part = (x - xi(j)) .* p(i,j) - (x - xi(i)) .* p(j,j);
      part2 = xi(i) - xi(j);
      p(i,j+1) = part / part2;
    endfor
  endfor
  n = length(p);
end

