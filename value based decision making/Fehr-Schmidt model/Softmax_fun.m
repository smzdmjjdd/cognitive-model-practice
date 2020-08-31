%% Softmax choice function
% - tau: inverse temperature parameter
% - v: independent variabe, size of row is the number of trials, column number is the number of choices in single trial. 
% - c: subject's real choice

function proba=Softmax_fun(tau,v)

deno=exp(tau.*v);
mole=sum(exp(tau.*v),2);
proba=deno./mole;



