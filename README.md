# MATLAB Numerical Methods
All files in this repository are MATLAB functions. To use them, they must be in the current MATLAB working directory. Once there, thery may be called by other files or through the command window. 

All functions are original and written to meet certain criteria. MATLAB has built-in functions for each of the files in this reposistory, which are optimized and will run faster. However, the functions provided here, allow for a deeper understranding of these numerical methods, and as a framework for potential future algorithms. 

The details of every function are given at the beginning of each .m file, as well as their respective README file. This information will also return in the MATlab command window when prompted by:

help "function_name"
  
In the same working directory. 
  
Each function also contains comments, for better understanding. 

# Current Algorithms

1. LU Decomposition/Factorization
2. False Position Rootfinding
3. Simpson's 1/3 Rule Integration
4. Bakhshali Method Square Root

## LU Decomposition/Factorization

LU Decomposition takes a square matrix A and decomposes (or factorizes) it into lower triangular matrix L and upper triangular  matrix U. 

## False Position Rootfinding

Calculates the root of a function given two brackets. Slightly faster than bisection. Will **ALWAYS** converge on a root if the input is correct. 

## Simpson's 1/3 Rule Integration

Simpson applies the Simpson's 1/3 Rule to integrate y over x. x and y must both be equal length arrays.

**Notes and Warnings (Also included inside Simpson):**

 Simpson evaluates the integral using Simpson's 1/3 Rule for intervals of
 x which contain an even number of bins. That is, the number of elements
 in x is odd. 

 If the number of bins is odd (number of elements in x is even), then the
 last bin will be calculated using a single iteration of the trapezoidal
 rule. This will increase the resulting error. A warning will be displayed
 in the command console. 

 The x vector is checked for linearity to 13 decimal points, so Simpson
 may erroneously accept a non-linearly spaced x vector, if the difference 
 between consecutive distances between elements differs by less than 
 0.0000000000001. This accounts for subtractive cancellation errors, and
 spacing generated by linspace() which may be accurate to 14 decimal
 places, with the 15th place holding error. This truncation in linearity
 checking may affect the result of Simpson, with larger errors occurring
 for larger resulting integrals. It is recommended to generate x using
 linspace(), or ensure that tabulated data is spaced correctly. 
 
 ## Bakhshali Method Square Root
 
 Calculates the square root of a number using the Bakhshali Method, which converges extremely fast. 
