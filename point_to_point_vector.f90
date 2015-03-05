program point_to_point_vector
  use mpi
  implicit none

  integer, dimension(MPI_STATUS_SIZE) :: status
  integer, parameter                   :: tag=100
  integer                              :: rank,code
  real(kind=8), dimension(3)           :: vector

  call MPI_INIT(code)
  call MPI_COMM_RANK( MPI_COMM_WORLD ,rank,code)

  if (rank == 0) then
    vector = (/ 7, 8, 9 /)
    call MPI_SEND (vector,3, MPI_INTEGER ,2,tag, MPI_COMM_WORLD,code)
  elseif (rank == 2) then
    call MPI_RECV (vector,3, MPI_INTEGER ,0,tag, MPI_COMM_WORLD,status,code)
    print *,'I am process ',rank,'. I received vector',vector,' from process 0'
  end if

  call MPI_FINALIZE (code)

end program point_to_point_vector
