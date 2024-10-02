function S=NDdelta(mean,del)
% NDDELTA Normal distrubition specified as mean and delta
%   S = NDDELTA(mean,del)
%
%   See also: MC, NDRANGE, NDTOL

narginchk(2,2);

if ~isscalar(mean)
    error('''mean'' must be a scalar')
end

if ~isscalar(del)
    error('''delta'' value must be scalars')
elseif del<=0
    error('''delta'' must be positive')
end

S = struct('TYPE','ND','MEAN',mean,'SIGMA',del/3.0);

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net