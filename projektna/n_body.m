function dx = n_body(~, x) 

GM = 6.672 * 10^(-11); %gravitacijska konstanta
%N = size(x, 1)/6; 
N = 3;

x = reshape(x, [6, N])';

dx(:, 1) = x(:,4);
dx(:,2) = x(:,5);
dx(:, 3) = x(:, 6);

for i = 1:size(x,1)
    dx(i, 4:6)=0;
    for j = 1:size(x,1)
        if j~=i
            df = x(j, 1:3) - x(i, 1:3);
            %zmnozek = (df*df.').^(3/2);
            %delj = GM*df/zmnozek;
            %dx(i, 4:6) = dx(i, 4:6) + delj;
            dx(i, 4:6) = dx(i, 4:6) + GM*(df)/(df*df.').^(3/2);
        end
    end
end

dx = reshape(dx', [N*6, 1]);


end