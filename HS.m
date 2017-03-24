
clc;

exemplu = importdata('exemplu.txt');
original = exemplu{1};
if (size(exemplu, 1) ~= 1)
    for i = 2 : size(exemplu, 1)
        original = [original char(10) exemplu{i}];
    end
end
N = length(original);

x = unique(original);
M = length(x);

y = zeros(1, M);

for i = 1 : M
   for j = 1 : N
       if (original(j) == x(i))
           y(i) = y(i) + 1;
       end
   end
end

[x, y] = quicksort(x, y);

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

vector = zeros(1, 2);
i = 1; k = size(A, 1); q = 1;
for i = 1 : N
    k = size(A, 1);
    j = find(x == original(i));
    while (A(k, j) ~= -1 || length(unique(A(1:k, j))) ~= 1)
        vector(1, q) = A(k, j);
        k = k - 1;
        q = q + 1;
    end

end

save('result.mat', 'x', 'y', 'vector');
