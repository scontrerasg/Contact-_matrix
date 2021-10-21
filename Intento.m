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
for i = 1:6
    for j = 1:6
        C1_our(i,j) = sum(C1(ind(i):ind(i+1),ind(j):ind(j+1)),'all');
        C2_our(i,j) = sum(C2(ind(i):ind(i+1),ind(j):ind(j+1)),'all');
        C3_our(i,j) = sum(C3(ind(i):ind(i+1),ind(j):ind(j+1)),'all');
        C4_our(i,j) = sum(C4(ind(i):ind(i+1),ind(j):ind(j+1)),'all');
    end
end


CT = C1_our*w.Household+C2_our*w.School+C3_our*w.Work+C4_our*w.General;
C_vol = C4_our*w.General+0.3*C3_our*w.Work;

%% Percentage of contacts that are reductible

p = CT./C_vol;
writematrix(p,'reductible_contacts.csv') 