function BFVector3 = NED2BF(EulerAngles, NEDVector)

sa3 = sin(EulerAngles);
ca3 = cos(EulerAngles);
RzPsi   = inv([ca3 -sa3 0; sa3 ca3 0; 0 0 1]);

BFVector3 = RzPsi*NEDVector;
end