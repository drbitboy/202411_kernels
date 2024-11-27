
           \begindata

           TEXT_KERNEL_ID += 'ASPERA_NOTIONAL_FRAMES V0.0.0 22-MAY-2023 FK'

           NAIF_BODY_NAME += ( 'ASPERA' )
           NAIF_BODY_CODE += ( -1999 )

           NAIF_BODY_NAME += ( 'ASP' )
           NAIF_BODY_CODE += ( -1999 )

           NAIF_BODY_NAME += ( 'ASP_SPACECRAFT' )
           NAIF_BODY_CODE += ( -1999 )

           \begintext

The following Aspera notional spacecraft frames are defined in this kernel file:

           Frame Name                Relative To              Type     NAIF ID
           =======================   ===================      =======  =======

           Spacecraft frames:
           -----------------------------------
           ASP_SPACECRAFT            J2000                    CK       -1999000
           ASP_ASTR                  ASP_SPACECRAFT           FIXED    -1999001
           ASP_SOLAR_BASE            ASP_ASTR                 FIXED    -1999100
           ASP_S-BAND_BASE           ASP_ASTR                 FIXED    -1999200
           ASP_SLIT_BASE             ASP_ASTR                 FIXED    -1999300

           Solar Frames (-19991xx):
           -----------------------------------
           ASP_SOLAR                 ASP_SOLAR_BASE           FIXED    -1999101

           S-band antenna Frames (-19992xx):
           -----------------------------------
           ASP_S-BAND                ASP_S-BAND_BASE          FIXED    -1999201

           Slit Instrumnet Frames (-19993xx):
           -----------------------------------
           ASP_SLIT_0                ASP_SLIT_BASE            FIXED    -1999301
           ASP_SLIT_1                ASP_SLIT_BASE            FIXED    -1999302

   Since the S/C bus attitude with respect to an inertial frame is provided
   by a C-kernel, this frame is defined as a CK-based frame.

           \begindata

           FRAME_ASP_SPACECRAFT      = -1999000
           FRAME_-1999000_NAME       = 'ASP_SPACECRAFT'
           FRAME_-1999000_CLASS      = 3
           FRAME_-1999000_CLASS_ID   = -1999000
           FRAME_-1999000_CENTER     = -1999
           CK_-1999000_SCLK          = -1999
           CK_-1999000_SPK           = -1999

           \begintext

ASTR (autonomous star trackers) Frame
-------------------------------------------------------------------------------

   The definition of the spacecraft body frame will most likely change after
   launch due to a calibration in the ASTR (star tracker) alignments to the
   principal axes. The star tracker boresight needed to be rotated relative
   to the original orientation in the pre-flight calibration report [TBD]
   in order to match the thruster firing directions with the spin axis of the
   spacecraft (i.e., to the principal moment of inertia).

   In order to rotate all of the instrument boresights by the same amount,
   we introduce a frame taking vectors from the ASTR frame to the spacecraft
   body frame. The nominal instrument frames will be linked to the ASTR frame
   rather than to the spacecraft frame.

   The ASTR to spacecraft body matrix is given [TBD] by:

            [ 1.00000000000000   0.00000000000000   0.00000000000000 ]
      DCM = [ 0.00000000000000   1.00000000000000   0.00000000000000 ]
            [ 0.00000000000000   0.00000000000000   1.00000000000000 ]


           \begindata

           FRAME_ASP_ASTR             = -1999001
           FRAME_-1999001_NAME        = 'ASP_ASTR'
           FRAME_-1999001_CLASS       = 4
           FRAME_-1999001_CLASS_ID    = -1999001
           FRAME_-1999001_CENTER      = -1999
           TKFRAME_-1999001_SPEC      = 'MATRIX'
           TKFRAME_-1999001_RELATIVE  = 'ASP_SPACECRAFT'
           TKFRAME_-1999001_MATRIX    = ( 1.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000)

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

           \begindata

           FRAME_ASP_SOLAR_BASE       = -1999100
           FRAME_-1999100_NAME        = 'ASP_SOLAR_BASE'
           FRAME_-1999100_CLASS       = 4
           FRAME_-1999100_CLASS_ID    = -1999100
           FRAME_-1999100_CENTER      = -1999
           TKFRAME_-1999100_SPEC      = 'MATRIX'
           TKFRAME_-1999100_RELATIVE  = 'ASP_ASTR'
           TKFRAME_-1999100_MATRIX    = ( 1.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000)

           \begintext

