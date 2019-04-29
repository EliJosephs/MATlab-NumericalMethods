function [L,U,P] = luFactor(A)
%luFactor Returns L and U factor matrices and pivot matrix P, given matrix A, 
%   Inputs:
%   A
%
%   Outputs:
%   L
%   U
%   P
%   
%   A is a square matrix populated by numbers. Only one input is allowed.
%   
%   L is the lower triangular matrix of dimensions A
%   U is the upper triangular matrix of dimensions A
%   P is the pivot matrix of dimensions A

%% Inputs
if nargin>1
    error('Only one input allowed, square matrix A.')
elseif nargin < 1
    error('Requires at least one input.')
end

[sizeA,sizeB]=size(A);

if sizeA~=sizeB
    error('Input matrix A must be square.')
end

%% Initiations

L=eye(sizeA); %Init L

P=eye(sizeA); %Init P

U=A; %Init U

%% Master Loop

for col=1:sizeA %Column iterator. We assume square matrix
    row=col; %Moves diagonally across the matrix
        
%% Pivoting
        
        if row+1<=sizeA && row==col %Pivot if true
            
            for pivotRow=1:(sizeA+1)-row %Find the max in the column below

                if pivotRow==1 %Setup on first run
                    pivotLocation=0;
                    currentMax=abs(U(row,col));
                elseif U(row+pivotRow-1,col) > currentMax %Changing if larger max found
                    pivotLocation=pivotRow-1;
                    currentMax=abs(U(row+pivotRow-1,col));
                end
                
            end
           
            rowCopy=U(row+pivotLocation,:); %Performing the pivot
            U(row+pivotLocation,:)=U(row,:);
            U(row,:)=rowCopy; 
            
            rowCopy=P(row+pivotLocation,:); %Recording the pivot for P
            P(row+pivotLocation,:)=P(row,:);
            P(row,:)=rowCopy; 
            
            if col~=1 %Pivot L if it exists yet. No point if it's the first pivot before elimination. 
                
                elCopy=L(row,1:col-1);
                L(row,1:col-1)=L(row+pivotLocation,1:col-1);
                L(row+pivotLocation,1:col-1)=elCopy;
                
            end
        end
        
        
%% Gaussian Elimination
        
        %row 2 - (a21/a11 * row 1)   is the basic formula for cancellation
        
        for elimRow=1:(sizeA)-row %Iterates through all rows to be eliminated
            
            L(elimRow+row,col)=U(elimRow+row,col)/U(row,col); % Constructing L
            U(elimRow+row,col:end)=U(elimRow+row,col:end)-(U(row,col:end).*(U(elimRow+row,col)/U(row,col))); %Constructing U, and eliminating
            
        end
        
end %Master Loop end

end