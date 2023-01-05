% X - normal miu = 1
% Stubat sigma = 5
% Fischer

miu = input('Miu: ');
sigma = input('Sigma: ');

% a) P(X<=0) & P(X>=0)
p1 = normcdf(0,miu,sigma)
p2 = 1 - p1

% b) P(-1<=X<=1)
p3 = normcdf(1,miu,sigma) - normcdf(-1,miu,sigma)
p4 = 1 - p3
