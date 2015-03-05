program integral
  use mpi
  implicit none

  integer, dimension(MPI_STATUS_SIZE) :: status
  integer, parameter                  :: tag=100

  integer, parameter                  :: N=100
  integer                             :: nb_procs,rank,block_length,code
  real, allocatable, dimension(:)     :: values,f

  integer                             :: i
  real(kind=8)                        :: x, dx, local_integral, global_integral
  real(kind=8) , parameter            :: pi = 3.141592653589793238d0

  call MPI_INIT(code)
  call MPI_COMM_SIZE(MPI_COMM_WORLD,nb_procs,code)
  call MPI_COMM_RANK(MPI_COMM_WORLD,rank,code)

  block_length = N/nb_procs

  allocate(f(block_length))

  dx = pi/(N-1)

  do i = 1,block_length
    x = (rank*block_length + i - 1)*dx
    f(i) = sin(x)
  enddo

  local_integral = sum(f(1:block_length))*dx

  print *, 'I, processor ',rank, ', computed local integral ',local_integral

  call MPI_ALLREDUCE(local_integral,global_integral,1,MPI_REAL8,MPI_SUM,MPI_COMM_WORLD,code)

  if (rank == 0) then 
    print *, 'The global integral is ', global_integral
  end if

  call MPI_FINALIZE (code)

end program integral
