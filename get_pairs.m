function [ pairs ] = get_pairs(N,params)
    
    
    addpath('Heap/');
    
    % divs = zeros(N,N);
    
    % max heap
    
    arr = repmat(struct('key', -Inf,'a',0,'b',0), N, 1 );
    
    h=Heap(arr);
    
    % mx =h.heapMaximum
    %
    % heapIncreaseKey(h,3,11)
    % maxHeapInsert(h,1.5);
    %
    % b=heapSort(h);
    
    count =0 ;
    L  = numel(params.emu); %number of objects
    for a = 1:L
        
        for b = 1:L
            
            if(a~=b)
                new_params = get_updated_parameters(a,b,[params.history(a,b),params.history(b,a)],params);
                
%                 div_a_ab=   KLGauss(params.mu(a),new_params.mu_a,params.sigma(a),new_params.sigma_a);
                           div_a_ab = 0  + KLGauss(new_params.mu_a,params.mu(a),new_params.sigma_a,params.sigma(a));
                
                                div_b_ab = KLGauss(new_params.mu_b,params.mu(b),new_params.sigma_b,params.sigma(b));
%                div_b_ab =0 + KLGauss(params.mu(b),new_params.mu_b,params.sigma(b),new_params.sigma_b);
                div_k_ab = 0;
                pr_ab = new_params.pr;
                
                new_params = get_updated_parameters(b,a,[params.history(b,a),params.history(a,b)],params);
                %idecies confuse
                
%                 div_a_ba=   KLGauss(params.mu(a),new_params.mu_a,params.sigma(a),new_params.sigma_a);
                div_a_ba = 0  + KLGauss(new_params.mu_a,params.mu(b),new_params.sigma_a,params.sigma(b));
                
                         div_b_ba = KLGauss(new_params.mu_b,params.mu(a),new_params.sigma_b,params.sigma(a));
%                 div_b_ba =0+ KLGauss(params.mu(b),new_params.mu_b,params.sigma(b),new_params.sigma_b);
                div_k_ba = 0;
                pr_ba = new_params.pr;
                
                
                div =pr_ab*(div_a_ab+div_b_ab+div_k_ab) + pr_ba*(div_a_ba+div_b_ba+div_k_ba);
                                          
                
                if(-div< h.heapMaximum.key || count<N)
                   
                    el =struct('key',-div,'a',a,'b',b);
                    
                    if(count==N)
                        heapExtractMax(h);
                    else
                        count = count+1;
                    end
                    maxHeapInsert(h,el);
                    
                    
                end
                
            end
        end
    end
%      new_params = get_updated_parameters(a,b,[params.history(h.heapMaximum.a,h.heapMaximum.b),params.history(h.heapMaximum.b,h.heapMaximum.a)],params);
%     new_params.pr
%      new_params = get_updated_parameters(b,a,[params.history(h.heapMaximum.b,h.heapMaximum.a),params.history(h.heapMaximum.a,h.heapMaximum.b)],params);
%        new_params.pr
%     h.heapMaximum.a
%     h.heapMaximum.b
    
    pairs = zeros(N,2);
    for i = 1:N
        pairs(i,1) =  h.heapMaximum.a;
        pairs(i,2) =  h.heapMaximum.b;
        
        heapExtractMax(h);
        
    end
    
    
end

