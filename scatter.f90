program scatter
  use mpi
  implicit none
  integer, parameter              :: nb_values=8
  integer                         :: nb_procs,rank,block_length,i,code
  real, allocatable, dimension(:) :: values,data

  call MPI_INIT (code)
  call MPI_COMM_SIZE ( MPI_COMM_WORLD ,nb_procs,code)
  call MPI_COMM_RANK ( MPI_COMM_WORLD ,rank,code)
  block_length=nb_values/nb_procs
  allocate(data(block_length))

  if (rank == 2) then
    allocate(values(nb_values))
    values(:)=(/(1000.+i,i=1,nb_values)/)
    print *,'I, process ',rank,'send my values array : ',&
             values(1:nb_values)
  end if
 
    call MPI_SCATTER (values,block_length, MPI_REAL ,data,block_length, &
                      MPI_REAL ,2, MPI_COMM_WORLD,code)
  print *,'I, process ',rank,', received ', data(1:block_length), &
          ' of process 2'

  call MPI_FINALIZE (code)

end program scatter
