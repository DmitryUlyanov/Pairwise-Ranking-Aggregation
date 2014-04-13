function divergence = KLGauss(mu_0,mu_1, sigma_0,sigma_1)

k = numel(mu_0);

divergence = trace(sigma_1\sigma_0) + (mu_1-mu_0)'*((mu_1-mu_0)/sigma_1) - k - log(det(sigma_0)/det(sigma_1)) ;
divergence = divergence/2;

end

