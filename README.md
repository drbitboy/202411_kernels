## Tag:  Initial_Brian_Fix

Minimal first pass changes to make the script (rotate_sc2sclit.py) work

* geometries/
  * asperaMetaKernel.tm
    * Removed asp_v000.tf from KERNELS_TO_LOAD, as it appears to be an older FK
    * Changed naif0012.tls to NAIF0012.TLS
    * Changed /begintext to (backslash)begintext
  * asp_v000.tf
    * Move to zzUnused/ subdirectory
  * Added several symlinks (ck, fk, ..., spk, brian, kernels)
    * All pointing at "." to make MK work without creating directory tree
    * All kernels are in flat direcotry /geometries/
* rotate_sc2slit.py
  * Time problem
    * Changed UTC of lookup by 1 minute
      * S/C C-Kernel starts at 00:00:00.815, not 00:00:00.000, on 2025-06-01
  * Kernel problems
    * Fixed path of NAIF0012.TLS (was naif0012.tls)
    * Added code to download de430.bsp from NAIF if needed (too big for Github repo)
    * Added code to download hst_edited.bsp from NAIF if needed (not provided in original .ZIP)
* .gitignore
  * Ignore de430.bsp and hst_edited.bsp, which are not in repo but are downloaded from NAIF
* README.md
  * Updated this file

 
## Tag:  Initial_Ellie

Initial delivery of files from Ellie ...

Sources:

* rotate_sc2slit.py - via email
* metakernel_contents.zip
  * MD5 checksum: 45483bd65eeb569ce6a2f2282f2bf29e
  * Contents placed in sub-directory /geometries/
    * Excluding de430.bsp (too large for Github)
      * MD5 checksum:  91e21181f6a96edbfeb1ff5a419ce095
      * Available via https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/de430.bsp
