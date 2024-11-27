KPL/FK


Aspera (ASPERA) Frames Kernel
=====================================================================

   This frame kernel contains the complete set of frame definitions for
   the Aspera spacecraft, its structures and science instruments.
   This frame kernel also contains name - to - NAIF ID mappings for
   Aspera science instruments and s/c structures (see the last
   section of the file.)
   
   The definitions provided by this frame kernel are simplified versions
   of what would be expected in a flight-like kernel. This should only be
   used for demonstration purposes.


Version and Date
-----------------------------------------------------------

   Version 0.0 -- June 29, 2022 -- John Kidd, ANT

      Pre-release, example version.


References
-----------------------------------------------------------

   1. ``Frames Required Reading''

   2. ``Kernel Pool Required Reading''

   3. ``C-Kernel Required Reading''


Contact Information
-----------------------------------------------------------

   John Kidd, Ascending Node Technologies, john@ascendingnode.tech


Implementation Notes
-----------------------------------------------------------

   This file is used by the SPICE system as follows: programs that make
   use of this frame kernel must ``load'' the kernel, normally during
   program initialization using the SPICELIB routine FURNSH. This file
   was created and may be updated with a text editor or word processor.


Aspera Frames Summary
-----------------------------------------------------------

   The following OSIRIS-REx frames are defined in this kernel file:

           Name                  Relative to           Type       NAIF ID
      ======================  =====================  ==========   =======

   Spacecraft frame:
   -----------------

     ASP_SPACECRAFT          J2000                  CK          -1999000
	  ASP_SOLAR               ASP_SPACECRAFT         FIXED       -1999101
	  ASP_S-BAND              ASP_SPACECRAFT         FIXED       -1999201
	  ASP_SLIT1               ASP_SPACECRAFT         FIXED       -1999301
	  ASP_SLIT2               ASP_SPACECRAFT         FIXED       -1999302

   Structure frames (solar arrays, TAGSAM, antennas, etc):
   -------------------------------------------------------


Spacecraft Bus Frame
-----------------------------------------------------------
 
   The spacecraft bus frame -- ASPERA_SPACECRAFT -- is defined by the s/c
   design as follows:

      -  +X axis completes the right hand coordiante frame
 
      -  +Z axis is normal to the launch vehicle adapter assembly

      -  +Y axis is parallel to structure of the deployed Solar Array panels

      -  the origin of the frame is at the center of payload deck.


   Since the S/C bus attitude is provided by a C kernel (see [3] for
   more information), this frame is defined as a CK-based frame.

   \begindata

      FRAME_ASP_SPACECRAFT             = -1999000
      FRAME_-1999000_NAME              = 'ASP_SPACECRAFT'
      FRAME_-1999000_CLASS             = 3
      FRAME_-1999000_CLASS_ID          = -1999000
      FRAME_-1999000_CENTER            = -1999
      CK_-1999000_SCLK                 = -1999
      CK_-1999000_SPK                  = -1999

   \begintext


All frames (solar array; S-band antenna; slit instrument) have the -Z
axis of their local frame as their "pointing" (normal or boresight)
direction.

+X will be the longest or sample (fastest moving) axis, pointing to
the "right" for images (frame or line) from the slit instrument

+Y will complete the right-hand system, and indicate "up" in instrument
image, so +Y <= (+X cross -Z) <= (Right cross Boresight)



Solar array
===========

The normal to the solar array is nominally -Z S/C; make the rest of the
base frame notionally the same as the autonomous star trackers' frame

            [ 1.00000000000000   0.00000000000000   0.00000000000000 ]
      DCM = [ 0.00000000000000   1.00000000000000   0.00000000000000 ]
            [ 0.00000000000000   0.00000000000000   1.00000000000000 ]

   \begindata

   FRAME_ASP_SOLAR            = -1999101
   FRAME_-1999101_NAME        = 'ASP_SOLAR'
   FRAME_-1999101_CLASS       = 4
   FRAME_-1999101_CLASS_ID    = -1999101
   FRAME_-1999101_CENTER      = -1999
   TKFRAME_-1999101_RELATIVE  = 'ASP_SPACECRAFT'
   TKFRAME_-1999101_SPEC      = 'MATRIX'
   TKFRAME_-1999101_MATRIX    = ( 1.00000000000000,
								 0.00000000000000,
								 0.00000000000000,
								 0.00000000000000,
								 1.00000000000000,
								 0.00000000000000,
								 0.00000000000000,
								 0.00000000000000,
								 1.00000000000000)

   \begintext



S-band antenna
===============

