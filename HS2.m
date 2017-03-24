clc;

load('result.mat');

N = length(vector);
M = length(x);

z = zeros(1, M);

for i = 1 : M
    z(i) = i;
end

sum1 = 0; sum2 = 0; sum3 = 0;
i = M;
A(1, :) = -ones(1, M);
A(2, :) = -ones(1, M);
min = 1; k = 2; l = 0;

while (length(unique(z)) ~= 1)
    sum3 = sum(y);
    min = M;
    level1 = 0;
    level2 = 0;
    
    for i = M : -1 : 1
        sum1 = 0;
        for j = 1 : M
            if (z(i) == z(j))
                sum1 = sum1 + y(j);
            end
        end
        if (sum1 < sum3)
            sum3 = sum1;
            min = i;
        end
    end
    
    i = min;
    sum1 = sum3;
    
    min = M;
    sum3 = sum(y);
    for j = M : -1 : 1
        if (i ~= j && z(i) ~= z(j))
            sum2 = 0;
            for l = M : -1 : 1
                if (z(l) == z(j))
                    sum2 = sum2 + y(l);
                end
            end
            
            if (sum1 + sum2 < sum1 + sum3)
                sum3 = sum2;
                min = j;
            end
            
        end
    end
   
    if (A(k, i) ~= -1 || A(k, min) ~= -1)
        k = k + 1;
        A(k, :) = -ones(1, M);
    end
    
    sum2 = sum3;
    
    for j = 1 : M
        if (sum2 >= sum1)
            if (z(j) == z(min))
                A(k, j) = 0;
            elseif (z(j) == z(i))
                A(k, j) = 1;
            end
        else
            if (z(j) == z(min))
                A(k, j) = 1;
            elseif (z(j) == z(i))
                A(k, j) = 0;
            end
        end
    end
    
    for j = 1 : M
        if (z(j) == z(min))
            z(j) = z(i);
        end
    end
    
end

original = char(32);    % space
possible = ones(1, M);

j = M; k = size(A, 1); q = 1;
for i = 1 : N
    
    for j = 1 : M
        if (A(k, j) ~= vector(i));
            possible(j) = 0;
        end
    end
    
    if (sum(possible) == 1)
        j = find(possible == 1);
        original(q) = x(j);
        k = size(A, 1);
        possible = ones(1, M);
        q = q + 1;
    else
        k = k - 1;
    end
    
end

originalFile = fopen('exemplu2.txt', 'wt');
fprintf(originalFile, '%s', original);
fclose('all');
