pkg load statistics

% X - normal | normcdf, norminv | (miu, sigma) = (1,5)
% Student t  |       tcdf, tinv | (m)          = (10)
% Fischer            fcdf, finv | (m, v)       = (10,15)

% n - nr of trials, k - nr of successes

% Poisson distribution

exercise = input('Exercise: ');
fprintf('1 - Distributions \n')
fprintf('2 - Approximation of binomial distribution \n')
fprintf('3 - Poisson distribution \n')
fprintf('* - Exit \n')
fprintf('* means any number \n')

switch exercise
  case 1
    alpha = input('Alpha: ');
    beta = input('Beta: ');
    option = input('Option: ','s');

    switch option
      case 'normal'
        % Normal distribution N(miu,sigma)
        miu = input('Miu: ');
        sigma = input('Sigma: ');

        % a) P(X<=0) & P(X>=0)
        p1 = normcdf(0,miu,sigma)
        p2 = 1 - p1

        % b) P(-1<=X<=1) && P(x<=-1 or X>=1)
        p3 = normcdf(1,miu,sigma) - normcdf(-1,miu,sigma)
        p4 = 1 - p3

        % c) X(alpha) = ? : P(X < X(alpha))=alpha, 0 < alpha < 1
        x_alpha = norminv(alpha,miu,sigma)

        % d) X(beta) = ? : P(X > X(beta)) = beta
        x_beta = norminv(1 - beta,miu,sigma)

      case 'student'
        % Student t distribution
        m = input('M: ');

        % a) P(X<=0) & P(X>=0)
        p1 = tcdf(0,m)
        p2 = 1 - p1

        % b) P(-1<=X<=1) && P(x<=-1 or X>=1)
        p3 = tcdf(1,m) - tcdf(-1,m)
        p4 = 1 - p3

        % c) X(alpha) = ? : P(X < X(alpha))=alpha, 0 < alpha < 1
        x_alpha = tinv(alpha,m)

        % d) X(beta) = ? : P(X > X(beta)) = beta
        x_beta = tinv(1 - beta,m)

      case 'fischer'
        % Fischer distribution
        m = input('M: ');
        v = input('V: ');

        % a) P(X<=0) & P(X>=0)
        p1 = fcdf(0,m,v)
        p2 = 1 - p1

        % b) P(-1<=X<=1) && P(x<=-1 or X>=1)
        p3 = fcdf(1,m,v) - fcdf(-1,m,v)
        p4 = 1 - p3

        % c) X(alpha) = ? : P(X < X(alpha))=alpha, 0 < alpha < 1
        x_alpha = finv(alpha,m,v)

        % d) X(beta) = ? : P(X > X(beta)) = beta
        x_beta = finv(1 - beta,m,v)
    otherwise
        fprintf('Error 404')
    end
  case 2
    % P - probability
    p = input('P: ');
    for n = 1:3:100
      k = 0:n;
      prob = binopdf(k, n, p);
      plot(k, prob)
      xlim([0 100])
      ylim([0 0.15])
      pause(0.2)
    endfor
  case 3
    n = input('n: ');
    p = input('p: ');
    lambda = n * p;
    k = 0:n;
    b1 = binopdf(k,n,p);
    p1 = poisspdf(k,lambda);
    plot(k,b1,k,p1)
otherwise
    fprintf('Goodbye!')
end
