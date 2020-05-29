%==========================================================================
% From the BF frame TO the NED frame
%
% This function transforms a six-dimensional vector in the Body-Fixed (BF)
% reference frame into a vector in the (inertial) North-East-Down (NED)
% reference frame. The vector has to be comprised of two three-dimensional
% subvectors, the 1st regarding linear quantities, e.g. forces, linear ac-
% celerations, or linear velocities, and the 2nd regarding angular quan-
% tities, e.g. moments, angular accelerations, or angular velocities
%==========================================================================
function NEDVector3 = BF2NED(EulerAngles, BFVector)
% EulerAngles
% Pre-computations
% sa1 = sin(EulerAngles(1));
% ca1 = cos(EulerAngles(1));
% 
% sa2 = sin(EulerAngles(2));
% ca2 = cos(EulerAngles(2));
% ta2 = tan(EulerAngles(2));
% EulerAngles = EulerAngles *DEG_TO_RAD;
sa3 = sin(EulerAngles);
ca3 = cos(EulerAngles);

% Linear part (3x3)
% RxPhi   = [1 0 0; 0 ca1 -sa1; 0 sa1 ca1];
% RyTheta = [ca2 0 sa2; 0 1 0; -sa2 0 ca2];
% RzPsi   = [ca3 -sa3 0; sa3 ca3 0; 0 0 1];
RzPsi   = [ca3 -sa3 0; sa3 ca3 0; 0 0 1];
% J1
% linBFToNED = RzPsi*RyTheta*RxPhi;

% Angular part (3x3) J2
% angBFToNED = [1 sa1*ta2 ca1*ta2; 0 ca1 -sa1; 0 sa1/ca2 ca1/ca2];

% Complete frame transformation matrix (6x6)
% Matrix = [linBFToNED zeros(3); zeros(3) angBFToNED]; %JN

% Vector in the NED frame
% NEDVector = Matrix*BFVector; % Completo
% NEDVector = Matrix*BFVector % Completo
NEDVector3 = RzPsi*BFVector;