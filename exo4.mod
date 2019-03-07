%this is my mod file reproducing the monetary policy course
%including the taylor rule and Fischer relationship between nominal and real interest rate
%by mikel casares (week1). First RBC model

%Defining the variables, and parameters of the model

var
    y,
    c,
    x,
    k,
    ns,
    nd,
    w,
    rk,
    r,
    R,
    pi,
    z,
    eps_g,
    g_M
    ;


varexo eps_z,u_g;

parameters alphha,h, betta, rhoo,deltta,sigmma,gammma,rho_z,psii,gy,pi_ss,mu_R,mu_pi,mu_y,rho_eps_g;

alphha  =   0.36;
h       =   0.75;
rhoo    =   0.01;
betta   =   1/(1+rhoo);
deltta  =   0.025;
sigmma  =   1.5;
gammma  =   2;
rho_z   =   0.95;
gy      =   0.25;
psii    =   (1-alphha)*(betta*alphha/(1-betta+betta*deltta))^(alphha/(1-alphha))/
(((1-h)*(1-deltta*betta*alphha/(1-betta+betta*deltta)-gy)*(betta*alphha/(1-betta+betta*deltta))^(alphha/(1-alphha)))^(sigmma));
mu_pi    =   1.5;
mu_y     =   0.125;
mu_R     =   0.85;
pi_ss    =   0.0075;
rho_eps_g=   0.8;

model;
(c-h*c(-1))^(-sigmma)/(1+r)=betta*(c(+1)-h*c)^(-sigmma);
r=rk-deltta;
w=psii*ns^gammma/(c-h*c(-1))^(-sigmma);
y=c+x+exp(eps_g)*gy*steady_state(y);
y=exp(z)*k(-1)^alphha*nd^(1-alphha);
w=(1-alphha)*y/nd;
rk=alphha*y/k(-1);
x=k-(1-deltta)*k(-1);
nd=ns;
z=rho_z*z(-1)+eps_z;
1+R=((1+steady_state(r))*(1+pi_ss)^(1-mu_pi))^(1-mu_R)*(1+R(-1))^(mu_R)*((1+pi)^((1-mu_R)*mu_pi))*(y/y(-1))^((1-mu_R)*mu_y);
1+r=(1+R)/(1+pi(+1));
eps_g=rho_eps_g*eps_g(-1)+u_g;
g_M=c/c(-1)*(1+pi)-1;
end;

steady_state_model;
  // Compute some steady state ratios.
  y_per_unit_of_k=(1-betta+betta*deltta)/(betta*alphha);
  x_per_unit_of_y=deltta*1/y_per_unit_of_k;
  c_per_unit_of_y=1-x_per_unit_of_y-gy;

  // Compute steady state of the endogenous variables.
  nd=1;
  ns=1;
  z=0;
  pi=pi_ss;
  r=1/betta-1;
  R=(1+r)*(1+pi)-1;
  rk=1/betta-1+deltta;
  y=(1/y_per_unit_of_k)^(alphha/(1-alphha));
  w=(1-alphha)*y;
  k=y/y_per_unit_of_k;
  x=x_per_unit_of_y*y;
  c=c_per_unit_of_y*y;
  g_M=pi;
end;

shocks;
var eps_z = 0.07^2;
var u_g   =0.1^2;
end;
steady;
model_diagnostics;

//Business cycle simulations
stoch_simul(order=1,irf=40,nograph,periods=200) y c x k ns nd w rk r z R pi eps_g g_M;

