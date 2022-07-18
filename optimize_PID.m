close all;
clear;
clc;

a = 5000;
b = 0;
for s1 = -0.1:0.01:0.1 %skanarw times gia ton polo 1
    for s2 = -0.1:0.01:0.1 %skanarw times gia ton polo 2
        for s3 = -0.1:0.01:0 %skanarw times gia ton polo 3
        syms Ki Kd Kp;
        %vasi twn polwn ypologizw ta Kd Ki Kp
        eq1 = (s1)^6 -28.27*(s1)^5 -80.3*(s1)^4 -97.36*(s1)^3 +(9461*Kd-63.01)*(s1)^2 + (9461*Kp-97.82)*(s1)+9461*Ki == 0;
        eq2 = (s2)^6 -28.27*(s2)^5 -80.3*(s2)^4 -97.36*(s2)^3 +(9461*Kd-63.01)*(s2)^2 + (9461*Kp-97.82)*(s2)+9461*Ki == 0;
        eq3 = (s3)^6 -28.27*(s3)^5 -80.3*(s3)^4 -97.36*(s3)^3 +(9461*Kd-63.01)*(s3)^2 + (9461*Kp-97.82)*(s3)+9461*Ki == 0;
        sol = solve ([eq1,eq2,eq3] , [Ki Kd Kp]);
        Ki  = double(sol.Ki);
        Kd  = double(sol.Kd);
        Kp  = double(sol.Kp);
        %ypologizw tous ypoloipous 3 polous
        x = roots([1 -28.27 -80.3 -97.36 (9461*Kd-63.01) (9461*Kp-97.82)  9461*Ki]);
        
        %krataw to pragmatiko meros twn polwn
        roots_real_part = real(x);
        %epilegw to megisto
        max_real_part = max(roots_real_part);
        b = b+1; %counter twn epanalipsewn
        
       %ean i megisti timi einai mikroteri tis proigoumenis megistis
       %kai epipleon ta Kd Kp Ki einai diafora tou midenos krataw
       %tis mexri ekeini ti stigmi veltistes lyseis
         if max_real_part < a
             a = max_real_part;
             roots_best = roots_real_part;
             Kd_best = Kd;
             Kp_best = Kp;
             Ki_best = Ki;
         end
        end
    end
end
%veltistes times
roots_best
Kd_best
Kp_best
Ki_best