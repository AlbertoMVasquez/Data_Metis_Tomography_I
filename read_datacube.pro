 ; Please follow instructions below to read into memory:
; * The 3D data cubes of MHD-simulations and tomographic-reconstructions.
; * The cell-centered uniform spherical grid on which each data cube is provided.

;======================================================================================================
; First, compile all routines contained in this IDL file.
; IDL> .r read_data.pro

;======================================================================================================
; CR-2082:

; To read the electron density [Ne] of the CR 2082 AWSoM simulation:
; IDL> read_AWSOM_CR2082,rad,theta,phi,Ne_datacube
;      
; To read the tomography-reconstructed Ne for the aphelion segment:
; IDL> read_SRT_CR2082_Aphelion,rad,theta,phi,Ne_datacube
;
; Similar commands allow to read the Perihelion and Maximum-latitude results.

;======================================================================================================
; CR-2152:
;
; Repeat the commands above, changing the sufffix 'CR2082' by 'CR2152'
;
;======================================================================================================

pro read_AWSOM_CR2082,rad,theta,phi,Ne_datacube
  dir = './'
  file = 'Ne_AWSoM_CR2082.dat'
  rmin =  2.0
  rmax = 12.0
  nr   = 200
  nt   = 180
  read_datacube,dir,file,rmin,rmax,nr,nt,rad,theta,phi,Ne_datacube
  help,rad,theta,phi,Ne_datacube
  return
end

pro read_AWSOM_CR2152,rad,theta,phi,Ne_datacube
  dir = './'
  file = 'Ne_AWSoM_CR2152.dat'
  rmin =  2.0
  rmax = 12.0
  nr   = 200
  nt   = 180
  read_datacube,dir,file,rmin,rmax,nr,nt,rad,theta,phi,Ne_datacube
  help,rad,theta,phi,Ne_datacube
  return
end

pro read_SRT_CR2082_Aphelion,rad,theta,phi,Ne_datacube
  dir = './'
  file = 'Ne_SRT_CR2082_Aphelion.dat'
  rmin =  5.1
  rmax = 12.7
  nr   = 38
  nt   = 90
  read_datacube,dir,file,rmin,rmax,nr,nt,rad,theta,phi,Ne_datacube
  Irmin =  5.7
  Irmax = 10.3
  cut_datacube,rad,Ne_datacube,Irmin,Irmax
  help,rad,theta,phi,Ne_datacube
  return
end

pro read_SRT_CR2152_Aphelion,rad,theta,phi,Ne_datacube
  dir = './'
  file = 'Ne_SRT_CR2152_Aphelion.dat'
  rmin =  5.1
  rmax = 12.7
  nr   = 38
  nt   = 90
  read_datacube,dir,file,rmin,rmax,nr,nt,rad,theta,phi,Ne_datacube
  Irmin =  5.7
  Irmax = 10.3
  cut_datacube,rad,Ne_datacube,Irmin,Irmax
  help,rad,theta,phi,Ne_datacube
  return
end

pro read_SRT_CR2082_Perihelion,rad,theta,phi,Ne_datacube
  dir = './'
  file = 'Ne_SRT_CR2082_Perihelion.dat'
  rmin =  1.8
  rmax =  5.2
  nr   = 34
  nt   = 60
  read_datacube,dir,file,rmin,rmax,nr,nt,rad,theta,phi,Ne_datacube
  Irmin =  2.4
  Irmax =  3.2
  cut_datacube,rad,Ne_datacube,Irmin,Irmax
  help,rad,theta,phi,Ne_datacube
  return
end

pro read_SRT_CR2152_Perihelion,rad,theta,phi,Ne_datacube
  dir = './'
  file = 'Ne_SRT_CR2152_Perihelion.dat'
  rmin =  1.8
  rmax =  5.2
  nr   = 34
  nt   = 60
  read_datacube,dir,file,rmin,rmax,nr,nt,rad,theta,phi,Ne_datacube
  Irmin =  2.4
  Irmax =  3.2
  cut_datacube,rad,Ne_datacube,Irmin,Irmax
  help,rad,theta,phi,Ne_datacube
  return
end

pro read_SRT_CR2082_MaxLat,rad,theta,phi,Ne_datacube
  dir = './'
  file = 'Ne_SRT_CR2082_MaxLat.dat'
  rmin =  3.3
  rmax =  7.5
  nr   = 42
  nt   = 90
  read_datacube,dir,file,rmin,rmax,nr,nt,rad,theta,phi,Ne_datacube
  Irmin =  3.5
  Irmax =  5.0
  cut_datacube,rad,Ne_datacube,Irmin,Irmax
  help,rad,theta,phi,Ne_datacube
  return
end

pro read_SRT_CR2152_MaxLat,rad,theta,phi,Ne_datacube
  dir = './'
  file = 'Ne_SRT_CR2152_MaxLat.dat'
  rmin =  3.3
  rmax =  7.5
  nr   = 42
  nt   = 90
  read_datacube,dir,file,rmin,rmax,nr,nt,rad,theta,phi,Ne_datacube
  Irmin =  3.5
  Irmax =  5.0
  cut_datacube,rad,Ne_datacube,Irmin,Irmax
  help,rad,theta,phi,Ne_datacube
  return
end

pro read_datacube,dir,file,rmin,rmax,nr,nt,rad,theta,phi,Ne_datacube
; INPUTS: dir, file, rmin, rmax, nr, ntH.
; OUTPUTS: rad, theta, phi, Ne_datacube

; Load 3D datacube:
  np=2*nt
  Ne_datacube=fltarr(nr,nt,np)
  openr,1,dir+file
  readu,1,Ne_datacube ; This loads the Ne[cm^-3] datacube
  close,1

; Create spherical grid of the datacube:

; Radial [Rsun] spherical grid cell center:
  drad   = (Rmax-Rmin)/nr ; radial size of cell
  RAD    = Rmin + drad/2. + drad*findgen(nr) ; grid cell center RAD [Rsun]

; Theta [deg] spherical grid cell center: (here index=0 is the South pole, theta=180 deg)
  dtheta = 180./nt ; phi size of cell
  THETA  = 180. - dtheta/2. - dtheta*findgen(nt) ; grid cell center THETA [deg]

; Phi [deg] spherical grid cell center:
  dphi   = 360./np ; theta size of cell
  PHI    = 0. + dphi/2. + dphi*findgen(np) ; grid cell center PHI [deg]

 ; Note that: 
;  PHI is the same as the Carrington Longitude
;  THETA is the spherical coordinate polar angle, 
;  so that THETA=180 is the SOUTH pole and THETA=0 is the NORH pole.

  return
end

; Eliminate heights above Irmax and below Irmin
pro cut_datacube,rad,Ne_datacube,Irmin,Irmax
  irad = where ( rad ge Irmin and rad le Irmax)
  rad = reform ( rad (irad) )
  Ne_datacube= reform ( Ne_datacube(irad,*,*) )
  return
end


