CWPAR
======
## What is CWPAR ?
This package is for the **Clipped Waveform Pick-up and Restoration** (**CWPAR**).

It will pick up the clipped seismic waveform and restore the waveform using POCS method.

For more detailed technical information, please refer to:

***Zhang, J. H.** et al., 2016, Restoration of clipped seismic waveforms using projection onto convex sets method, Scientific Reports,6:39056, doi: 10.1038/srep39056*

## Info

`CWPAR.m` is the main program, which calls the other Matlab functions.

This package uses the Matlab scripts developed by Frederik Simons (http://geoweb.princeton.edu/people/simons/software.html) to allow for reading and writing sac files in Matlab -- `readsac.m`, `suf.m`, `defval.m`, `osdep.m`, `nounder.m`

These scripts are dependent on `sac_sun2pc_mat.m` by C. D. Saragiotis and `cprintf.m` by Yair Altman (altmany at gmail dot com).

Users can check Jinhai Zhang' homepage (https://www.researchgate.net/profile/Jin_Hai_Zhang) for the latest version or send a email to zjh@mail.iggcas.ac.cn

Last modified by Jinhai Zhang, Dec 06, 2016, version: 0.1

This code can be used for noncommercial purposes only. For commercial use, please contact Prof. Jinhai Zhang, zjh@mail.iggcas.ac.cn


## Citation

 Please cite this code in terms of the related technical papers:

 + **Zhang, J. H.** et al., 2016, Restoration of clipped seismic waveforms using projection onto convex sets method, Scientific Reports,6:39056, doi: 10.1038/srep39056

 + Wang, S. Q. & **Zhang, J. H.** Fast image inpainting using exponential-threshold POCS plus conjugate gradient. Imaging. Sci. J. 62, 161�C170 (2014).

 **NOTE**: This SOFTWARE may be used by any individual or corporation for any purpose
 with the exception of re-selling or re-distributing the SOFTWARE.
 By using this software, you are agreeing to the terms detailed in this software's
 Matlab source file.


## License
 BEGIN TERMS OF USE LICENSE

 This SOFTWARE is maintained by the Seismology Group at the Institute
 of Geology and Geophysics, Chinese Academy of Sciences, Beijing,
 China.  The copyright and ownership is held by its 'AUTHOR'.
 Please contact us via email at: zjh@mail.iggcas.ac.cn

 The term 'SOFTWARE' refers to the Matlab source code, translations to
 any other computer language, or object code.

 Terms of use of this SOFTWARE

 1) This SOFTWARE may be used by any individual or corporation for any purpose
    with the exception of re-selling or re-distributing the SOFTWARE.

 2) The AUTHORS must be acknowledged in any resulting publications or
    presentations

 3) This SOFTWARE is provided "as is" with no warranty of any kind
    either expressed or implied. We make no warranties or representation
    as to its accuracy, completeness, or fitness for any purpose. We
    are under no obligation to provide support of any kind for this SOFTWARE.

 4) New versions will be made available after leaving your email to zjh@mail.iggcas.ac.cn.

 5) Use this SOFTWARE at your own risk.

 END TERMS OF USE LICENSE
