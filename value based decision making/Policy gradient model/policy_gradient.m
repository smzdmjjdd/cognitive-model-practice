%% Reinforcement learning model: Policy gradient model 
%% From Li, J. and N. D. Daw (2011). "Signals in human striatum are appropriate for policy update rather than value prediction." J Neurosci 31(14): 5504-5511.

% -c is the subject's choices,1 for left choice, 2 for right choice
% -fb is the choice feedback reward, the first column is the left choice feedback,whereas
% the second column is the right choice feedback.
% -w0 is the initial policy parameter
% -eta is the decay parameter 
% -alpha is the learning rate
% -k is the skew parameter

function ll=policy_gradient(c,fb,w0,eta,alpha,k)
trial_number=length(c);

%initilize policy parameter
w=zeros(200,1);
w(1)=w0;
for trial=1:trial_number
    %calculate the policy
    p_left(trial)=1./(1+exp(-w(trial)));
    p_right(trial)=1-p_left(trial);
    
    %calculate gradient
    if c(trial)==1
        delta(trial)=fb(trial,1)-k*fb(trial,2);
    elseif c(trial)==2
        delta(trial)=fb(trial,2)-k*fb(trial,1);
    end
    
    %update policy parameter
    if c(trial)==1
        w(trial+1)=eta*w(trial)+alpha*p_left(trial)*p_right(trial)*delta;
    elseif c(trial)==2
        w(trial+1)=eta*w(trial)-alpha*p_left(trial)*p_right(trial)*delta;
    end
end
  
%calculate logliklihood
p_sum=[p_left;p_right];
for trial=1:trial_number
    single_ll(trial)=p_sum(c(trial),trial);
end

ll=-sum(log(single_ll));
