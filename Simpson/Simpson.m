function I = Simpson(x,y)
%Simpson applies the Simpson's 1/3 Rule to integrate y over x. 
% Inputs:
% x:     x must be an equally spaced array, covering the interval of integration
% y:     y must be an array containing function values corresponding to x
%
% Outputs:
% I:     Resulting estimate of the integral
%
% Notes and Warnings:
%
% Simpson evaluates the integral using Simpson's 1/3 Rule for intervals of
% x which contain an even number of bins. That is, the number of elements
% in x is odd. 
%
% If the number of bins is odd (number of elements in x is even), then the
% last bin will be calculated using a single iteration of the trapezoidal
% rule. This will increase the resulting error. A warning will be displayed
% in the command console. 
%
% The x vector is checked for linearity to 13 decimal points, so Simpson
% may erroneously accept a non-linearly spaced x vector, if the difference 
% between consecutive distances between elements differs by less than 
% 0.0000000000001. This accounts for subtractive cancellation errors, and
% spacing generated by linspace() which may be accurate to 14 decimal
% places, with the 15th place holding error. This truncation in linearity
% checking may affect the result of Simpson, with larger errors occurring
% for larger resulting integrals. It is recommended to generate x using
% linspace(), or ensure that tabulated data is spaced correctly. 

%% Initial Checks and Setup
if nargin < 2
    error('At least two inputs are required.')
elseif nargin > 2
    error('Only two arguments are accepted.')
end

%Check array lengths
if length(x) ~= length(y)
    error('Input vectors must be the same length.')
end

%Check x array spacing
for i=1:length(x)-2
    %Round to 13 decimals when checking. Prevents subtractive cancellation
    %errors in the last few digits.  
    if round(x(i+1)-x(i),13) ~= round(x(i+2)-x(i+1),13) 
        error('"x" array must be linearly spaced.')
    end
end

h=x(2)-x(1); %Only runs if linearly spaced, sets step size

%% Trapezoidal Rule 
if rem(length(x),2) == 0 %If odd number of bins (even number in x)
    warning('Last section of the interval will be evaluated using a single iteration of the trapezoidal rule.')
    trapValX=[x(length(x)-1) x(length(x))];
    trapValY=[y(length(x)-1) y(length(x))]; %Array for trapezoidal
    x=x(1:length(x)-1);
    y=y(1:length(y)-1); %Modified array for 1/3
    
    %Evaluate using the trapezoidal rule right away
    IT=(trapValX(2)-trapValX(1))*((trapValY(1)+trapValY(2))/2);
else 
    IT=0; %If we don't use it, the "resulting integral" is 0
end

%% Simpson's 1/3 Calculations
if rem(length(x)-1,2) == 0 %If length-1 divisible by 2
    numIt=(length(x)-1)/2;
    tmp=1; %tmp is used to construct the alternate series of terms
else
    numIt=((length(x))/2)-1;
    tmp=0;
end

fourTerms=zeros(1,length(x)); %Initialize vectors. Saves time in loop
twoTerms=zeros(1,length(y));

for i=1:numIt %Run loop pulling from y to generate the two sets of terms
    %Terms to be summed and multiplied by 4
    fourTerms(i)=y(i*2);
    
    %Terms to be summed and multiplied by 2
    if tmp==1 && numIt~=i
        twoTerms(i)=y((i*2) +1);
    elseif tmp==0 && numIt~=1
        twoTerms(i)=y((i*2) +1);
    end
end

%Calculate the integral according to Simpson's 1/3 rule
IS=(h/3) .* (  y(1) + y(end) + (4.*sum(fourTerms)) + (2.*sum(twoTerms))  );

%% Output
I=IS+IT; %Add integrals, IT is 0 if trap rule not used

end