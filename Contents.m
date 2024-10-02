% Monte Carlo and Worst-Case simulation library
%
% Perform Monte Carlo analysis
%   [soln,args]=MC(runs,fun,dist1,dist2...,distn)
%
% Perform worst-case/corners analysis
%   [soln,args]=WC(fun,wc1,wc2...,wcn)
%
% Monte Carlo distribution specs
%   dist=NDtol(mean,tol)       normal distribution (+/- 3 sigma tol)
%   dist=NDrange(min,max)      normal distribution (+/- 3 sigma range)
%   dist=NDdelta(mean,delta)   normal distribution (+/- 3 sigma delta)
%   dist=NDsigma(mean,sigma)   normal distribution
%   dist=UDtol(nom,tol)        uniform distribution
%   dist=UDrange(min,max)      uniform distribution
%   dist=UDdelta(nom,delta)    uniform distribution
%   dist may also be a scalar, vector, or WC spec
%
% Worst-case specs
%   wc=WCtol(nom,tol)          worst-case nom*(1+/-tol)
%   wc=WCrange(min,max)        worst-case extreme values
%   wc=WCdelta(nom,delta)      worst-case non+/-delta
%   wc may also be a scalar or vector (may use linspace for vector)
%

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net