The normal (-Z) to the S-band antenna is nominally S/C +X
Align the S-band +Y "up" axis nominally with S/C +Y
Then for a right-hand system the +X "right" axis aligns with S/C +Z

            [ 0.00000000000000   0.00000000000000   1.00000000000000 ]
      DCM = [ 0.00000000000000   1.00000000000000   0.00000000000000 ]
            [-1.00000000000000   0.00000000000000   0.00000000000000 ]

   \begindata

   FRAME_ASP_S-BAND           = -1999201
   FRAME_-1999201_NAME        = 'ASP_S-BAND'
   FRAME_-1999201_CLASS       = 4
   FRAME_-1999201_CLASS_ID    = -1999201
   FRAME_-1999201_CENTER      = -1999
   TKFRAME_-1999201_RELATIVE  = 'ASP_SPACECRAFT'
   TKFRAME_-1999201_SPEC      = 'MATRIX'
   TKFRAME_-1999201_MATRIX    = ( 0.00000000000000,
								  0.00000000000000,
								  1.00000000000000,
								  0.00000000000000,
								  1.00000000000000,
								  0.00000000000000,
								 -1.00000000000000,
								  0.00000000000000,
								  0.00000000000000)

   \begintext



Slit instrument 1
=================

The normal (-Z) to the Aspera instrument is nominally S/C -X
Align the slit +X long "right" axis with S/C -Z
Then for a right-hand system the +Y "up" axis aligns with S/C +Y

The two slit frames are tied to the base frame, rotated
1degree either way around the X (slit long) axis of the
base frame, which is also the nominal S/C Z axis

            [ 0.00000000000000   0.00000000000000  -1.00000000000000 ]
      DCM = [ 0.00000000000000   1.00000000000000   0.00000000000000 ]
            [ 1.00000000000000   0.00000000000000   0.00000000000000 ]

   \begindata

   FRAME_ASP_SLIT1             = -1999301
   FRAME_-1999301_NAME        = 'ASP_SLIT1'
   FRAME_-1999301_CLASS       = 4
   FRAME_-1999301_CLASS_ID    = -1999301
   FRAME_-1999301_CENTER      = -1999
   TKFRAME_-1999301_RELATIVE  = 'ASP_SPACECRAFT'
   TKFRAME_-1999301_SPEC      = 'MATRIX'
   TKFRAME_-1999301_MATRIX    = ( 0.00000000000000,
								  0.00000000000000,
								 -1.00000000000000,
								  0.00000000000000,
								  1.00000000000000,
								  0.00000000000000,
								  1.00000000000000,
								  0.00000000000000,
								  0.00000000000000)

   \begintext

Slit instrument 2
=================

The normal (-Z) to the Aspera instrument is nominally S/C -X
Align the slit +X long "right" axis with S/C -Z
Then for a right-hand system the +Y "up" axis aligns with S/C +Y

The two slit frames are tied to the base frame, rotated
1degree either way around the X (slit long) axis of the
base frame, which is also the nominal S/C Z axis

            [ 0.00000000000000   0.00000000000000  -1.00000000000000 ]
      DCM = [ 0.00000000000000   1.00000000000000   0.00000000000000 ]
            [ 1.00000000000000   0.00000000000000   0.00000000000000 ]

   \begindata

   FRAME_ASP_SLIT2             = -1999302
   FRAME_-1999302_NAME        = 'ASP_SLIT2'
   FRAME_-1999302_CLASS       = 4
   FRAME_-1999302_CLASS_ID    = -1999302
   FRAME_-1999302_CENTER      = -1999
   TKFRAME_-1999302_RELATIVE  = 'ASP_SPACECRAFT'
   TKFRAME_-1999302_SPEC      = 'MATRIX'
   TKFRAME_-1999302_MATRIX    = ( 0.00000000000000,
								  0.00000000000000,
								 -1.00000000000000,
								  0.00000000000000,
								  1.00000000000000,
								  0.00000000000000,
								  1.00000000000000,
								  0.00000000000000,
								  0.00000000000000)

   \begintext

   \begindata

   TEXT_KERNEL_ID += 'ASPERA_NOTIONAL_FRAMES V0.0.0 22-MAY-2023 FK'

   NAIF_BODY_NAME += ( 'ASPERA' )
   NAIF_BODY_CODE += ( -1999 )

   NAIF_BODY_NAME += ( 'ASP' )
   NAIF_BODY_CODE += ( -1999 )

   NAIF_BODY_NAME += ( 'ASP_SPACECRAFT' )
   NAIF_BODY_CODE += ( -1999 )

   \begintext

End of FK File.