The solar array frame is notionally identical to the base frame

           \begindata

           FRAME_ASP_SOLAR            = -1999101
           FRAME_-1999101_NAME        = 'ASP_SOLAR'
           FRAME_-1999101_CLASS       = 4
           FRAME_-1999101_CLASS_ID    = -1999101
           FRAME_-1999101_CENTER      = -1999
           TKFRAME_-1999101_SPEC      = 'MATRIX'
           TKFRAME_-1999101_RELATIVE  = 'ASP_SOLAR_BASE'
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

           \begindata

           FRAME_ASP_S-BAND_BASE      = -1999200
           FRAME_-1999200_NAME        = 'ASP_S-BAND_BASE'
           FRAME_-1999200_CLASS       = 4
           FRAME_-1999200_CLASS_ID    = -1999200
           FRAME_-1999200_CENTER      = -1999
           TKFRAME_-1999200_SPEC      = 'MATRIX'
           TKFRAME_-1999200_RELATIVE  = 'ASP_ASTR'
           TKFRAME_-1999200_MATRIX    = ( 0.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000,
                                         0.00000000000000,
                                        -1.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000)

           \begintext

The S-band antenna frame is notionally identical to the nominal frame

           \begindata

           FRAME_ASP_S-BAND           = -1999201
           FRAME_-1999201_NAME        = 'ASP_S-BAND'
           FRAME_-1999201_CLASS       = 4
           FRAME_-1999201_CLASS_ID    = -1999201
           FRAME_-1999201_CENTER      = -1999
           TKFRAME_-1999201_RELATIVE  = 'ASP_S-BAND_BASE'
           TKFRAME_-1999201_SPEC      = 'MATRIX'
           TKFRAME_-1999201_MATRIX    = ( 1.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000)

           \begintext



Slit instrument
===============

The normal (-Z) to the S-band antenna is nominally S/C -X
Align the slit +X long "right" axis with S/C -Z
Then for a right-hand system the +Y "up" axis aligns with S/C +Y

           \begindata

           FRAME_ASP_SLIT_BASE        = -1999300
           FRAME_-1999300_NAME        = 'ASP_SLIT_BASE'
           FRAME_-1999300_CLASS       = 4
           FRAME_-1999300_CLASS_ID    = -1999300
           FRAME_-1999300_CENTER      = -1999
           TKFRAME_-1999300_RELATIVE  = 'ASP_ASTR'
           TKFRAME_-1999300_SPEC      = 'MATRIX'
           TKFRAME_-1999300_MATRIX    = ( 0.00000000000000,
                                         0.00000000000000,
                                        -1.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000,
                                         0.00000000000000,
                                         1.00000000000000,
                                         0.00000000000000,
                                         0.00000000000000)

           \begintext

The two slit frames are tied to the base frame, rotated
1degree either way around the X (slit long) axis of the
base frame, which is also the nominal S/C Z axis

           \begindata

           FRAME_ASP_SLIT_0           = -1999301
           FRAME_-1999301_NAME        = 'ASP_SLIT_0'
           FRAME_-1999301_CLASS       = 4
           FRAME_-1999301_CLASS_ID    = -1999301
           FRAME_-1999301_CENTER      = -1999
           TKFRAME_-1999301_RELATIVE  = 'ASP_SLIT_BASE'
           TKFRAME_-1999301_SPEC      = 'ANGLES'
           TKFRAME_-1999301_AXES      = (    1,    2,    3 )
           TKFRAME_-1999301_ANGLES    = (  1.0,  0.0,  0.0 )
           TKFRAME_-1999301_UNITS     = 'DEGREES'


           FRAME_ASP_SLIT_1           = -1999302
           FRAME_-1999302_NAME        = 'ASP_SLIT_1'
           FRAME_-1999302_CLASS       = 4
           FRAME_-1999302_CLASS_ID    = -1999302
           FRAME_-1999302_CENTER      = -1999
           TKFRAME_-1999302_RELATIVE  = 'ASP_SLIT_BASE'
           TKFRAME_-1999302_SPEC      = 'ANGLES'
           TKFRAME_-1999302_AXES      = (    1,    2,    3 )
           TKFRAME_-1999302_ANGLES    = ( -1.0,  0.0,  0.0 )
           TKFRAME_-1999302_UNITS     = 'DEGREES'

           \begintext
