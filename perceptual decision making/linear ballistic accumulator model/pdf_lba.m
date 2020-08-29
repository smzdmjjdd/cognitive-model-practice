%% PDF for Linear Ballisitic Accumulator Model
%% From Brown, S. D. and A. Heathcote (2008). "The simplest complete model of choice response time: Linear ballistic accumulation." Cogn Psychol 57(3): 153-178.
% -t reaction(response) time
% -v expectation of drift rate
% -sv variance of drift rate
% -A starting bias
% -b thershold

function pdf=pdf_lba(t,v,sv,A,b)
x=(b-A-t.*v)./(t.*sv);
y=(b-t.*v)./(t.*sv);
pdf=(-v.*normcdf(x)+sv.*normpdf(x)+v.*normcdf(y)-sv.*normpdf(y))./A;
