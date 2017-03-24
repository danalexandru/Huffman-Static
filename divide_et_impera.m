function [A] = divide_et_impera(y, A, start, finish, i)
    
    N = length(y);
    iLeft = 1;
    iRight = 1;

    sl = y(1);
    sr = y(N);

    while (iLeft + iRight ~= N)

       if (sl < sr)
           iLeft = iLeft + 1;
           sl = sl + y(iLeft);
       else
           iRight = iRight + 1;
           sr = sr + y(N - iRight + 1);
       end

    end
 
    A(i, start : start + iLeft - 1) = 0;
    A(i, start + iLeft : finish) = 1;


end
