KPL/MK

	The names and contents of the kernels referenced by this meta-kernel are as follows:

	File Name			    	Description
	--------------------------  ----------------------------------
    aspera.00000.draft.tsc      
    aspera_sso_10am.bsp         
    de430.bsp                   
    naif0012.tls                
    pck00011_n0066.tpc  
    asp_v000.tf              
    cdr_3_ck.bc
    svalbard_s-band.prediCkt
    ndosl_190716_v02.bsp
    ndosl_190716_v02.tf
    earth_assoc_itrf93.tf
    earth200101990628.bpc
    M82spk.bsp
    M82pck.tpc
    asp_v00.draftE.tf
    asp_v00.draftE.ti

\begindata
   KERNELS_TO_LOAD = (
               './geometries/kernels/ck/svalbard_s-band.prediCkt.tc'
               './geometries/kernels/spk/ndosl_190716_v02.bsp'
               './geometries/kernels/fk/ndosl_190716_v02.tf'
               './geometries/kernels/sclk/aspera.00000.draft.tsc'
               './geometries/kernels/spk/aspera_sso_10am.bsp'
               './geometries/kernels/spk/de430.bsp'   
               './geometries/kernels/lsk/naif0012.tls'
               './geometries/kernels/pck/pck00011_n0066.tpc'
               './geometries/kernels/fk/asp_v000.tf'
               './geometries/kernels/ck/cdr_3_ck.bc'
               './geometries/kernels/fk/earth_assoc_itrf93.tf'
               './geometries/kernels/pck/earth200101990628.bpc'
               './geometries/brian/M82spk.bsp'
                './geometries/brian/M82pck.tpc'
                './geometries/kernels/spk/hst_edited.bsp'
                './geometries/kernels/fk/asp_v00.draftE.tf'
               './geometries/kernels/ik/asp_v00.draftE.ti'
			   )
/begintext