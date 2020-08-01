clc
clear all
%%
%Data Assimilation
t_set=xlsread('data_grain.xlsx');%define the trainning set
y_cat=categorical(t_set(:,4));
year=t_set(:,1);
dat1=t_set(:,2);
dat2=t_set(:,3);
x=[dat1 dat2];

%%
%Binomial Regression and Generating Proability Time Series
[B,dev,stats] = mnrfit(x,y_cat);
prob_data=abs((B(1,1)*(dat1))+(B(2,1)*(dat2))+(B(3,1)));

%%
%Hindcast Routine
count=0;
%Loop for computing mean probability of TRUE events
for j=1:length(y_cat)
    if t_set(j,4)==1
        matter(j)=prob_data(j);
        count=count+1;
    end    
end
avg=sum(matter)/count;
%Loop for computing index of TRUE events based on a 75% threshold sensitivity
for i=1:length(year)
    if abs(prob_data(i))<0.75*avg
        cycl_hind_cast(i)=year(i);
    end 
end



