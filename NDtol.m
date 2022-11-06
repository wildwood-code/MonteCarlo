function S=NDtol(mean,tol)
% NDTOL Normal distrubition specified as mean and tolerance
%   S = NDTOL(mean,tol)
%
%   tol is specified as a percentage of the mean (0.10 = 10%)
%
%   See also: MC, NDDELTA, NDRANGE

narginchk(2,2);

if ~isscalar(mean)
    error('''mean'' must be a scalar')
elseif mean==0
    error('''mean'' cannot be 0 when using NDtol')
end

if ~isscalar(tol)
    error('''tol'' value must be scalars')
elseif tol<=0
    error('''tol'' must be positive')
end

S = struct('TYPE','ND','MEAN',mean,'SIGMA',tol*mean/3.0);
