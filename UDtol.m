function S=UDtol(nom,tol1,tol2)
% UDTOL Uniform distrubition specified as mean and tolerance
%   S = UDTOL(nom,tol)
%   S = UDTOL(nom,tol1,tol2)
%
%   See also: MC, UDDELTA, UDRANGE

narginchk(2,3);

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
    case 2
        % tol1 specifies +/- tolerance
        v = nom*[1-tol1;1+tol1];
    case 3
        % tol1 and tol2 both specify tolerance (usu. one + and one -)
        v = nom*[1+tol1;1+tol2];
end

S = struct('TYPE','UD','MIN',v(1),'MAX',v(2));
