function ANG =  Angle_entre_vecs(V1,V2)

MO = norm(V1);
MR = norm(V2);
MOR = norm((V1-V2));

cos_a = (MOR^2-MO^2-MR^2)/(-2*MO*MR);

ANG = acos(cos_a);

end