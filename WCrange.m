function v=WCrange(val1,val2)
% WCRANGE Worst-case distribution specfied as min and max values
%   v = WCRANGE(min,max)
%
%   See also: WC, MC, WCDELTA, WCTOL

narginchk(1,2);

if ~isscalar(val1)
    error('values must be scalar')
end

if nargin>=2 && ~isscalar(val2)
    error('values must be scalar')
end

switch nargin
    case 1
        % output is just the scalar 'nom'
        v=val1;
    case 2
        % tol1 specifies +/- tolerance
        v = [val1;val2];
end

