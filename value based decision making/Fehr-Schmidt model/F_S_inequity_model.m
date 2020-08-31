%% Fehr¨CSchmidt inequity aversion model
%% From Gao, X., et al. (2018). "Distinguishing neural correlates of context-dependent advantageous- and disadvantageous-inequity aversion." Proceedings of the National Academy of Sciences 115(33): E7680-E7689.

% -c choice,1 for left, 2 for right.
% -alpha aversion parameter under advantageous context
% -beta aversion parameter under disadvantageous context
% -ms self payoff, two columns
% -mo other payoff, two columns
% -tau inverse temperature parameter
% -ind indication parameter,two columns,1 for mo>ms, 2 for ms>mo


function ll=F_S_inequity_model(c,alpha,beta,ms,mo,tau,ind)
p=ind-1;
q=-ind+2;

utility=ms-p.*alpha.*(ms-mo)-q.*beta.*(mo-ms);
proba=Softmax_fun(tau,utility);
for n==1:length(c)
    single_ll(n)=proba(n,c(n));
end

ll=-sum(log(single_ll));





