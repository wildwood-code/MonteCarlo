function S=UDrange(val1,val2)
% UDRANGE Uniform distrubition specified as range between min and max
%   S = UDRANGE(min,max)
%
%   See also: MC, UDDELTA, UDTOL

narginchk(2,2);

if ~isscalar(val1) || ~isscalar(val2)
    error('values must be scalar')
end

S = struct('TYPE','UD','MIN',val1,'MAX',val2);