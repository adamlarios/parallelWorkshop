      program hello_world
      include '/usr/include/mpif.h'
      integer ierr

      call MPI_INIT ( ierr )
      print *, "Hello world"
      call MPI_FINALIZE ( ierr )

      stop
      end
