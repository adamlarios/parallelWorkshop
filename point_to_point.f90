program point_to_point
  use mpi
  implicit none

  integer, dimension(MPI_STATUS_SIZE) :: status
  integer, parameter                   :: tag=100
  integer                              :: rank,value,code

  call MPI_INIT(code)
  call MPI_COMM_RANK(MPI_COMM_WORLD ,rank,code)

  if (rank == 0) then
    value=314
    call MPI_SEND(value,1, MPI_INTEGER ,2,tag, MPI_COMM_WORLD,code)
  elseif (rank == 2) then
    call MPI_RECV(value,1, MPI_INTEGER ,0,tag, MPI_COMM_WORLD,status,code)
    print *,'I am process ',rank,'. I received value ',value,' from the process 2'
  end if

  call MPI_FINALIZE (code)

end program point_to_point
