%% Log likelihood function for Linear Ballisitic Accumulator Model
%% One drift rate model(v for correct choices, 1-v for incorrect choices)
%% From Brown, S. D. and A. Heathcote (2008). "The simplest complete model of choice response time: Linear ballistic accumulation." Cogn Psychol 57(3): 153-178.
% -correct 1 for correct,0 for incorrect
% -t reaction(response) time
% -v expectation of drift rate parameter
% -sv variance of drift rate parameter
% -A starting bias parameter
% -b thershold parameter
% -ter none decision time parameter

function llf=Llf_lba(correct,t,v,sv,A,b,ter)

t=t-ter;
% divide rt into two folds: correct and incorrect.
cor_t=t(correct==1);
incor_t=t(correct==0);

%compute sigle trial likelihood
cor_ll=Deficit_pdf(cor_t,v,sv,A,b);
incor_ll=Deficit_pdf(incor_t,1-v,sv,A,b);

%compute log likelihood 
llf=-sum(log(cor_ll))-sum(log(incor_ll));
