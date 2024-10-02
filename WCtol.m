function v=WCtol(nom,tol1,tol2)
% WCTOL Worst-case distribution specfied as nominal and tolerance
%   v = WCTOL(nom,tol)
%   v = WCTOL(nom,tol1,tol2)
%
%   See also: WC, MC, WCRANGE, WCDELTA

narginchk(1,3);

if ~isscalar(nom)
    error('''nom'' must be a scalar')
end

if nargin>=2 && ~isscalar(tol1)
    error('tolerance values must be scalars')
end
if nargin>=3 && ~isscalar(tol2)
    error('tolerance values must be scalars')
end

switch nargin
    case 1
        % output is just the scalar 'nom'
        v=nom;
    case 2
        % tol1 specifies +/- tolerance
        v = nom*[1-tol1;1+tol1];
    case 3
        % tol1 and tol2 both specify tolerance (usu. one + and one -)
        v = nom*[1+tol1;1+tol2];
end

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net