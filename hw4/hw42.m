clear;clc;
acc= xlsread('D:\HW4-2','sheet1');
n=length(acc);

g=9.8;
error= @(q1,q2,q3,q4,ax,ay,az) [-2*g*(q2*q4-q1*q3)-ax;
                            -2*g*(q1*q2+q3*q4)-ay;
                            -2*g*(0.5-(q2^2)-(q3^2))-az];
J= @(q1,q2,q3,q4) (-2*g)*[-q3 q4 -q1 q2;
                            q2 q1 q4 q3;
                            0 -2*q2 -2*q3 0];
c = @(q1,q2,q3,q4,ax,ay,az,g) (ax - 2*g*(q1*q3 - q2*q4))*((ax) - 2*(g)*((q1)*(q3) - (q2)*(q4))) ...
                            + (ay + 2*g*(q1*q2 + q3*q4))*((ay) + 2*(g)*((q1)*(q2) + (q3)*(q4))) ...
                            + ((az) - 2*(g)*((q2)^2 + (q3)^2 - 1/2))*(az - 2*g*(q2^2 + q3^2 - 1/2));

grd_c = @(q1,q2,q3,q4,ax,ay,az,g) [2*(g)*(q2)*(ay + 2*g*(q1*q2 + q3*q4)) - 2*(g)*(q3)*(ax - 2*g*(q1*q3 - q2*q4));
                                   2*(g)*(q4)*(ax - 2*g*(q1*q3 - q2*q4)) + 2*(g)*(q1)*(ay + 2*g*(q1*q2 + q3*q4)) - 4*(g)*(q2)*(az - 2*g*(q2^2 + q3^2 - 1/2));
                                   2*(g)*(q4)*(ay + 2*g*(q1*q2 + q3*q4)) - 2*(g)*(q1)*(ax - 2*g*(q1*q3 - q2*q4)) - 4*(g)*(q3)*(az - 2*g*(q2^2 + q3^2 - 1/2));
                                   2*(g)*(q2)*(ax - 2*g*(q1*q3 - q2*q4)) + 2*(g)*(q3)*(ay + 2*g*(q1*q2 + q3*q4))];
for k = 1:n
    
    q=[1;0;0;0];
    t=1;
    
    for i = 1:500
        
        grd_C = grd_c(q(1),q(2),q(3),q(4),acc(k,1),acc(k,2),acc(k,3),g);
        step_size = BLS(q,acc(k,:),g,t,c,grd_C);
        q = q - step_size*(grd_C/norm(grd_C));     
    end
    quaternion(k,:)=q';
end
attitude=quaternion

for j=1:100
q1(j,1)=attitude(j,1);
q2(j,1)=attitude(j,2);
q3(j,1)=attitude(j,3);
q4(j,1)=attitude(j,4);
end
subplot(4,1,1)
plot(q1);
title('q1');
subplot(4,1,2)
plot(q2);
title('q2');
subplot(4,1,3)
plot(q3);
title('q3');
subplot(4,1,4)
plot(q4);
title('q4');