thetalist=[0.1;0.1;0.1;0.1;0.1;0.1];
dthetalist=[0.1;0.2;0.3;0.1;0.2;0.3];
dthetalist=[2; 1.5; 1; 2; 1.5; 1];
g = [0; 0; -9.8];
Ftip=[0;0;0;0;0;0];
InverseDynamics(thetalist,dthetalist,ddthetalist,g,Ftip,Mlist,Glist,Slist)