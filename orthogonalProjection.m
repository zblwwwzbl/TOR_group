function xproj = orthogonalProjection(u)
    x = [u(1), u(2)];
    xproj = x;
    if (x(2)<=0)
        xproj(2) = 0;
        if (x(1) < -1)
            xproj(1) = -1;
        elseif (x(1) > 1)
            xproj(1) = 1;
        end
    elseif (x(1)^2 + x(2)^2 >= 1)
        k = sqrt(1/(x(1)^2 + x(2)^2));
        xproj = k*xproj;
    end
end