function x = gauss_elim_part_piv(A,b)
   [r,u] = size(A);
   x = zeros(size(b));
   A = [A, b];
   for j=1:u-1
     [u, p] = max(abs(A(j:r, j)));
     p = p + j - 1

     for i = j+1:r
       m = A(i,j)/A(j,j);
       A(i,:)= A(i,:)- m * A(j,:);
     endfor
   endfor
  x = back_subst(A(:,1:u),A(:,u+1));
end
