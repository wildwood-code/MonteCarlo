function S=NDrange(vmin,vmax)
% NDRANGE Normal distrubition specified as range between min and max
%   S = NDRANGE(min,max)
%
%   See also: MC, NDDELTA, NDTOL

narginchk(2,2);

if ~isscalar(vmin)
    error('''vmin'' must be a scalar')
end

if ~isscalar(vmax)
    error('''vmax'' value must be scalars')
end

if vmax<=vmin
    error('''vmax'' must be greater than ''vmin''')
end

mean = 0.5*(vmax+vmin);
delta = vmax-mean;

S = struct('TYPE','ND','MEAN',mean,'SIGMA',delta/3.0);

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net