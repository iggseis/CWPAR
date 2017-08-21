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

clear all;

%User should only change these two file names to switch to a new task
fileIn ='2011.074.13.27.10.0195.IU.MAJO.10.BHZ.M.SAC';%file name of the clipped waveform
fileOut='2011.074.13.27.10.0195.IU.MAJO.10.BHZ.M-Restore.SAC';%file name of the restored waveform for output
% route=1;%if route=1, we go to "Pick up clipped parts of a seismic waveform manually"
% route=2;%if route=2, we go to "Restore the clipped waveform using the POCS method"
route=1;

if route==1 
    % Pick up clipped parts of a seismic waveform manually
    pickupPointsManually(fileIn,fileOut);
end

if route==2 
    % Verify that the numbers in Command Window had been saved into "flagZ.txt"
    ButtonName=questdlg('Did you save the numbers in Command Window into "flagZ.txt"£¿','Choose:','Yes','No','Yes');
    while strcmp(ButtonName,'No')
        ButtonName=questdlg('Did you save the numbers in Command Window into "flagZ.txt"£¿','Choose:','Yes','No','Yes');
    end

    % Generate the flag for each sample using the manually
    segFlag();

    % Restore the clipped waveform using the POCS method
    waveformRecoveryFlag(fileIn,fileOut);
end