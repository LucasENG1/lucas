function F = rotacao(K)

EulerAngles(1) = 0;
EulerAngles(2) = pi;
EulerAngles(3) = pi/2;

% EulerAngles
% Pre-computations
sa1 = sin(EulerAngles(1));
ca1 = cos(EulerAngles(1));

sa2 = sin(EulerAngles(2));
ca2 = cos(EulerAngles(2));
ta2 = tan(EulerAngles(2));

sa3 = sin(EulerAngles(3));
ca3 = cos(EulerAngles(3));

% Linear part (3x3)
RxPhi   = [1 0 0; 0 ca1 sa1; 0 -sa1 ca1];
RyTheta = [ca2 0 -sa2; 0 1 0; sa2 0 ca2];
RzPsi   = [ca3 sa3 0; -sa3 ca3 0; 0 0 1];

M = RzPsi*RyTheta;

F = M * K;
