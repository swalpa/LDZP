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


clc
clear all
close all

dn = '/home/swalpa/Downloads/LBP/Brodatz32/Data/'
 
 db=dir(strcat(dn,'*.xv'));
 k=1;
 
 feature=[];
 
 lbpfeature = [];
 
 % Radius and Neighborhood
 R=1;
 P=8;
 
 % LBP needed a mapping function
 mapping=getmapping(P,'u2'); 
 
 tic
 for(i=1:1:length(db))

%  for(i=1:1:1)
     fname=db(i).name;
     fname=strcat(dn,fname);
     im = load_xv_img(fname);
     %im=imread(fname);
     
%    im = single(im);
%      
%    im = awgn(im, 100);    % d is the noise density by default 0.05 (5%)
    
     img = uint8(im);

     
     %Gray = im2double(im);    
     %Gray = (Gray-mean(Gray(:)))/std(Gray(:))*20+128;  % image normalization, to remove global intensity 

     [Out edge] = kirschEdge(img);
     
     
     LBP_H1 = ZigZag(edge(:,:,1), mapping);
     LBP_H2 = ZigZag(edge(:,:,2), mapping);
     LBP_H3 = ZigZag(edge(:,:,3), mapping);
     LBP_H4 = ZigZag(edge(:,:,4), mapping);
     LBP_H5 = ZigZag(edge(:,:,5), mapping);
     LBP_H6 = ZigZag(edge(:,:,6), mapping);
     
     LBP_H = [LBP_H1 LBP_H2 LBP_H3 LBP_H4 LBP_H5 LBP_H6];
     
     feature = [feature;LBP_H];
     
     k=k+1   
 end;
 toc
 k-1
save('ZigZag_Brodatz','feature');
% xlswrite('ZigZagDTC10_G100.xlsx',feature);

