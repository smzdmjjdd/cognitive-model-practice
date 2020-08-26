% Fit funciton of hyperbolice model in delay discounting task for practise

function [LL,AIC,BIC]=fit_hyperbolic(c,r,t)

obFunc = @(x) hyperbolicemodel(c, r, t, x(1), x(2));

X0 = [rand exprnd(1)];
LB = [0 0];
UB = [inf inf];
[Xfit, NegLL] = fmincon(obFunc, X0, [], [], [], [], LB, UB);

LL = -NegLL;
AIC = length(X0) * 2 + 2*NegLL;
BIC = length(X0) * log(length(c)) + 2*NegLL;
