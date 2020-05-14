clc;close all; clear all
x = -1:0.05:1;
y = x;
z = x;

N= floor(length(x)/2);

% for i=-N:N
%     subplot(121);
%     figure(1)
%     hold on;
%     plot(x,y(i+N+1)*ones(1,length(x)),'r');
%     plot(x(i+N+1)*ones(1,length(x)),y,'r');
%
%     Xn = map(x,(i/N)*ones(1,length(x)));
%     Yn = map((i/N)*ones(1,length(x)),x);
%     axis equal;
%     axis([-1.1 1.1 -1.1 1.1])
%
%     subplot(122)
%     %     figure(2)
%     hold on;
%     plot(Xn,Yn,'m');
%     plot(Yn,Xn,'m');
%     axis equal;
%     axis([-1.1 1.1 -1.1 1.1])
% end
% close all
% grid minor
%
% % mesh(x,y,ones(length(x),length(y)))
% % figure
% % mesh(x/sqrt(2),sqrt(1-x.^2/2),ones(length(x),length(y)))

%% CUBE TO A SPHERE
x=-1:.2:1;
y=-1:.2:1;
z=-1:.2:1;

x = [[-1:.2:1] , ones(1,length(y)),-[-1:.2:1],-ones(1,length(y)) ];
y = [-ones(1,length(y)),[-1:.2:1], ones(1,length(y)), -[-1:.2:1]];

z = [-ones(1,length(x))];

X = [];
Y = [];
Z = [];

for t=-1:.5:1
    X = [X x];
    Y = [Y y];
    Z = [Z t*z];
end
for t=-1:.5:1
    X = [X x];
    Y = [Y t*y];
    Z = [Z z];
end
for t=-1:.5:1
    X = [X t*x];
    Y = [Y y];
    Z = [Z z];
end
% X = [x x x x x .1.*x];
% Y = [y y y y y .1.*y];
% Z = [z z.*.5 zeros(size(z)) -z -z.*.5 -z];

plot3(X,Y,Z)

for i=1:length(X)
    for j=1:length(Y)
        for k=1:length(Z)

            X1(i) = mapcube(X(i),Y(i),Z(i));
            Y1(i) = mapcube(Y(i),Y(i),X(i));
            Z1(i) = mapcube(Z(i),Y(i),X(i));
        end
    end
end
figure
plot3(X1,Y1,Z1)






















