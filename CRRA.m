function util =CRRA(cons,gamma);
if gamma == 1
    util = log (cons);
else
    util = cons.^(1-gamma)./(1-gamma);
end
return;