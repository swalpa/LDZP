function [ Pattern ] = ZigZag( I2, mapping, MODE)
%   LZP returns the local ZigZag pattern histogram of an image depending on what mapping is used.
%   The original getmapping code of LBP is used and updated to the LZP by Swalpa Kumar Roy, CVPR Unit, ISI Kolkata.
%   This code can be used only for the academic and research purposes and can not be used for any commercial purposes.
%   Cite the paper 'S.K. Roy, B. Chanda, B.B. Chaudhuri, S. Banerjee, D.K. Ghosh, and S.R. Dubey, 
%   "Local Directional ZigZag Pattern: A Rotation Invariant Descriptor for Texture Classification," 
%   Pattern Recognition Letters, Elsevier, vol. 108, issue no. 1, pp. 23-30, 2018',
%   In case you are using this code.

%   Possible values for MODE are
%       'h' or 'hist'  to get a histogram of LZP codes
%       'nh'           to get a normalized histogram

 Examples
%  --------
%       I=imread('rice.png');
%       mapping=getmapping(8,'u2'); 
%       H1=ZigZag(I,mapping,'h'); %LZP histogram in (8,1) neighborhood
%                                  %using uniform patterns
%       subplot(2,1,1),stem(H1);


m=size(I2,1);
n=size(I2,2);
for i=2:m-1
    for j=2:n-1
        J0=I2(i,j);
        I3(i-1,j-1)=I2(i-1,j-1)>J0;
        I3(i-1,j)=I2(i-1,j)>J0;
        I3(i-1,j+1)=I2(i-1,j+1)>J0; 
        I3(i,j+1)=I2(i,j+1)>J0;
        I3(i+1,j+1)=I2(i+1,j+1)>J0; 
        I3(i+1,j)=I2(i+1,j)>J0; 
        I3(i+1,j-1)=I2(i+1,j-1)>J0; 
        I3(i,j-1)=I2(i,j-1)>J0;
        %% Rotational order 1
        result(i,j) = I3(i-1,j-1)*2^0 + I3(i-1,j)*2^1 + I3(i,j-1)*2^2 + I3(i+1,j-1)*2^3 + I3(i-1,j+1)*2^4 + I3(i,j+1)*2^5 + I3(i+1,j)*2^6 + I3(i+1,j+1)*2^7;
        %% Rotational order 2
%         result(i,j) = I3(i-1,j-1)*2^3 + I3(i-1,j)*2^2 + I3(i,j-1)*2^6 + I3(i+1,j-1)*2^7 + I3(i-1,j+1)*2^0 + I3(i,j+1)*2^1 + I3(i+1,j)*2^5 + I3(i+1,j+1)*2^4;
        %% Rotational order 3
%         result(i,j) = I3(i-1,j-1)*2^7 + I3(i-1,j)*2^6 + I3(i,j-1)*2^5 + I3(i+1,j-1)*2^4 + I3(i-1,j+1)*2^3 + I3(i,j+1)*2^2 + I3(i+1,j)*2^1 + I3(i+1,j+1)*2^0;
        %% Rotational order 4
%         result(i,j) = I3(i-1,j-1)*2^4 + I3(i-1,j)*2^5 + I3(i,j-1)*2^1 + I3(i+1,j-1)*2^0 + I3(i-1,j+1)*2^7 + I3(i,j+1)*2^6 + I3(i+1,j)*2^2 + I3(i+1,j+1)*2^3;
    end
end

%Apply mapping if it is defined
if isstruct(mapping)
    bins = mapping.num;
    for i = 1:size(result,1)
        for j = 1:size(result,2)
            result(i,j) = mapping.table(result(i,j)+1);
        end
    end
end

%Pattern = hist(result(:),0:(bins-1));
%Pattern = Pattern/sum(Pattern);
if (strcmp(mode,'h') || strcmp(mode,'hist') || strcmp(mode,'nh'))
    % Return with LBP histogram if mode equals 'hist'.
    Pattern=hist(result(:),0:(bins-1));
    if (strcmp(mode,'nh'))
        Pattern=Pattern/sum(Pattern);
    end
end
