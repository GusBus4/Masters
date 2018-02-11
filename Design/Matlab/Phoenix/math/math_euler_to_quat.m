function [ q1, q2, q3, q4 ] = math_euler_to_quat( roll, pitch, yaw )
%MATH_EULER_TO_QUAT Summary of this function goes here
%   Detailed explanation goes here

    cr2 = cos(roll*0.5);
    cp2 = cos(pitch*0.5);
    cy2 = cos(yaw*0.5);
    sr2 = sin(roll*0.5);
    sp2 = sin(pitch*0.5);
    sy2 = sin(yaw*0.5);

    q1 = cr2*cp2*cy2 + sr2*sp2*sy2;
    q2 = sr2*cp2*cy2 - cr2*sp2*sy2;
    q3 = cr2*sp2*cy2 + sr2*cp2*sy2;
    q4 = cr2*cp2*sy2 - sr2*sp2*cy2;

end

