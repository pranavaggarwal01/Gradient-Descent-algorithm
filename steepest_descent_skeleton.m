
%% Data generation. 
% Here we create a 2D grid with sample positions specified with w1s and w2s,
% then compute our target function g(x,y) for each (x,y) pair on the grid.
% Finally you should be able to visualize g(x,y) with a single line of
% code. 

clear all;
w1s = -10:0.5:10;
w2s = -10:0.5:10;
warning ('off','all');
[w1, w2] = meshgrid(w1s,w2s);
[m, n] = size(w1);
w = [reshape(w1,1,m*n); reshape(w2,1,m*n)];

x1 = [0.5;0.3]; y1 = 0.2;
x2 = [1.5;2]; y2 = 0.3;

for i = 1:1:m*n
    g(i) = (x1' * w(:,i) - y1)^2 + (x2' * w(:,i) - y2)^2;
end
g = reshape(g,m,n);

mesh(g);

%% function minimization via gradient descent
current = [-5 , -8]; % current position, set to starting position
path = []; % a stack that keep a history of current position
stepsize = 0.01;

found = 0; 
i = 0;
while found ~= 1 && i <500 % this ensures that maximum iteration is 500
    i = i+1;
 
    path(i,1) = current(1);
    path(i,2) = current(2);
    J(i) = (current * x1 - y1)^2 + (current * x2 - y2)^2;
  
    gradient = x1'*(current * x1 - y1) + x2'*(current * x2 - y2);
    if sqrt(gradient(1)^2 + gradient(2)^2) < 0.2
        found = 1;
    else
        w = current - stepsize * gradient;
        current = w;    
    end
end
disp('The weights got after gradient descent are:')
disp(w)
%% visualize the path
syms x11
syms x21
eq = w(1) * x11 + x21 * w(2) == 0;
figure
ezplot(eq)
hold on;
plot([0.5 1.5],[0.3 2],'*');
xlabel('x1')
ylabel('x2')
hold off;

figure
scatter3(path(:,1),path(:,2),J,'filled');
hold on
plot3(path(:,1),path(:,2),J);
hold off;