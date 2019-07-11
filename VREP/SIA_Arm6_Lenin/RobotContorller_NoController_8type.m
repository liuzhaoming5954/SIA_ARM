%% װ��ѧϰ����DMP����
clear;
% load('thetalist_circle_001.mat');
% load('thetalist_circle_01.mat');
load('traj_8.mat');
%% ���濪ʼ���з��棬������Ҫ����vrep����������
%% initialization stuff
vrep=remApi('remoteApi');
vrep.simxFinish(-1);
id = vrep.simxStart('127.0.0.1', 19997, true, true, 2000, 5);
vrep.simxSynchronous(id, true);
if id < 0
    disp('Failed connecting to remote API server. Exiting.');
    vrep.delete();
    return;
end
fprintf('Connection %d to remote API server open.\n', id);

% ��������
vrep.simxStartSimulation(id, vrep.simx_opmode_oneshot_wait);

%% Construct the joints frame for UR5
handles = struct('id', id);
jointNames={'Joint1','Joint2','Joint3','Joint4','Joint5','Joint6','Joint7'};
SIA_Arm7 = -ones(1,7); 
for i = 1:7
    [res, SIA_Arm7(i)] = vrep.simxGetObjectHandle(id, jointNames{i}, vrep.simx_opmode_oneshot_wait); 
    vrchk(vrep, res);
end
handles.Joints = SIA_Arm7;

% DMP���ƻ���
%% Get necessary stuff from the input struct


%% Initialize necessary stuff
t = length(thetalist(1,:));


%% ��ʼ����ÿ����n�Σ�����һ��λ��PID
for i = 1:t
        vrep.simxPauseCommunication(id, 1);
        for j = 1:7
            %TargetPosition = thetalist(j,i);
            vrep.simxSetJointTargetPosition(id, handles.Joints(j), thetalist(j,i), vrep.simx_opmode_oneshot);
        end
        vrep.simxPauseCommunication(id, 0);
    vrep.simxSynchronousTrigger(id);
    vrep.simxGetPingTime(id);
end

% ֹͣ����
vrep.simxStopSimulation(id, vrep.simx_opmode_oneshot_wait);
    
   
    
    
    
    
    
