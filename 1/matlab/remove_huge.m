function [Wh] = remove_huge(Wh)
% REMOVE_HUGE Subtitute huge value with NaN.
%   REMOVE_HUGE(WH) has a hardcoded limit of abs(W) > 10 for W in WH.

for i = 1:length(Wh)
    W = abs(Wh(i, :));
    if any(W > 10)
        Wh(i, :) = [NaN NaN];
    end
end

end

