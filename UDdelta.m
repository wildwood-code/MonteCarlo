function S=UDdelta(nom,del1,del2)
% UDDELTA Uniform distrubition specified as a mean and delta
%   S = UDDELTA(nom,del)
%   S = UDDELTA(nom,del1,del2)
%
%   See also: MC, UDRANGE, UDTOL

narginchk(2,3);

if ~isscalar(nom)
    error('''nom'' must be a scalar')
end

if nargin>=2 && ~isscalar(del1)
    error('delta values must be scalars')
end
if nargin>=3 && ~isscalar(del2)
    error('delta values must be scalars')
end

switch nargin
    case 2
        % tol1 specifies +/- tolerance
        v = [nom-del1;nom+del1];
    case 3
        % tol1 and tol2 both specify tolerance (usu. one + and one -)
        v = [nom+del1;nom+del2];
end

S = struct('TYPE','UD','MIN',v(1),'MAX',v(2));

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net