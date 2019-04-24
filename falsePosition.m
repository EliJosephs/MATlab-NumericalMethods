function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
%falsePosition Calculates the root of a function given two brackets.
%   Inputs:
%   Function (Use a function handle)
%   Lower bracket
%   Upper bracket
%   Desired % relative error
%   Max number of iterations
%
%   Outputs: 
%   root
%   Function value at root
%   Approximate % relative error
%   Number of iterations

%% Error checking and initial parameters
if nargin>5
    error('Cannot have more than 5 inputs.')
elseif nargin<3
    error('Requires at least 3 inputs. Function, Lower Bound, and Upper Bound.')
elseif nargin==3
    maxiter=200;
    es=0.0001;
elseif nargin==4
    maxiter=200;
end

if sign(func(xl))==sign(func(xu)) %If signs of brackets evaluated in the function are equal, method will fail
    error('Root not properly bracketed  ): Try again')
end

%% False position calculation
for i=[1:maxiter] %Run to max iterations (or until break is reached inside)
    if i==1 %Only runs on first iteration
        previous=xl; %Sets "previous" to the lower bracket to start
    else
        previous=current; %Sets the previous estimate to the one we just found, before the next is calculated
    end
    
    root=xl-(((xu-xl)*func(xl))/(func(xu)-func(xl))); % False position formula
    
    if sign(func(root))==0 %If the root is hit directly, func(x) = 0
        current=root;
        ea=0;
        break
    elseif sign(func(xl))==sign(func(root)) % Replace lower if signs match
        xl=root; % Replace lower bracket
    else
        xu=root; %Otherwise, replace upper
    end
    
    current=root; %Not really needed, but makes the error term below clearer
    
    ea=abs((current-previous)/current)*100; %Calculate approximate relative percent error for output
    
    if (abs((current-previous)/current)*100) <= es 
        % ^ Stopping criteria, using approximate relative percent error
        break % If the error is below the criteria or =, end the loop
    end
end

fx=func(root);
iter=i;

end

