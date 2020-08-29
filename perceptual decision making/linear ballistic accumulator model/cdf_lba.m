%% CDF for Linear Ballisitic Accumulator Model
%% From Brown, S. D. and A. Heathcote (2008). "The simplest complete model of choice response time: Linear ballistic accumulation." Cogn Psychol 57(3): 153-178.
% -t reaction(response) time
% -v expectation of drift rate
% -sv variance of drift rate
% -A starting bias
% -b thershold

function cdf=cdf_lba(t,v,sv,A,b)

x=b-A-t.*v;
y=b-t.*v;
w=t.*sv;

cdf=1+(x./A).*normcdf(x./w)-(y./A).*normcdf(y./w)+(w./A).*normpdf(x./w)-(w./A).*normpdf(y./w);

