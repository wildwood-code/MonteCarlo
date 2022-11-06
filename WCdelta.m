function v=WCdelta(nom,del1,del2)
% WCDELTA Worst-case distribution specfied as nominal and delta
%   v = WCDELTA(nom,del)
%   v = WCDELTA(nom,del1,del2)
%
%   See also: WC, MC, WCRANGE, WCTOL

narginchk(1,3);

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
    case 1
        % output is just the scalar 'nom'
        v=nom;
    case 2
        % delta is +/- delta
        v = [nom-del1;nom+del1];
    case 3
        % del1 and del2 both specify deltas (usu. one + and one -)
        v = [nom+del1;nom+del2];
end

