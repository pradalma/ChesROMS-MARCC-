
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
\_                                                                                    \_
\_  ChesROMS1.2: Chesapeake Bay Regional Ocean Modeling System.                       \_
\_                                                                                    \_
\_    1) Nowcast and forecast Chesapeake Tides, Flow, T and S, DO, water quality      \_
\_                                                                                    \_
\_    2) Nowcast and forecast Sea Nettles abundance levels daily                      \_
\_                                                                                    \_
\_    3) Bay retrospective investigation and analysis (1991 to 2005)                  \_
\_                                                                                    \_
\_                                                                                    \_
\_  Team: Chris Brown, Raleigh Hood, Tom Gross, Peter Tano, Douglas Ramers            \_
\_        Wen Long, Kyle Wilcox, Lyon Lanerolle, Jiangtao Xu, Hong Lin                \_
\_                                                                                    \_
\_  Documentation: Wen Long, March 23rd, 2007                                         \_
\_  Last Editting: Jerry Wiggert, 21 August 2007                                      \_
\_                 Wen Long and Mohan, 26 Oct, 2007                                   \_
\_                 Wen Long, Sept 22, 2009                                            \_
\_                 Wen Long, Oct  29, 2012                                            \_
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_  


How to use this software:

    This is how this software is organized.  The ChesROMS is developed under the NOAA COMF (coastal ocean model framework). COMF contains two major components:

      OQCS----Ocean Quality Control System which uses shell, c, c++, fortran and perl etc language to download data from various websites. 

      OHMS----Ocean Hydrodynamic Model System, which contains a number of ocean models and CHESROMS is only one part of it that is dedicated to Chesapeake Bay. 

      OMDS----Ocean Model Dissemination System, which contains a number of programs to display model results through the www (currently under development)

      OMAS----Ocean Model Assessment System, which contains a number of programs to assess accuracy, statistics etc of model results (this is currently under development) 

Outline:

    1. Set up the environment variables for ChesROMS   
    2. Compile and test OQCS
    3. Download and Install ROMS3.0, Patch with ChesROMS
    4. How to run ChesROMS for retrospective physics (historical run) from 1991 to 2005
    5. How to run ChesROMS operationally.
    6. Contact, FAQ

1. Set up the environment variables for ChesROMS   

       You should use bash instead of other shells to execute or set up environmental variables.

        1) edit ./oqcs/setenvironmentvariables_oqcs_$HOSTNAME.sh

           cp ./oqcs/setenvironmentvariables_oqcs.sh  ./oqcs/setenvironmentvariables_oqcs_$HOSTNAME.sh
           edit ./oqcs/setenvironmentvariables_oqcs_$HOSTNAME.sh

        2) copy ./ohms/CHESROMS/setupChesROMS_template.sh to ./ohms/CHESROMS/setupChesROMS_$HOSTNAME.sh
            
           cp ./ohms/CHESROMS/setupChesROMS_template.sh ./ohms/CHESROMS/setupChesROMS_$HOSTNAME.sh
           edit ./ohms/CHESROMS/setupChesROMS_$HOSTNAME.sh

        3) cp ./ohms/CHESROMS/startup_template.m ./ohms/CHESROMS/startup.m
           edit ./ohms/CHESROMS/startup.m,    copy it to ~/matlab/. 
      
2. Compile and test OQCS

        1) edit ./oqcs/sorc/library/Makefileifort to compile liboqcs.a
  
           cd ./oqcs/sorc/library/
           source ../../setenvironmentalvariables_oqcs_$HOSTNAME.sh
           make -f Makefileifort
        
          If you decide to use other fortran compiler, you probably need to 
          modify the make file a bit to make it work.  

       2) edit ./oqcs/sorc/Makefile, this is a fake makefile, it's named Makefile, while it is really a shell script, you should execute it as regular shell. 
         If you use compilers other than icc and ifort, you need to edit it. 
         
           cd ./oqcs/sorc
           chmod +x Makefile
           ./Makefile


       3) test OQCS:

          go to ./oqcs/testdir/, run the Test_oqcs.sh to test out the data retrieval utilities

              cd ./oqcs/testdir
              Test_oqcs.sh

           go to ./oqcs/testdir/CBay_river, follow the readme.txt there, run CBay_river_dailymean.sh and  CBay_river.sh to further test the river data retrieval.

              cd ./oqcs/testdir/CBay_river
              ./CBay_river_dailymean.sh "1995 01 01 0 0" "2006 08 15 00 00" "2006 08 25 00 00"

3. Download and Install ROMS3.0, Patch with ChesROMS

       1) go to ./ohms/CHESROMS/sorc/ROMS

          follow instructions there to download ROMS3.0 original code from myroms.org and then patch it to be ChesROMS hydrodynamic code 

       2) Compile ROMS3.0

          modify ./ohms/CHESROMS/sorc/ROMS/ROMS3.0/chesroms_compile_***.sh to suit your system, most likely you will
