% input for solution
% n = input('Nr of trials = ');
% p = input('Pr. of success = ');
n = 3
p = 0.5

% declaration & initialization
x = 0:n; % x
px =  binopdf(x,n,p); % probability of x

% graph
plot(x,px,'*');

xx=0:0.1:n;
fx = binocdf(xx,n,p);

hold on

plot(xx,fx,'-');

% probabilities (in caiet mai multe)
p1 = binopdf(0,3,0.5)
p2 = 1 - binopdf(2,3,0.5)
p3 = binocdf(2,3,0.5)
p4 = binocdf(1.9,3,0.5)
p6 = binocdf(1,3,0.5)
p5 = binocdf(0,3,0.5)

% N = input('Nr of simulations = '); % reads something
N = 1000
C = rand(3,N); % matrix of 3xN elements

D = C < 0.5;

E = sum(D);

sum(sum(D));

clf; % clear

hold on

hist(E); % histogram(D)
