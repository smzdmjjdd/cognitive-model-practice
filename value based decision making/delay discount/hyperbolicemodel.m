%% A simple hyperbolic model for practice.
%% From Kable, J. W. and P. W. Glimcher (2007). "The neural correlates of subjective value during intertemporal choice." Nat Neurosci 10(12): 1625-1633.

%% parameter 'c' : a vector,subject's real choice,1 represents sooner smaller choice,2 represents later larger choice
%% parameter 'r' : a two column matrix,the first column is the sooner smaller reward whereas the second column is the larger later reward
%% parameter 't' : a two column matrix,the first column is the sooner smaller time whereas the second column is the larger later time
%% parameter 'k' : discount rate
%% parameter 'beta' : inverse temperature parameter
%% parameter 'e' : epsilon greedy parameter, interpreted as motor noise

function ll=hyperbolicemodel(c,r,t,k,beta,e)

T=length(c);
sv=r./(k.*t+1);
delta_sv(:,1)=sv(:,1)-sv(:,2);
delta_sv(:,2)=sv(:,2)-sv(:,1);
proba=1./(1+exp(-beta.*delta_sv));
for trial=1:T
    single_ll(trial)=proba(trial,c(trial));
single_ll=single_ll*(1-e)+e/2;  %% two choices, therefore the random selection probability is e/2.
end
ll=-sum(log(single_ll));
    
