function pickupPointsManually(fileIn,fileOut)
% This code is to manually pick up clipped parts of a seismic waveform.
%
% fileIn : file name of the clipped  waveform as  input
% fileOut: file name of the restored waveform for output
%
% Function:
% Please click the button at the position you hope to flag, and the program 
% would show the position into Matlab's Command Window. 
% The odd index should be the beginning and the even index should be the
% ending of the clipped segment. Please pick up the begining and the ending 
% of each segment from left to right in sequence. Please scroll to the next 
% window to continue the pickup until you had marked all segments. 
% Finally, please save these groups of % positions into the file "flagZ.txt", 
% which would be processed by "segFlag" to generate flags for each sample.
%
% Input:  1). "*.SAC",the file of clipped seismic waveform.  
%
% Output: 1). 'MAJO10Z.txt', which only contains the pure data.
%         2). 'flagZ.txt', which saves the begining and the ending of each
%             segment.
%
% Last modified by Jinhai Zhang, Dec 26, 2016
%
% This code can be used for noncommercial purposes only. For commercial use, please contact Prof. Jinhai Zhang, zjh@mail.iggcas.ac.cn
%
% Please cite this code in terms of the related technical papers:
%
% Zhang, J. H. et al., 2016, Restoration of clipped seismic waveforms using projection onto convex sets method, Scientific Reports,6:39056, doi: 10.1038/srep39056
% Wang, S. Q. & Zhang, J. H. Fast image inpainting using exponential-threshold POCS plus conjugate gradient. Imaging. Sci. J. 62, 161¨C170 (2014).
%
% By using this software, you are agreeing to the terms detailed below.

% BEGIN TERMS OF USE LICENSE
%
% This SOFTWARE is maintained by the Seismology Group at the Institute
% of Geology and Geophysics, Chinese Academy of Sciences, Beijing,
% China.  The copyright and ownership is held by its 'AUTHOR'. 
% Please contact us via email at: zjh@mail.iggcas.ac.cn
%
% The term 'SOFTWARE' refers to the Matlab source code, translations to
% any other computer language, or object code
%
% Terms of use of this SOFTWARE
%
% 1) This SOFTWARE may be used by any individual or corporation for noncommercial purposes
%    with the exception of re-selling or re-distributing the SOFTWARE.
%
% 2) The AUTHORS should be acknowledged in any resulting publications or
%    presentations
%
% 3) This SOFTWARE is provided "as is" with no warranty of any kind
%    either expressed or implied. We make no warranties or representation
%    as to its accuracy, completeness, or fitness for any purpose. We
%    are under no obligation to provide support of any kind for this SOFTWARE.
%
% 4) New versions will be made available after leaving your email to zjh@mail.iggcas.ac.cn
%
% 5) Use this SOFTWARE at your own risk.
%
% END TERMS OF USE LICENSE

[seis,head]=readsac(fileIn,0,'l');%input the SAC file
it=1:size(seis,1);

fid = fopen('MAJO10Z.txt','wt');%open a new file to save the pure data
for ii=1:min(50000,size(seis,1)) %The maximum number of samples is 50,000.
    fprintf(fid,'%f \n',seis(ii));%write the data
end
fclose(fid);

figure;
plot(it,seis,'r.-');hold on;%plot the pure data
set(gcf,'WindowButtonDownFcn',@butttonDownFcn);%pick up manually. 

if isempty(get(0,'children'))
    return
end

