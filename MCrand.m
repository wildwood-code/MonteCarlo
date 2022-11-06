function v=MCrand(S,wc)
% MCRAND Evaluate Monte-Carlo specification S
%   v = MCRAND(S)
%   v = MCRAND(S, true)
%
%   The behavior depends upon the form of 'S':
%     S==scalar -> scalar value
%     S==vector -> one of the values with equal probability
%     S==struct TYPE=='UD'  -> uniform distribution between the two values
%     S==struct TYPE=='ND'  -> normal distribution with mean and sd
%     S==struct TYPE=='UDI' -> uniform integer distribution between two values
%
%   With the optional form MCRAND(S, true), the return value is a 1x2
%   vector of the worst-case (min and max) values for the distribution.
%
%   See also: MC

narginchk(1,2)

if nargin<2
    wc = false;
end

if isscalar(S) && isnumeric(S)
    % the output is the scalar, with no randomness
    v = S;
elseif isvector(S) && isnumeric(S)
    % pick one of the values in the vector randomly, with uniform
    % distribution of each value
    n = length(S);
    v = S(randi(n));
elseif isstruct(S)
    if isfield(S,'TYPE')
        switch S.TYPE
            case 'UD'
                if wc
                    v = [S.MIN S.MAX];
                else
                    v = rand(1)*(S.MAX-S.MIN)+S.MIN;
                end
            case 'UDI'
                if wc
                    v = [S.MIN S.MAX];
                else
                    n = S.MAX-S.MIN+1;
                    v = S.MIN + randi(S.MAX-S.MIN+1)-1;
                end
            case 'ND'
                if wc
                    % for normal distributions, consider "worst-case"
                    % to be +/- 3 standard deviations from mean
                    v = [S.MEAN-3*S.SIGMA S.MEAN+3*S.SIGMA];
                else
                    v = S.MEAN + S.SIGMA*randn(1);
                end
            otherwise
                error('invalid argument')
        end
    else
        error('invalid argument')
    end
else
    error('invalid argument')
end