import os
from pathlib import Path
import spiceypy as sp
import numpy as np


def main():
    """Rotates S/C vector to boresight vector.

    Args:
        None

    Returns:
        None
    """
    # Find location of kernel & furnish it
    cwd = Path.cwd()

    naifkretrieve()

    rel_path = 'geometries/kernels/mk/asperaMetaKernelM82.tm'
    mk = os.path.join(cwd, rel_path)
    sp.furnsh(mk)

    # Get FOV information for instrument
    # - sp.bodn2c => Instrument ID (integer)
    # - 99 (room) => maximum number of 3-vector bounds (vertices) to return
    # - 99 (shapelen) => maximum length of shape string
    # - 99 (framelen) => maximum length of frame name string
    instid = sp.bodn2c('ASP_SLIT1')
    shape, frame, bsight, n, bounds = sp.getfov(instid,99,99,99)

    # Get Aspera rectangle reference vector:  defined as RIGHT in IK
    # Right cross Boresight => Up
    # Boresight cross Up => Right
    vright = sp.gdpool(f'INS{instid}_FOV_REF_VECTOR',0,3)
    vup = sp.ucrss(vright,bsight)
    vright = sp.ucrss(bsight,vup)

    # Print important values (shape, frame, boresight, and FOV)
    print('\nFOV')
    print(f'- FRAME:  {frame}')
    print(f'- SHAPE: {shape}')
    print(f'- BORESIGHT:  {bsight}')
    print(f'- REF_VECTOR(Right):  {vright}')
    print(f'- Right X Bore (Up):  {vup}')
    print('- BOUNDS:\n', bounds)
     

    """
    FYI:  the following (obsolete) code:

      c1 = bounds[0]
      up_vector = np.cross(bsight, c1)
      up_magnitude = sp.vnorm(up_vector)
      up_unit_vector = up_vector / up_magnitude
      # print('\nUP DIRECTION: ', up_unit_vector)
      # print()

    can be replaced by
    
      up_unit_vector = sp.ucrss(bsight, c1)

    """

    # Time in J2000 frame
    utc = '2025-06-01T00:01:00'
    et = sp.utc2et(utc)

    rotation_matrix = sp.pxform(frame, 'J2000', et)

    # Get basis X, Y, Z
    # Rotate J2000 North (Z) into instrument frame
    # Calculate NORAZ (NORth-AZimuth) in FOV, clockwise from up
    spx, spy, spz = sp.ident()
    fovN = sp.mtxv(rotation_matrix, spz)
    vnoraz = sp.vpack(sp.vdot(vup,fovN),sp.vdot(vright,fovN),0.0)
    noraz = sp.recrad(vnoraz)[1]

    print(f'\nUTC:  ',sp.et2utc(et,'ISOC',3))
    print(f'\nQUAT([{frame}]=>[J2000]; [A,X,Y,Z]):  ',sp.m2q(rotation_matrix))
    print(f'MATRIX([{frame}]=>[J2000]):\n',rotation_matrix)
    vboreJ2k = sp.mxv(rotation_matrix,bsight)
    print(f'\nJ2000\n- BORESIGHT VECTOR:  ',vboreJ2k)
    ra,dec = sp.recrad(vboreJ2k)[1:]
    dpr = sp.dpr()
    print(f'- BORESIGHT RA,DEC,NORAZ; deg:  ',np.array([ra,dec,noraz])*dpr)
    angle1,angle2,angle3 = sp.m2eul(rotation_matrix,3,1,3)
    print(f'- 3-1-3 EULER ANGLES; deg:      ',np.array([angle3,angle2,angle1])*dpr)

    print()
    sp.unload(mk)

def naifkretrieve(url_suffix=None):

    if url_suffix is None:
        naifkretrieve(url_suffix="generic_kernels/spk/planets/de430.bsp")
        naifkretrieve(url_suffix="HST/kernels/spk/hst_edited.bsp")
        return

    try:
        bn = os.path.basename(url_suffix)
        local_path = os.path.join("geometries", bn)
        assert os.path.exists(local_path)
    except:
        url = os.path.join("https://naif.jpl.nasa.gov/pub/naif", bn)
        import subprocess
        print(f"Retrieving {bn} from JPL/NAIF ...")
        cmd = f"curl --progress-bar {url} --output {local_path}"
        assert not subprocess.run(cmd.split()).returncode
        print("... retrieval complete")
    assert os.path.exists(local_path)



if "__main__" == __name__:
    main()
