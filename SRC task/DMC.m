%% Drift diffusiom model for conflict task
%% From Ulrich, R., et al. (2015). "Automatic and controlled stimulus processing in conflict tasks: Superimposed diffusion processes and delta functions." Cogn Psychol 78: 148-174.



%Model parameters
A=20;           %Set A=-20 for incongruent trials
tau=50; a=2;    %Parameters of mu(t) with a>1
mu_c=0.40;      %Drift rate of controlled processes
sigma=3;        %Variability parameter of diffusion process
b=50;           %Upper boundart

%Compute time-dependent drift rate mu(t)
dt=0.1;   tmax=500;  t=linspace(dt,tmax,tmax/dt);
mu=A.*exp(-t./tau).*(exp(1).*t./(a-1)./tau).^(a-1).*((a-1)./t-1/tau)+mu_c;

%Simulate time-dependent Wiener process X(t) for a single trial
dX=mu*dt+sigma*sqrt(dt)*randn(1,length(t));
X=cumsum(dX);   %cumulative sum corresponds to X(t)

%plot X(t) as a function of t
plot(t,X,'-k',[0 tmax],[b b],'-k',[0 tmax],[-b -b],'-k')
xlabel('time t (msec)');ylabel('X(t)');
line([2,2],[0,2^2*sin(2)]);
ylim([-b-20 b+20]);


