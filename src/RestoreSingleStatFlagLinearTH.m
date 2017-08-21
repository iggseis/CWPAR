function [endout]=RestoreSingleStatFlagLinearTH(seis,nt,th,flag)
% INPUT:
%
% seis      the samples of the seismogram
% nt        the total number of samples in seis
% th        the threshod in time domain, which is the clipped level
% flag      "0": unclipped, "1": clipped
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

N=100;%the number of samples of Hanning window
for n=1:N
    a(n)=0.5*(1-cos(pi*n/N));%generate a Hanning window, which is used to fatch the waveform data
end
aa=ones(1,nt);%generate a all-pass filter
for n=1:N
    aa(n)=aa(n)*a(1,n);%taper at the left side
    aa(nt-n+1)=aa(nt-n+1)*a(1,n);%taper at the right side
end
b = seis(:,1).*aa(:);%apply the Hanning window to avoid Gibbs' phenominan
c=th(:,1).*aa(:);    %apply the Hanning window to avoid Gibbs' phenominan
fk=fft(c,nt);%forward FFT
fkabs=abs(fk);%
fmax=max(fkabs);%obtain the maximum amplitude of the frequency spectrum
nstep=1000000;%initialize the maximum number of iterations
thresholdMin=0.001;%the error tolerance
alpha=0.001;%linear threshold
threshold=0.999;%the initial threshold, which would be updated during the iteration
for iteration=1:nstep
     if(threshold<thresholdMin)
         break;
     end
     fkEx=fk;%define the array size of fkEx by copying from fk
     fkEx(1:nt)=0;%initialize fkEx as zeros, which means none of the amplitude of the frequency spectrum would be kept
     for row=1:nt
          if (fkabs(row)>=threshold*fmax )
             fkEx(row)=1;%only if the amplitude of the frequency spectrum is bigger than the threshold, it would be kept
        end
     end

     endout=real(ifft(fkEx(:).*fk(:),nt));%apply the mask fkEx to fk in frequency domain; and then, only keep the real parts after return to the time domain by the backward FFT

     for j=1:nt 
          if (flag(j)==1 && ((endout(j)>0 && endout(j)>th(j)) || (endout(j)<0 && endout(j)<th(j))))%at clipped postions, if its amplitude is bigger than the threshold, 
             A0Miss(j)=endout(j);%it would be kept as it is
          else
             A0Miss(j)=c(j);%at clipped postions, if its amplitude is under the threshold it would be forced to be the threhold, see Figure 1b
          end
     end
    fk=fft(A0Miss,nt);%forward FFT
    fkabs=abs(fk);%obtain the absolute values of the frequency spectrum
    
    threshold=threshold-alpha;%update the threshold by a linear scheme, refer to Zhang, J. H. et al., 2016, Restoration of clipped seismic waveforms using projection onto convex sets method, Scientific Reports,6:39056, doi: 10.1038/srep39056
    %For a exponential scheme, please refer to Wang, S. Q. & Zhang, J. H. Fast image inpainting using exponential-threshold POCS plus conjugate gradient. Imaging. Sci. J. 62, 161¨C170 (2014).
    %A linear scheme is prefered since it would be more accurate than the exponential scheme although slower (Wang & Zhang, 2014).
    
    if threshold<thresholdMin 
        break
    end
    fmax=max(fkabs);%obtain the maximum amplitude of the frequency spectrum
end

 for j=1:nt %keep the unclipped samples
      if (flag(j)==1)

      else
         endout(j)=seis(j);%copy the data to "endout", which is the output of this function
      end
 end
