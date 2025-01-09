% Ex1
x = [0, 1/6, 1/2];
f = [0, 1/2, 1];

div_diff(x,f)

% Ex1
x = [0,1,2];
f = 1./(x+1);
fd = -1./(x+1).^2;

%a)
t = div_diff(x,f)

%b)
[z,t] = div_diff2(x,f,fd)

%c)
x = linspace(1, 2, 11)
f = 1./(x+1);
fd = -1./(x+1).^2;

%c a)
t = div_diff(x,f)

%c b)
[z,t] = div_diff2(x,f,fd)


%2 a)
x = [-2,-1,0,1,2,3,4]
f = [-5, 1,1,1,7,25,60]

t = div_diff(x,f)

% b)
t = for_diff(f)

% c)
t = back_diff(f)
