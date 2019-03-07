%% this file is supposed to solve the exercices of mikel casares 
% from its monetary policy course, p15
% First we created a .mod file for the CIA model (exo4.mod)
% calibrated according to the parameters values (see pdf)
clear all;
close all;
%We can run the first file
dynare exo4


%% It is then asked in a second question to create two plots.
% First we have to put the IRF for ouput, technology shock,
% consumption and investment to a 1% technology deviation in
% the same plot. 

figure
subplot(2,1,1);
plot(0:40,(1/oo_.steady_state(1))*[0 ; y_eps_z(1:40)],'k',0:40,[0 ; z_eps_z(1:40)],'k--',0:40,(1/oo_.steady_state(2))*[0 ; c_eps_z(1:40)],'k:',0:40,(1/oo_.steady_state(3))*[0 ; x_eps_z(1:40)],'k*','LineWidth',2);
title('IRF to tech. shock');
ylabel(' %');
xlabel('Quarters after the shock');
legend({'Output','Tech. shock','Cons.','Inv.'},'Location','northeast')

%In A second plot we have to summarise the IRF to tech. shock for the
%labor, stock of capital and real wage:

subplot(2,1,2);
plot(0:40,(1/oo_.steady_state(4))*[0 ; k_eps_z(1:40)],'k-.',0:40,4*[0 ; ns_eps_z(1:40)],'k-o',0:40,4*[0 ; w_eps_z(1:40)],'k+','LineWidth',2);
title('IRF to tech. shock');
ylabel('%');
xlabel('Quarters after the shock');
legend({'Capital stock','Labour supply','Real wage',},'Location','northeast')

%% monetary shock
figure
subplot(2,1,1);
plot(0:40,(1/oo_.steady_state(1))*[0 ; y_u_g(1:40)],'k',0:40,(1/oo_.steady_state(9))*[0 ; r_u_g(1:40)],'k-',0:40,(1/oo_.steady_state(2))*[0 ; c_u_g(1:40)],'k:',0:40,(1/oo_.steady_state(3))*[0 ; x_u_g(1:40)],'k*',0:40,[0 ; g_M_u_g(1:40)],'k--','LineWidth',2);
title('IRF to monetary shock');
ylabel(' %');
xlabel('Quarters after the shock');
legend({'Output','Nom. interest rate','Cons.','Inv.','g_m'},'Location','northeast')

%In A second plot we have to summarise the IRF to tech. shock for the
%labor, stock of capital and real wage:

subplot(2,1,2);
plot(0:40,(1/oo_.steady_state(4))*[0 ; k_u_g(1:40)],'k-.',0:40,4*[0 ; ns_u_g(1:40)],'k-o',0:40,4*[0 ; w_u_g(1:40)],'k+','LineWidth',2);
title('IRF to monetary shock');
ylabel('%');
xlabel('Quarters after the shock');
legend({'Capital stock','Labour supply','Real wage',},'Location','northeast')
%% question iii), create with the 200 obs., 3 plots

%in the first one we plot together Output, Investment and consumption

%Artificial series
nobs=200;
figure
subplot(2,1,1);
plot(1:nobs,oo_.endo_simul(1,1:nobs),'k',1:nobs,oo_.endo_simul(3,1:nobs),'r--',1:nobs,oo_.endo_simul(2,1:nobs),'b:','LineWidth',1.5);
title('Artificial series');
ylabel('Level');
xlabel('Quarters');
subplot(2,1,2);
plot(1:nobs,(1/oo_.steady_state(1))*oo_.endo_simul(1,1:nobs),'k',1:nobs,(1/oo_.steady_state(3))*oo_.endo_simul(3,1:nobs),'r--',1:nobs,(1/oo_.steady_state(2))*oo_.endo_simul(2,1:nobs),'b:','LineWidth',1.5)
title('Relative deviations from Steady state');
ylabel('% ');
xlabel('Quarters');
legend({'Output','Investment','Consumption',},'Location','northeast')

