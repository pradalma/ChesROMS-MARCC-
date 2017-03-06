#!/bin/bash
#
# setenvironmentvariables_oqcs_template.sh :
#
#  To set up the environmental variables that are needed for the OQCS 
#  (Ocean Quality Control System)
#
#  ****Note that you should modify this template and save it as
#
#      setenvironmentvariables_oqcs_yourmachinename.sh
#
#  where yourmachinename is the name of your machine, which can be found by linux/unix command
#
#         echo $HOSTNAME
#  or 
#         hostname

#
# COMF OQCS root directory, edit it according to where you install COMF and ChesROMS
# in your computer.
# Note that no space before or behind the '=' is allowed,
#           no '/' should be at the end of the directories
#             


export COMFDIR=/home-3/mpradal1@jhu.edu/work/ChesROMS/COMF    #need to change this one according to where you put COMF
export CORMSLOG=/dev/null
export OQCSDIR=$COMFDIR/oqcs
export OHMSDIR=$COMFDIR/ohms

export OQCS_BIN=$OQCSDIR/binlinux                   #need to change this one accoding to your compile
                                              #Note, please make sure you do have the directory $OQCS_BIN 
                                                 
export OQCS_SCPT=$OQCSDIR/scripts   
export OQCS_SORC=$OQCSDIR/sorc
export OQCS_INFO=$OQCSDIR/info
export OQCS_DOCS=$OQCSDIR/docs
export OQCS_TEST=$OQCSDIR/testdir

export OQCSBIN=$OQCS_BIN     

#
#---The following are path setups for softwares that COMF OQCS will need have access to
#   Please edit accordingly
#

# points to your installation of NCL
export NCARG_ROOT=/home-3/mpradal1@jhu.edu/work/ChesROMS/bin/ncl

# Point to your NetCDF libraries and includes
#export NETCDF_ROOT=/usr/local/netcdf/netcdfrun
export NETCDF_ROOT=/cm/shared/apps/netcdf-fortran/intel/4.4.2/lib
export NETCDF_ROOT=/cm/shared/apps/netcdf-fortran/intel/4.4.2/include

# Point to your NCO libaries and includes
#export NCO_ROOT=/usr
#export NCO_BIN=$NCO_ROOT/bin
export NCO_ROOT=/cm/shared/apps/nco/4.5.2
export NCO_BIN=$NCO_ROOT/bin

# Point to your wgrib2 binary directory. wgrib2 is a tool for converting grib2 files into 
# netcdf files and other functions for interrogating grib2 files. Here we want the 
# oqcs system know where $WGRIB2_BIN/wgrib2 file is 

export WGRIB2_BIN=/usr/bin

#
# force a simple PATH first.  This is important, because this
# script will be called many times, and we don't want $PATH keep 
# increasing because of repeating calls
#

export PATH=/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin:.

#
# Add the other necessary parts to the PATH
#

export PATH=$PATH:$NCARG_ROOT/bin                #NCL 

export PATH=$PATH:$OQCSBIN:$OQCS_SCPT            #OQCS of COMF

export PATH=$PATH:$NETCDF_ROOT/bin:$NETCDF_ROOT/include:$NETCDF_ROOT/lib   #NetCDF

export PATH=$PATH:$NCO_ROOT/bin:$NCO_ROOT/include:$NCO_ROOT/lib            #NCO 

export PATH=$PATH:$WGRIB2_BIN                                              #WGRIB2_BIN

#
#---MPICH  if you use MPICH in your system for parallel computing---
#   This is not necessary becaue ChesROMS can run on serial computer
#   If your computer is distributed parallel system,  please install mpich1.2.6 or later version
#   or OpenMPI 
#
 
#  export PATH=$PATH:/usr/local/mpich1.2.6/bin:/usr/local/mpich.1.2.6/lib:/usr/local/mpich1.2.6/include 
#  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/mpich1.2.6/lib 
#  export MANPATH=$MANPATH:/usr/local/mpich1.2.6/man
#  export F90="mpif90"
#  export F77="mpif77"

#
#---OpenMPI if you use OpenMPi as your MPI compiler--
#   export PATH=$PATH:/usr/local/openmpi/bin:/usr/local/openmpi/lib:/usr/local/openmpi/include
#   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/openmpi/lib
#---------

#
#---The following are pointing to setups of your C/C++ and Fortran compilers--
#   This is specific for intel C and Fortran compiler. If you do use Intel compilers
#   Please edit accordingly. If you don't use Intel Compilers, please modify according
#   to your compiler configuration.  We suggest you install intel Fortran and C compiler
#   version 10.0.023 or later 
#

# Point to a fortran 90 compiler and setup
source /opt/intel/Compiler/fc/11.1.046/bin/ia32/ifortvars_ia32.sh   #comment this  out and substitute 
                                                 #with your fortran compiler, if no ifort 
                                                 #in your system

# Point to a intel c compiler and setup

source /opt/intel/Compiler/cc/11.1.046/bin/ia32/iccvars_ia32.sh     #comment this  out and substitute 
                                                 #with your C/C++ compiler, if no icc
                                                 #in your system

# Point to intel debugger and setup
#source /opt/intel/idb/9.1.040/bin/idbvars.sh     #comment this  out and substitute 
                                                 #with your debugger, if no idb 
                                                 #in your system


export FORTRAN=ifort 
export FORTRAN_FLAGS=-pc80                 #-pc80 is an option for ifort, so if you use gfortran, then don't
                                           #include this


#
# end of setenvironmentalvariables_oqcs_template.sh 
#

