function [t] = BLS(q,s,g,t,c,grd_c)
    % x1, x2 is variable
    % gradient1 is x1's gradient, and gradient2 is x2's graditent
    % t is step size , the one you need to iterate
    % fg is the function handle, you can directly use fg(x) to call the
    % function
    

% Apply your code here
    alpha = 0.1;
    beta = 0.707;
    deltax = -(grd_c/norm(grd_c));
    dx_g = (grd_c')*deltax;
    
    a = c(q(1,1)+t*deltax(1,1), q(2,1)+t*deltax(2,1), q(3,1)+t*deltax(3,1), q(4,1)+t*deltax(4,1), s(1,1), s(1,2), s(1,3), g);
    b = c(q(1,1),q(2,1),q(3,1),q(4,1),s(1,1),s(1,2),s(1,3),g);
    
    while a > b + alpha*t*dx_g
         
         t = t*beta;
         a = c(q(1,1)+t*deltax(1,1),q(2,1)+t*deltax(2,1),q(3,1)+t*deltax(3,1),q(4,1)+t*deltax(4,1),s(1,1),s(1,2),s(1,3),g);
    end
end