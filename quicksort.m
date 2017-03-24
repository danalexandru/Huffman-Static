function [x, y] = quicksort(x, y)

% Knobs
kk = 15; % Insertion sort threshold, kk >= 1

% Quicksort
n = length(x);
[x,y]= quicksorti(x, y,1,n,kk);

end

function [x, y]= quicksorti(x, y, ll,uu,kk)
% Sort x(ll:uu) via quick sort 
% Note: In practice, x xhould be passed by reference

% Select pivot and partition data around it
[x, y, mm] = partition(x, y, ll,uu);

% Divide-and-conquer
if ((mm - ll) <= kk)
    % Sort x(ll:(mm - 1)) via insertion sort 
    [x, y] = insertionsorti(x, y, ll, mm - 1);
else
    % Sort x(ll:(mm - 1)) via quick sort 
    [x, y] = quicksorti(x, y, ll,mm - 1,kk);
end
if ((uu - mm) <= kk)
    % Sort x((mm + 1):uu) via insertion sort 
    [x, y]= insertionsorti(x, y, mm + 1,uu);
else
    % Sort x((mm + 1):uu) via quick sort 
    [x, y] = quicksorti(x, y, mm + 1,uu,kk);
end

end

function [x, y, mm] = partition(x, y, ll,uu)
% Partition x(ll:uu) around index mm
% Note: In practice, x xhould be passed by reference

%--------------------------------------------------------------------------
% Select pivot
%--------------------------------------------------------------------------
% Method 1: Median-of-3 pivot
pp = medianofthree(y, ll,uu); % Median-of-three pivot index

% Method 2: Random pivot
%pp = randi([ll uu]); % Random pivot index
%--------------------------------------------------------------------------

% Partition around pivot
[x, y]= swap(x, y, ll,pp);
mm = ll;
for j = (ll + 1):uu
    if (y(j) > y(ll))
        mm = mm + 1;
        [x,y ]= swap(x, y, mm,j);
    end
end
[x, y]= swap(x, y ,ll,mm);

end

function pp = medianofthree(y,ll,uu)
% Compute median of {x(ll),x(mm),x(uu)}
% Note: In practice, x xhould be passed by reference

% Middle element (avoiding overflow)
mm = ll + floor((uu - ll) / 2);

% Compute median of {x(ll),x(mm),x(uu)}
if (y(ll) <= y(mm))
    if (y(uu) <= y(mm))
        pp = mm;
    elseif (y(uu) <= y(ll))
        pp = uu;
    else
        pp = ll;
    end
else
    if (y(uu) <= y(ll))
        pp = ll;
    elseif (y(uu) <= y(mm))
        pp = uu;
    else
        pp = mm;
    end
end

end

function [x, y]= insertionsorti(x, y, ll,uu)
% Sort x(ll:uu) via insertion sort 
% Note: In practice, x xhould be passed by reference

% Insertion sort
for j = (ll + 1):uu
    pivot = y(j);
    pivot2 = x(j);
    i = j;
    while ((i > ll) && (y(i - 1) < pivot))
        x(i) = x(i - 1);
        y(i) = y(i - 1);
        i = i - 1;
    end
    y(i) = pivot;
    x(i) = pivot2;
end

end

function [x, y] = swap(x, y, i,j)
% Swap x(i) and x(j)
% Note: In practice, x xhould be passed by reference

val = x(i);
x(i) = x(j);
x(j) = val;

val = y(i);
y(i) = y(j);
y(j) = val;
end