%Second plot, Output, technology shock and nominal money growth rate:
figure
subplot(2,1,1);
plot(1:nobs,oo_.endo_simul(1,1:nobs),'k',1:nobs,oo_.endo_simul(12,1:nobs),'r--',1:nobs,4*oo_.endo_simul(14,1:nobs),'b-.','LineWidth',1);
title('Output, technology shock and nom. monetary growth rate');
ylabel('Level deviations from steady state');
xlabel('Quarters');
subplot(2,1,2);
plot(1:nobs,(1/oo_.steady_state(1))*oo_.endo_simul(1,1:nobs),'k',1:nobs,oo_.endo_simul(12,1:nobs),'r--',1:nobs,4*oo_.endo_simul(14,1:nobs),'b-.','LineWidth',1);
title('Output and technology shock');
ylabel('%');
xlabel('Quarters');
legend({'Output','tech. shock','Nom. money growth rate',},'Location','northeast')

%% Last plot, Inflation, nom money growth rate, and real interest rate
figure
plot(1:nobs,4*oo_.endo_simul(11,1:nobs),'k',1:nobs,4*oo_.endo_simul(10,1:nobs),'r--',1:nobs,4*oo_.endo_simul(14,1:nobs),'b-.','LineWidth',1);
title('Annual inflation, Real int. rate and Nom. money growth rate');
ylabel('%');
xlabel('Quarters');
legend({'Infl.','Real int. rate','Nom. money growth rate',},'Location','northeast')

clear all;
close all;
%% Next, we had downloaded the following US data for the period 198:4,201:4
% we have to now to load them into matlab. The name of the file is us_data.
% the first column is the date, the second is the GDP, the third is the gdp
% deflator, and the last one is M1
gdp_us=table2array(usdata(1:121,2));
gdpdef_us=table2array(usdata(1:121,3));
gdp_m1=table2array(usdata(1:121,4));
time=121;

subplot(3,1,1);
plot(1:time,gdp_us(1:121),'k','LineWidth',1.5)
ylabel('GDP quart. Seas. adj');
title('GDP,GDP def. and M1');
subplot(3,1,2);
plot(1:time,gdpdef_us(1:121),'k','LineWidth',1.5)
ylabel('GDP def.');
subplot(3,1,3);
plot(1:time,gdp_m1(1:121),'k','LineWidth',1.5)
ylabel('M1');
xlabel('Quarters');

% Economic growth rate:
g_gdp=(gdp_us(2:121)-gdp_us(1:120))./gdp_us(1:120);
%inflation growth rate:
g_inf=(gdpdef_us(2:121)-gdpdef_us(1:120))./gdpdef_us(1:120);
%growth of nominal money:
g_mon=(gdp_m1(2:121)-gdp_m1(1:120))./gdp_m1(1:120);

figure
time2=120;
plot(1:time2,g_gdp(1:120),'k-',1:time2,g_inf(1:120),'r--',1:time2,g_mon(1:120),'b-.','LineWidth',1.5)
ylabel('%');
xlabel('Quarters');
legend({'Eco growth rate','Infl. rate','Nom. money growth rate',},'Location','northeast')



%% Cross correlation:

%between GDP and inflation:
gdp_inf=corrcoef(g_gdp,g_inf)
%gdp_inf=0.058

%between GDP and money:
gdp_mon=corrcoef(g_gdp,g_mon)
%gdp_mon=-0.35

%between inflation and money:
inf_mon=corrcoef(g_inf,g_mon)
%inf_mon=-0.16

%% auto correlation
%gdp
Mdl=arima(1,0,0);
Mdl.Constant = 0;
EstMdl=estimate(Mdl,g_gdp)
%ar_gdp=0.7
%std=0.075

%Inflation
Mdl=arima(1,0,0);
Mdl.Constant = 0;
EstMdl=estimate(Mdl,g_inf)
%ar_inf=0.93
%std=0.036

%Money
Mdl=arima(1,0,0);
Mdl.Constant = 0;
EstMdl=estimate(Mdl,g_mon)
%ar_mon=0.81
%std=0.039

%% real money

