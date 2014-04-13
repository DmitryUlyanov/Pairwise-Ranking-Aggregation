%check get_preference function to set probabilities of wrong answes

verbose = true;

alg_params.L = 20; % obj num
alg_params.N = 4;   % batch amount (every guy answers N questions)
alg_params.M = 1000; % iteration limit (how many people do we have)
alg_params.layers = [0.25, 0.7,1.0];


L = alg_params.L;
M = alg_params.M;
N =  alg_params.N;

X = [1:alg_params.L];
Xt = randperm(alg_params.L);
[~,ixXt] = sort(Xt);

Q =[];
%%

alpha_init = 10;
beta_init = 1;
eta_init = 1;
mu_init = 1;
sigma_init = 1/9;
kappa  = 10e-4;


params.alpha = ones(L,1)*alpha_init;
params.beta = ones(L,1)*beta_init;
params.eta =  ones(L,1)*eta_init;
params.mu =  rand(L,1)*mu_init;
params.emu = exp(params.mu);
params.sigma =  ones(L,1)*sigma_init; %sigma squared
params.history = zeros(alg_params.L,alg_params.L);


for i=1:M % iterate throgh people
    
    pairs = get_pairs(alg_params.N,params);
    %% You can use this code to sample random N pairs
    %     pairs = zeros(alg_params.N,1);
    %     for ii=1:alg_params.N
    %         while(true)
    %
    %             pairs(ii,1) = randi(L,1);
    %             pairs(ii,2) = randi(L,1);
    %
    %             if(pairs(ii,2)~=pairs(ii,1))
    %                 break;
    %             end
    %         end
    %     end
    
    
    for j=1:size(pairs,1)
        a = pairs(j,1);
        b = pairs(j,2);
        pref = get_preference(Xt,a,b,alg_params);
        
        if(pref == -1)
            [a,b] = deal (b,a); %swap
        end
        params.history(a,b)=params.history(a,b)+1;
        new_params = get_updated_parameters(a,b,[params.history(a,b),params.history(b,a)],params); % o_a > o_b
        
        
        
        %update
        params.mu(a) = new_params.mu_a;
        params.mu(b) = new_params.mu_b;
        
        params.sigma(a) = new_params.sigma_a;
        params.sigma(b) = new_params.sigma_b;
        
        params.emu(a) = exp(params.mu(a));
        params.emu(b) = exp(params.mu(b));
    end
    
    if(verbose)
        clf
        imagesc(params.history);
        x = [-1:0.1:1];
        for obj=1:L
            f = normpdf(x,params.mu(obj),params.sigma(obj)^(1/2));
            plot(f);
            
            drawnow
            hold on
        end
    end
    
    [~,ix] = sort(params.mu);
    Q(end+1)=sum(abs(ix'-ixXt));
    disp(['Current Error: ',num2str(Q(end))]);
    
    
end