choose one of the chesroms_compile_***.sh depending on whether your system is MPI or OMP or serial.  The most important thing is that you give the correct netcdf library and include locations.
    
          and 

          source ./ohms/CHESROMS/setupChesROMS_$HOSTNAME.sh 

          and then execute the compile shell script you modified

          ./ohms/CHESROMS/sorc/ROMS/ROMS3.0/chesroms_compile_***.sh 

          use unix command "uname -a" to find out your machine info

          make
          make clean

          You should generate a ChesROMS_3_0_MPI.exe or ChesROMS_3_0_serial.exe or ChesROMS_3_0_OpenMP.exe in $CHESROMS_BIN if your compile is successful. 

       3) compile tide_fac.f in sorc

          goto ./ohms/CHESROMS/sorc/fortran

          follow the readme file there to compile tide_fac.f and genreate tide_fac.x and then move the tide_fac.x file into $CHESROMS_BIN, i.e. ./ohms/CHESROMS/bin/ directory

          tide_fac.f is needed in preparing for tidal forcing

4. How to run ChesROMS for retrospective physics (historical run) from 1991 to 2005

        1) Run example year 1999

          All the forcing files except surface forcing for year 1999 are prepared. To run year 1999, you need to:

            a) go to ./ohms/CHESROMS/forcing/Surface

              run the shell script mksurf_1999.sh to generate the surface forcing file chesroms_forcing_surface_1999.nc 

              cd ./ohms/CHESROMS/forcing/Surface
              ./mksurf_1999.sh

            b) copy the surface forcing file to ./ohms/CHESROMS/work/yearly/1999/forcing/

              cp chesroms_forcing_surface_1999.nc $ChesROMS_ROOT/work/yearly/1999/forcing/.
      
            c) go to $ChesROMS_ROOT/work/yearly/1999/ROMS
              follow the read me there to run the model.

        2) Run years other from 1991 to 2005

          The forcings and data for 1991-1998, 2000-2005 are not included in ChesROMS release package in order to reduce package size. You can download raw data and prepare the forcing as follows:

            a) go to ./ohms/CHESROMS/data/CBay_river_discharge, run the CBay_river.sh script to get river discharge data

              go to ./ohms/CHESROMS/data/CBay_WaterLevelOBC_MSL, run the script CBay_WaterLevel_hourly_halfyearOBC.sh to get open boundary water level data
             
              go to ./ohms/CHESROMS/data/CBay_WaterLevelOBC_MSL/wach, run the script wl_wach_1991_2006.sh to get open boundary Wachpreague station data due to it's not available on NWLON web

              go to /ohms/CHESROMS/data/NARR/, run script fetch_narr_jw.sh to get NARR data

              The upper data are necessary for making river forcing and open boundary forcing and surface forcing. The following data are not necessary but useful for model validation.

              go to ./ohms/CHESROMS/data/CBay_WaterLevel_MSL, run the 
              CBay_WaterLevel_hourly_halfyear.sh script to get water level data

           b)  goto  ./ohms/CHESROMS/forcing/IC        ----Initial condition
                                            /OBC       ----Open BC forcing
                                            /Rivers    ----River forcing
                                            /Surface   ----Surface forcing
                                            /Tides     ----Tidal forcing
     
              run the matlab scripts there to prepare forcing for a retrospective year run (1991-2005). Copy the forcing files to $CHESROMS_WORK/yearly/yyyy/forcing/

              Copy the following files :

                 $ChesROMS_ROOT/sorc/ROMS/ROMS3.0/CBay/varinfo.dat -->
                            $CHESROMS_WORK/yearly/yyyy/ROMS/varinfo.dat

                 $ChesROMS_ROOT/sorc/ROMS/ROMS3.0/stations.in      -->
                            $CHESROMS_WORK/yearly/yyyy/ROMS/stations.in
 
                 $ChesROMS_ROOT/sorc/ROMS/ROMS3.0/toms_Nz20_kw.in  -->
                            $CHESROMS_WORK/yearly/yyyy/ROMS/toms_Nz20_kw.in 

                 copy the grid ./ohms/forcing/Grids/chesroms_grid_smoother_msl.nc to $CHESROMS_WORK/yearly/yyyy/forcing/.

               edit $CHESROMS_WORK/yearly/yyyy/ROMS/toms_Nz20_kw.in.  What you should edit:
               NtileI, NtileJ, varinfo.dat, grid file name, forcing file names, DT, DSTART, TIDE_START, TIME_REF, output interval etc. Where DSTART and TIDE_START should be equal to days after basedate 1980-01-01-00-00-00. This could be found by ncdump -h tideforcing.nc 

               make directory $CHESROMS_WORK/yearly/yyyy/output

           c)  Run the model:
               
                  cd $CHESROMS_WORK/yearly/yyyy/ROMS/
               
                  $CHESROMS_BIN/ChesROMS_3_0_serial.exe < toms_Nz20_kw.in
               or
                  mpirun -np 8 ROMS_3_0_MPI.exe toms_Nz20_kw.in 
   
               The output files should be in $CHESROMS_WORK/yearly/yyyy/output/ directory


           d) analyize results using matlab tools in ./ohms/sorc/matlab/visual/
              Please note that the tools are not fully developed, you may have to edit them to make it work for you.

