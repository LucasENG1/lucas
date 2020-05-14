close all 
clear all
clc

Barco = [3,3]
Ant = [0,0]
Post = [5,2]

figure 
plot([Ant(1) Barco(1)],[Ant(2) Barco(2)],'r','linewidth',2);
hold on;
plot([Ant(1) Post(1)],[Ant(2) Post(2)],'b','linewidth',2);


O = distanceAB(Barco,Ant);
R2 = distanceAB(Post,Ant);

MO = norm(O);
MR = norm(R2);
MOR = norm((O-R2));

cos_a = (MOR^2-MO^2-MR^2)/(-2*MO*MR);

a = acos(cos_a)

dist  = MO*sin(a)