real_mon=gdp_m1(1:121)./gdpdef_us(1:121);
plot(1:time,real_mon(1:121),'k-','LineWidth',1.5)
mean_real_mon=mean(real_mon)
%Average value for the period considered (1988:1,201:4)=1.7658e+10
%% we have to calculate the inflation mean
mean_inf=4*mean(g_inf)
%2.12 percent annually corresponding to 0.0053 per quarter

%we have to calculate the value for upsilon,
% it is suppose to match the steady ratio of real money (m) over GDP (y)
% first we need to put the two series into the same unit. 
% for that purpose we have to express GDP in dollars instead of billion
% dollars:
gdp_us_d=gdp_us(1:121).*10^9;
Ups=real_mon(1:121)./gdp_us_d(1:121);
mean(Ups)
%Upsilon=0.0013
%% Now everything has been calibrated,
% we can run dynare and the second mod file (MIU.mod)
clear all;
close all;
dynare MIU
%% IRF

%% It is then asked in a second question to create two plots.
% First we have to put the IRF for ouput, technology shock,
% consumption and investment to a 1% technology deviation in
% the same plot. 

figure
subplot(2,1,1);
plot(0:40,(1/oo_.steady_state(1))*[0 ; y_eps_z(1:40)],'k',0:40,(1/oo_.steady_state(2))*[0 ; c_eps_z(1:40)],'--',0:40,(1/oo_.steady_state(3))*[0 ; x_eps_z(1:40)],':',0:40,(1/oo_.steady_state(5))*[0 ; k_eps_z(1:40)],'*',0:40,(1/oo_.steady_state(4))*[0 ; ns_eps_z(1:40)],'o',0:40,(1/oo_.steady_state(7))*[0 ; w_eps_z(1:40)],'p',0:40,(1/oo_.steady_state(8))*[0 ; m_eps_z(1:40)],'s','LineWidth',1);
title('IRF to tech. shock');
ylabel(' %');
xlabel('Quarters after the shock');
legend({'Output','Cons.','Inv.','Cap.','labour','wage','Real money'},'Location','northeast')

%In A second plot we have to summarise the IRF to tech. shock for the
%labor, stock of capital and real wage:

subplot(2,1,2);
plot(0:40,4*[0 ; r_eps_z(1:40)],'-.',0:40,4*[0 ; pi_eps_z(1:40)],'-o',0:40,4*[0 ; R_eps_z(1:40)],'k+',0:40,4*[0 ; g_M_eps_z(1:40)],'k+','LineWidth',2);
title('IRF to tech. shock');
ylabel('%');
xlabel('Quarters after the shock');
legend({'Nom. int rate','Inflation','Real int. rate','Nom. money growth rate'},'Location','northeast')

%% monetary shock
figure
subplot(2,1,1);
plot(0:40,(1/oo_.steady_state(1))*[0 ; y_u_g(1:40)],'k',0:40,(1/oo_.steady_state(2))*[0 ; c_u_g(1:40)],'--',0:40,(1/oo_.steady_state(3))*[0 ; x_u_g(1:40)],':',0:40,(1/oo_.steady_state(5))*[0 ; k_u_g(1:40)],'*',0:40,(1/oo_.steady_state(4))*[0 ; ns_u_g(1:40)],'o',0:40,(1/oo_.steady_state(7))*[0 ; w_u_g(1:40)],'p',0:40,(1/oo_.steady_state(8))*[0 ; m_u_g(1:40)],'s','LineWidth',1);
title('IRF to mon. shock');
ylabel(' %');
xlabel('Quarters after the shock');
legend({'Output','Cons.','Inv.','Cap.','labour','wage','Real money'},'Location','northeast')

%In A second plot we have to summarise the IRF to tech. shock for the
%labor, stock of capital and real wage:

subplot(2,1,2);
plot(0:40,4*[0 ; r_u_g(1:40)],'-.',0:40,4*[0 ; pi_u_g(1:40)],'-o',0:40,4*[0 ; R_u_g(1:40)],'k+',0:40,4*[0 ; g_M_u_g(1:40)],'k+','LineWidth',1);
title('IRF to monetary shock');
ylabel('%');
xlabel('Quarters after the shock');
legend({'Nom. int rate','Inflation','Real int. rate','Nom. money growth rate'},'Location','northeast')
