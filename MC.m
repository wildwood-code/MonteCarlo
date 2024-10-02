function [soln,args,stats]=MC(runs,fun,varargin)
% MC Monte-Carlo analysis of a function of multiple random variables
%   [soln,args]=MC(runs,fun,varargin)
%
%   The function 'fun' will be called 'runs' number of times, each time
%   with a different value for each variable passed to 'fun'. The
%   specifiaction for the random variables are passed as arguments
%   following function handle 'fun'
%
%   Outputs:
%     soln is a row vector of the solution at each run
%     args is a matrix of arguments. each row represents an argument
%     (row1=arg1, row2=arg2, etc), and each column corresponds to the
%     column in soln
%     stats is a struct of different statistics for the solution:
%       min, max, median, mean, mode, std, spread and the indicies and args
%       for min, max, median, and mode
%
%   % Example:
%   foo = @(x,y,z) x.*y+2*x-0.5*x.*z+0.45*z;
%   [soln,args] = MC(100, foo, UDtol(13.5,0.1), 12.3, [4, -4]);
%   % evaluates 'foo' 100 times with the first argument varied randombly
%   % with uniform distribuiton from 13.5-1.35 to 13.5+1.35, the second
%   % argument taking the value of 12.3, and the third argument taking the
%   % values of -4 or +4 with equal probability of either value
%   % the worst-case values can be found using min(soln) and max(soln)
%   % the indices of the worst-case values can be found using
%   % [~,imin]=min(soln)   [~,imax]=max(soln)
%   % the arguments for those worst-case values can be found using
%   % args(:,imin)   args(:,imax)

% Kerry S. Martin, martin@wild-wood.net

narginchk(3,inf);

if nargout<2
    is_args = false;
else
    is_args = true;
end

if runs<=0
    error('''runs'' must be an integer greater than zero')
end

if ~isa(fun,'function_handle')
    error('''fun'' must be a function handle')
end

nargf = length(varargin);
soln = zeros(1,runs);
args = zeros(nargf,runs);
arg = cell(nargf,1);

for i=1:runs
    
    % generate the arguments
    for j=1:nargf
        arg{j} = MonteCarlo.MCrand(varargin{j});
    end
    
    % execute the function with the arguments
    soln(i) = fun(arg{:});
    
    % store the args if needed
    if is_args
        args(:,i) = cell2mat(arg);
    end
    
end

if nargout>=3
    % generate statistics
    stats = struct();
    [mn,imn] = min(soln);
    [mx,imx] = max(soln);
    stats.min = mn;
    stats.min_idx = imn;
    if is_args
        stats.min_args = args(:,imn);
    end
    stats.max = mx;
    stats.max_idx = imx;
    if is_args
        stats.max_args = args(:,imx);
    end
    if isreal(soln)
        stats.median = median(soln);
        stats.median_idx = find(soln-stats.median, 1);
        if is_args
            stats.median_args = args(:,stats.median_idx);
        end
        stats.mode = mode(soln);
        stats.mode_idx = find(soln-stats.mode, 1);
        if is_args
            stats.mode_args = args(:,stats.mode_idx);
        end
        stats.mean = mean(soln);
        stats.std = std(soln);
        stats.spread = stats.max - stats.min;
    end
end

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net