
addpath('D:\MyModle\SIA_ARM\VREP\SIA_Arm6_Lenin\mr')
clear
SIA_ARM7_Lenin_parameters

% 正运动测试
thetalist_guess = [-1.39;0.1-1.57;1.8;-0.34-1.57;-1.57;1.57;0];
T = FKinSpace(M,Slist,thetalist_guess);

% 逆运动测试
thetalist_guess = [0;0;0;0;0;0;0];
T1=[0, 0, 1, 0.500; 0,1.0000, 0, 0; -1, 0, 0, 1;0,0,0,1.0000];
[thetalist1,success] = IKinSpace(Slist, M, T1, thetalist_guess,0.001, 0.001);

% 8字轨迹
t = 0:0.01:2;
x = 0.1*sin((t+1/360)*pi);
y = 0.1*sin(2*t*pi);
plot(x,y)
grid on
axis equal
comet(x,y);

% 圆形轨迹
t = 0:0.01:2*pi;
y = 0.1*sin(t) ;
x = 0.1*cos(t) + 1;
plot(x,y)
grid on
axis equal

% 生成圆形轨迹关节数据
l = length(t);
thetalist_guess = thetalist1;
for i=1:l
    T_target=[0, 0, 1, 0.500; 0,1.0000, 0, y(i); -1, 0, 0, x(i);0,0,0,1.0000];
    [thetalist_guess,success] = IKinSpace(Slist, M, T_target, thetalist_guess,0.001, 0.001);
    thetalist(:,i)=thetalist_guess;
end

% 生成8字形轨迹关节数据
L = length(t);
thetalist_guess = thetalist1;
for i=1:L
    T_target=[0, 0, 1, 0.500; 0,1.0000, 0, 0+x(i); -1, 0, 0, 1+y(i);0,0,0,1.0000];
    [thetalist_guess,success] = IKinSpace(Slist, M, T_target, thetalist_guess, 0.001, 0.001);
    thetalist(:,i)=thetalist_guess;
end

% 生成圆形轨迹关节数据(稀疏)
% 画圆轨迹(稀疏)
t = 0:0.1:2*pi;
y = 0.1*sin(t) - 0.4813;
x = 0.1*cos(t) + 0.1990;
plot(x,y)
grid on
axis equal

l = length(t);
thetalist_guess = [-1.39;0.1-1.57;1.8;-0.34-1.57;-1.57;0.18];
for i=1:l
    T_target=[-1.0000,-0.0008,0.0024,x(i); -0.0008,1.0000,-0.0089,y(i); -0.0024,-0.0089,-1.0000,0.3035;0,0,0,1.0000];
    [thetalist_guess,success] = IKinSpace(Slist, M, T_target, thetalist_guess,0.001, 0.001);
    thetalist(:,i)=thetalist_guess + [0;1.57;0;1.57;0;0];
end