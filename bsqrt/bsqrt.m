function [y,it] = bsqrt(x,Ea)
%bsqrt calculates the square root of x using the Bakhshali Method.
%   The Bakhshali Method converges quartically, meaning high precision
%   results can be found quickly.
%
%   Inputs:
%   x  - Radicand
%   Ea - Optional. Approximate relative error, in percent. Default (with no
%        input) is 0.000001%
%
%   Outputs:
%   y  - Result
%   it - Number of iterations of the Bakhshali Method performed

%% Input check
if sign(x)<0
    error('Result would be imaginary, try using sqrt instead.')
elseif x==0
    y=0;
    it=0;
    return
end

if nargin==1
    Ea=0.000001; %Set end error condition, in percent, if not provided
end

%% Init
guess = x/2; %Initial guess will be half of x, which is generally close for smaller numbers
Ec=100;
it=0;

%% Main Loop
while Ec>Ea
    estimate=(x-(guess.^2))/(2*guess); %Perform Bakhshali calculation
    estimate=guess+estimate; % Second step of calculation, separated for clarity
    
    Ec=abs((estimate-guess)/estimate)*100; %Approximate error calculation
    guess=estimate; 
    it=it+1; %Count iterations
end
y=estimate;

end

