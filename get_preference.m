function pref = get_preference(Xt, a,b,alg_params )
    
    val_at_a = Xt(a);
    val_at_b = Xt(b);
    
    layers = alg_params.layers*alg_params.L;
    a_layer = find(layers>val_at_a,1,'first');
    b_layer = find(layers>val_at_b,1,'first');
    
    pref =(val_at_a>val_at_b);
    if(a_layer == b_layer)
        
        p = exp(-(val_at_a+val_at_b)); %probability of wrong answer
        r = rand();
        if(r<p)
            pref = ~pref;
        end
    end
    
    if pref ==0
        pref = -1;
    end
    
end

