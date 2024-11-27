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

    rel_path = 'geometries/kernels/ik/asp_v00.draftE.ti'
    ik = os.path.join(cwd, rel_path)
    sp.furnsh(ik)

    rel_path = 'geometries/kernels/lsk/naif0012.tls'
    lsk = os.path.join(cwd, rel_path)
    sp.furnsh(lsk)

    rel_path = 'geometries/kernels/fk/asp_v00.draftE.tf'
    fk = os.path.join(cwd, rel_path)
    sp.furnsh(fk)

    rel_path = 'geometries/kernels/sclk/aspera.00000.draft.tsc'
    sclk = os.path.join(cwd, rel_path)
    sp.furnsh(sclk)

    rel_path = 'geometries/kernels/ck/cdr_3_ck.bc'
    ck = os.path.join(cwd, rel_path)
    sp.furnsh(ck)

    rel_path = 'geometries/kernels/mk/asperaMetaKernelM82.tm'
    mk = os.path.join(cwd, rel_path)
    sp.furnsh(mk)

    # Instrument ID, no. vectors, size of each vector, & size of frame name (slit)
    instid = -1999301 # ASP_SLIT1
    room = 4
    shapelen = 10
    framelen = 10

    # FOV for instrument
    [shape, frame, bsight, n, bounds] = sp.getfov(instid, room, shapelen, framelen)

    # Print important values (shape, frame, boresight, and FOV)
    print('\nSHAPE: ', shape)
    print('FRAME: ', frame)
    print('BORESIGHT: ', bsight)
    print('\nBOUNDS:\n', bounds)

    # First corner of FOV
    c1 = bounds[0]
    up_vector = np.cross(bsight, c1)
    up_magnitude = sp.vnorm(up_vector)
    up_unit_vector = up_vector / up_magnitude

    # Time in J2000 frame
    utc = '2025-06-01T00:00:00'
    et = sp.utc2et(utc)

    rotation_matrix = sp.pxform('ASP_SLIT1', 'J2000', et)

    print(rotation_matrix)

    # print('\nUP DIRECTION: ', up_unit_vector)
    # print()

    sp.unload(ik)
    sp.unload(lsk)
    sp.unload(fk)
    sp.unload(sclk)
    sp.unload(ck)
    sp.unload(mk)

main()