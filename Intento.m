%%% fraction of contacts that can be reduced per age group %%%

clear all
clc
close all

%% load variables

load('data.mat')
ind = [1 20 40 60 70 80 85];

%% Generación de matrices de contacto

C1 = ageDist(:,2).*Household;
C2 = ageDist(:,2).*School;
C3 = ageDist(:,2).*Work;
C4 = ageDist(:,2).*General;

%% our matrices

C1_our = zeros(6,6);
C2_our = zeros(6,6);
C3_our = zeros(6,6);
C4_our = zeros(6,6);
Mi_our = zeros(6,1);
for i = 1:6
    for j = 1:6
        C1_our(i,j) = sum(C1(ind(i):ind(i+1),ind(j):ind(j+1)),'all');
        C2_our(i,j) = sum(C2(ind(i):ind(i+1),ind(j):ind(j+1)),'all');
        C3_our(i,j) = sum(C3(ind(i):ind(i+1),ind(j):ind(j+1)),'all');
        C4_our(i,j) = sum(C4(ind(i):ind(i+1),ind(j):ind(j+1)),'all');
    end
end


CT = C1_our*w.Household+C2_our*w.School+C3_our*w.Work+C4_our*w.General;
rho = 1/max(eig(CT));
CT = rho*(CT);
%C_vol = 0.7*C4_our*w.General+0.2*C3_our*w.Work+0.1*C2_our*w.School;

C_vol           = rho*((1/3) * C3_our*w.Work + (1/2) * C4_our*w.General);
C_NPI_work      = rho*((1/3) * C3_our*w.Work);
C_NPI_School    = rho*(C2_our*w.School);
C_NPI_general   = rho*((1/2) * C4_our*w.General);
C_Base          = rho*(C1_our*w.Household +(1/3) * C3_our*w.Work);


%% check

CT == C_vol+C_NPI_work+C_NPI_School+C_NPI_general+C_Base
%% Percentage of contacts that are reductible

writematrix(C_vol,'C_vol.csv') 
writematrix(C_NPI_work,'C_NPI_work.csv') 
writematrix(C_NPI_School,'C_NPI_School.csv') 
writematrix(C_NPI_general,'C_NPI_general.csv') 
writematrix(C_Base,'C_Base.csv') 