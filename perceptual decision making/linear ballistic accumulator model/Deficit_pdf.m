%% Deficitive PDF for Linear Ballisitic Accumulator Model
%% Only for one drift rate model(v for correct response,1-v for incorrect response)
%% From Brown, S. D. and A. Heathcote (2008). "The simplest complete model of choice response time: Linear ballistic accumulation." Cogn Psychol 57(3): 153-178.
% -t reaction(response) time
% -v expectation of drift rate
% -sv variance of drift rate
% -A starting bias
% -b thershold

function ll=Deficit_pdf(t,v,sv,A,b)

ll=pdf_lba(t,v,sv,A,b).*(1-cdf_lba(t,v,sv,A,b));
