%% Working memory Reinforcement learning model£¨WMRL)
%% From Collins, A. G. E. and M. J. Frank (2018). "Within- and across-trial dynamics of human EEG reveal cooperative interplay between reinforcement learning and working memory." Proc Natl Acad Sci U S A 115(10): 

% -trial_seq stimulus that subject confront of.
% -c subject's choice, 1 for pressing left button, 2 for pressing central button, 3 for pressing right button
% -fb choice's feedback, 0 for incorrect, 1 for correct.
% -n for stimulus set number.3 4 6.
% -alpha learning rate for RL module,parameter space:[0,1].
% -beta_rl inverse temperature parameter for RL module,fixed in 100.
% -beta_wm inverse temperature parameter for WM module,fixed in 100.
% -epsilon epsilon greedy parameter.
% -rho parapmeter that represents the participant¡¯s overall reliance on WM over RL parameter space:[0,1]
% -k subject's working memory capacity,parameter space:2 or 3 or 4 or 5.
% -p perservation parameter for negative RL module prediction error,parameter space:[0,1].
% -fai_wm decay parameter for working memory module, parameter space:[0,1].
% -fai_rl decay parameter for reinforcement learning module, parameter space:[0,1].


function ll=wmrl(trial_seq,c,fb,n,alpha,beta_rl,beta_wm,epsilon,rho,p,fai_wm,fai_rl)
trial_number=length(c);

%initilize q table for WM and RL module
Q_RL=zeros(n,3); % the row represents different stimulus:[3 4 6], column represents different choices for different stimulus.
Q_WM=zeros(n,3);
eta=1;           % learning rate for working memory module 
weight_wm(1)=min(1,k/n)*rho;  % initial working memory weight

for trial=1:trial_number
    %compute softmax RL module policy
    pai_rl(trial)=exp(beta_rl*Q_RL(trial_seq(trial),c(trial)))/(exp(beta_rl*Q_RL(trial_seq(trial),1))+exp(beta_rl*Q_RL(trial_seq(trial),2))+exp(beta_rl*Q_RL(trial_seq(trial),3)));
    %compute softmax WM module policy
    pai_wm(trial)=exp(beta_wm*Q_WM(trial_seq(trial),c(trial)))/(exp(beta_wm*Q_WM(trial_seq(trial),1))+exp(beta_wm*Q_WM(trial_seq(trial),2))+exp(beta_wm*Q_WM(trial_seq(trial),3)));
    %Sum three policies
    pai_random=1/n;   %epsilon greedy policy: random noise
    pai_rl(trial)=(1-epsilon)*pai_rl(trial)+epsilon*pai_random;
    pai_sum(trial)=pai_rl(trial)*(1-weight_wm(trial))+weight_wm(trial)*pai_wm(trial);
    
    %update WM and RL modules' prediction error
    pe_rl(trial)=fb(trial)-Q_RL(trial_seq(trial),c(trial));
    pe_wm(trial)=fb(trial)-Q_WM(trial_seq(trial),c(trial));
    
    %sign different learning rate for positive and negative predicition error
    if pe_rl(trial)>0
        Q_RL(trial_seq(trial),c(trial))=Q_RL(trial_seq(trial),c(trial))+alpha*pe_rl(trial);
    elseif pe_rl(trial)<0
        Q_RL(trial_seq(trial),c(trial))=Q_RL(trial_seq(trial),c(trial))+(1-p)*alpha*pe_rl(trial);
    end
    Q_WM(trial_seq(trial),c(trial))=Q_WM(trial_seq(trial),c(trial))+eta*pe_wm(trial);
    
    %using a bayesian model to update WM and RL modules' weight on correct trial
    if fb(trial)==1
        marginal_wm(trial)=(weight_wm(trial)*pai_wm+(1-weight_wm(trial))*(1/n))*weight_wm(trial);
        marginal_rl(trial)=pai_rl(trial)*(1-weight_wm(trial));
        joint(trial)=marginal_rl(trial)+marginal_wm(trial);
        posterior(trial)=marginal_wm(trial)/joint(trial);
        weight_wm(trial+1)=posterior(trial);
    elseif
        weight_wm(trial+1)=weight_wm(trial);
    end
    
    %forget learnt action value
    initial_q=zeros(n,3);
    Q_WM=Q_WM+fai_wm.*(Q_WM-initial_q);       %bigger action value would forget faster
    Q_RL=Q_RL+fai_wm.*fai_rl.*(Q_RL-initial_q);  %constrain RL module's forgetting speed smaller than WM module
end

%computer the sum of log likelihood
ll=-sum(log(pai_sum));
    
    
    
    
