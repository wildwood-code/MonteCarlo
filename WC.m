function [soln,args,stats]=WC(fun,varargin)
% WC Worst-case "corners" analysis function
%   [soln,args,stats] = WC(fun,varargin)
%
%   Evaluates the function 'fun' at every combination of the input
%   variables passed as arguments following 'fun'.
%
%   If there are N input variables provided, then 'fun' must be a function
%   taking N scalar inputs. 'fun' must return a scalar output.
%
%   Each provided input variable may be a scalar (only that one value is
%   evaluated), or it may be a vector (combinations will include each value
%   in the vector). Often, the vector will include a min and a max value of
%   a particular variable.
%   The input may also be a Monte Carlo structure such as NDtol or UDrange.
%
%   Outputs:
%     soln is a row vector of the solution at each combination if inputs
%     args is a matrix of arguments. each row represents an argument
%     (row1=arg1, row2=arg2, etc), and each column corresponds to the
%     column in soln
%     stats is a struct of different statistics for the solution:
%       min, max, median, mean, mode, std, spread and the indicies and args
%       for min, max, median, and mode
%
%   % Example:
%   % 'foo' is an anonymous function taking 3 inputs:
%   foo = @(x,y,z) x.*y+2*x-0.5*x.*z+0.45*z;
%   [val,arg]=WC(foo,[1.5 2.5],[-1 0 1],4.0);
%   % foo is evaluated 6 times (2x3x1)
%   max(val)  % == 4.3
%   min(val)  % == -0.7
%   [~,i]=max(val) % i == 6
%   arg(:,i) & == [2.5 ; 1.0 ; 4.0]
%   % this is the combination of args producing the maximum value of foo

% Kerry S. Martin, martin@wild-wood.net

narginchk(2,inf);

nargf = length(varargin);
va = varargin;

% preprocess the list to make sure each element is a row vector
% change column vectors to row vectors
if nargf>0
    for i=1:nargf
        if isstruct(va{i})
            va{i} = MonteCarlo.MCrand(va{i}, true);
        elseif isvector(va{i})
            if iscolumn(va{i})
                % transpose to make row vector
                va{i} = va{i}';
            end
        else
            error('WCdist argument #%u is invalid', i);
        end
    end
else
    error('WCdist must have at least one parameter to vary')
end

% preallocate the solutions vector
args = combvec(va{:});
nsol = size(args,2);
soln = zeros(1,nsol);

for i=1:nsol
    arg = num2cell(args(:,i));
    soln(i) = fun(arg{:});
end

is_args = true;

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