5. How to run ChesROMS operationally.

         Currently ChesROMS1.2 can nowcast and forecast Chesapeake Bay Tides, Flow, T, S daily, can also nowcast and forecast Sea Nettle abundance levels daily.
 
        1) make sure you have the following softwares installed and function correctly:

         a) netcdf        (NetCDF library, must have it)
         b) curl          (Normally already in your unix/linux system)
         c) wget          (Normally already in your unix/linux system)
         d) crontab       (schedule runs, must have it)
         e) svn           (useful if you update your code from our repositary)
         f) NCL           (NCAR Command Language package, must have it)
         g) NCO           (NetCDF Operator, a tool to manipulate NetCDF files, must have it)
         h) fortran and c compilers (must have them)
         i) shapelib      (shape file generation library tool kit, must have it)
         j) perl          (must have it) 
         k) matlab        (this is needed for post-processing in generating K.Micrum (one of HAB species) shape files
                           
         A list of them is located at ./ohms/CHESROMS/support-software 

       2) Initial run of ChesROMS1.2 operatinal

       
	go to ./ohms/CHESROMS/postprocess/chesroms2shp, compile the chesroms2shp programs: 

             source ./ohms/CHESROMS/setupChesROMS_$HOSTNAME.sh
             make  

        go to ./ohms/CHESROMS/scripts/

        edit  MAIN_ROMS_INIT.sh to give the correct path to the setupChesROMS.sh 

        edit  MAIN_ROMS_INIT.sh that gave the ROMS_EXECUTABLE according to your compile 
        in step 3.

        Run the shell script MAIN_ROMS_INIT.sh for an initial run, i.e.

          MAIN_ROMS_INIT.sh "1990 01 01 00 00" "2007 03 23 00 00" "2007 03 24 00 00"

        Please note that the date you give can be a year or more before your current time, the model can retrieve all forcing from more than a year ago.   


       3) Schedule restart of ChesROMS1.2 for daily nowcasts and forecasts:

         go to ./ohms/CHESROMS/scripts/

         edit MAIN_ROMS_RESTART.sh give the correct path to the setupChesROMS_$HOSTNAME.sh

         edit MAIN_ROMS_RESTART.sh that gave the ROMS_EXECUTABLE according to your compile in step 3.

         edit CRONTAB_CHESROMS file

         submit the scheduled crontab 

         sudo crontab -u your_user_name CRONTAB_CHESROMS 
        
       4) results should be stored in ./ohms/CHESROMS/archive/ 

       5) post processing still under development
           
          Now, there is a chesroms2shp which generates shape files for 

               a)K.Micrum abundance
               b)sea nettles abundance level and 
               c)Vibrio vholerae probability
               d)DO level (mg/L)
               e)Vibrio vulnificus probability

          based on emprical predictions using T and S 

6 How to setup OMDS

	This is incomplete documentation for OMDS. But most basic components are there. Please see COMF/omds/documents/ directory for my notes - Wen Long

	The OMDS is based on a number of open source tools that can be used to host model results through web/map service and OpenDAP etc.

        Still need to work on customized capabilities such as to provide user interaction on viewing results. Stay tuned...       

7. OMAS

	OMAS is still in construction. We need to provide online user interaction capability. It should be able to provide tools to do skill assessment 
	and then send the assessment results to OMDS for display. So far skill assessments are done using matlab scripts. We may want to move forward to
        python or octave.


8. Contact, FAQ

       Common problem with compilers: make sure your netcdf library, MPI, mexnc, nco libraries etc are 
                                      compiled by the same compilers (gcc/gfortran vs icc/ifort) for ROMS. 
                                      If you compile/install netcdf using gfortran/gcc and try to compile 
                                      MPI and ROMS with ifort/icc then it is likely not going to work.

                                      You can not compile MPI using ifort and then compile ROMS with mpif90
                                      using netcdf lib compiled by gfortran. 

       http://ccmp.chesapeake.org/CCMP/models/ChesROMS/
       http://sourceforge.net/projects/chesroms/ 
       


