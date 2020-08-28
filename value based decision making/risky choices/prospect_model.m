%% Prospect theory model in risky decision making task
% From Rutledge, R. B., et al. (2015). "Dopaminergic Modulation of Decision Making and Subjective Well-Being." Journal of Neuroscience 35(27): 9811-9822.

% -c is the subject's choices,1 for certain choice, 2 for gamble choice
% -cr is the value of certain choices
% -ur is the value of uncertain choices, which includes two columns.The
% first column is the bigger possibility(0 or gain) and the second column is the
% smaller possibility(loss or 0).
% -ag is the utility function parameter of gain 
% -al is the utility function parameter of loss
% -lambda is the loss aversion parameter
% -beta is the inverse temperature parameter

function ll=prospect_model(c,cr,ur,ag,al,lambda,beta)
trial_number=length(c);
%calculate the gamble choices' utility.
u_gamble=0.5.*ur(:,1).^ag-0.5.*lambda.*(-ur(:,2)).^al;

%calculate the certain choices' utility.
for trial=1:trial_number
    if cr(trial)>=0
        u_certain(trial)=cr(trial).^ag;
    elseif cr(trial)<0
        u_certain(trial)=-lambda.*-cr(trial).^al;
    end
end
%softmax choice kernel
proba_gamble=1./(1+exp(-beta.*(u_gamble-u_certain)));
proba_certain=1-proba_gamble;
proba_sum=[proba_certain;proba_gamble];

%calculate likelihood per trial
for trial=1:trial_number
    single_ll(trial)=proba_sum(trial,c(trial));
end

ll=-sum(log(single_ll));

 


