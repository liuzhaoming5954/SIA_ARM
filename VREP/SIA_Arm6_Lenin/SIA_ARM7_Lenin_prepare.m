addpath('D:\MyModle\SIA_ARM\VREP\SIA_Arm6_Lenin\mr')
clear
SIA_ARM7_Lenin_parameters

% ���˶�����
thetalist_guess = [-1.39;0.1-1.57;1.8;-0.34-1.57;-1.57;1.57;0];
T = FKinSpace(M,Slist,thetalist_guess);

% ���˶�����
thetalist_guess = [0;0;0;0;0;0;0];
T1=[0, 0, 1, 0.500; 0,1.0000, 0, 0; -1, 0, 0, 1;0,0,0,1.0000];
[thetalist1,success] = IKinSpace(Slist, M, T1, thetalist_guess,0.001, 0.001);

% 8�ֹ켣
t = 0:0.01:2;
x = 0.1*sin((t+1/360)*pi);
y = 0.1*sin(2*t*pi);
plot(x,y)
grid on
axis equal
comet(x,y);

% Բ�ι켣
t = 0:0.01:2*pi;
y = 0.1*sin(t) ;
x = 0.1*cos(t) + 1;
plot(x,y)
grid on
axis equal

% ����Բ�ι켣�ؽ�����
l = length(t);
thetalist_guess = thetalist1;
for i=1:l
    T_target=[0, 0, 1, 0.500; 0,1.0000, 0, y(i); -1, 0, 0, x(i);0,0,0,1.0000];
    [thetalist_guess,success] = IKinSpace(Slist, M, T_target, thetalist_guess,0.001, 0.001);
    thetalist(:,i)=thetalist_guess;
end

% �������8���ι켣�ؽ�����
L = length(t);
thetalist_guess = thetalist1;
for i=1:L
    T_target=[0, 0, 1, 0.500; 0,1.0000, 0, 0+x(i); -1, 0, 0, 1+y(i);0,0,0,1.0000];
    [thetalist_guess,success] = IKinSpace(Slist, M, T_target, thetalist_guess, 0.001, 0.001);
    thetalist(:,i)=thetalist_guess;
end


% ����Բ�ι켣�ؽ�����(ϡ��)
% ��Բ�켣(ϡ��)
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

% 8���ιؽ����ݹ켣��
 L = length(t);  dt=0.01;
 % thetalist = thetalist';
 % ����ٶ�
 JointsVelocity(1:7,1)=[0,0,0,0,0,0,0];
%  thetalist(8:14,1)=[0,0,0,0,0,0,0];
    for i=2:L-1
        JointsVelocity(1:7,i)=(thetalist(1:7,i+1)-thetalist(1:7,i-1))/(2*dt);
    end
 JointsVelocity(1:7,L)=[0,0,0,0,0,0,0];
 % �����ٶ�
    for i=1:L-1
%         thetalist(15:21,i)=(thetalist(8:14,i+1)-thetalist(8:14,i))/dt;
        JointsAcceleration(1:7,i)=(JointsVelocity(1:7,i+1)-JointsVelocity(1:7,i))/dt;
    end
 JointsAcceleration(1:7,L)=[0,0,0,0,0,0,0];
 
 targetJointsActual = thetalist';
 JointsVelocity = JointsVelocity';
 JointsAcceleration = JointsAcceleration';
 
 %thetalist = thetalist';











