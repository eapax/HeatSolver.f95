! A program to integrate heat equation
! By Adam Paxton

program heat_solver

	implicit none

        !Declare Variables
        integer, parameter :: rk = 4
	real(kind=rk), parameter :: D = 7 * 10d0**(-7)				!Diffusivity (m2s-1) 
	real(kind=rk), parameter :: t_start = 0					!Start time (s)
	real(kind=rk), parameter :: t_stop = 60*365*24*60*60			!Stop time (s)
	real(kind=rk), parameter :: H = 60d0					!Column height (m)
	real(kind=rk), parameter :: dt = 1800d0 				!Time step (s)
	real(kind=rk), parameter :: dz = 1d0					!Space step (m)
	real(kind=rk), parameter :: xi = dt * D * dz**(-2)
	
	!Initialize array for temperature
	integer, parameter :: m = H / dz + 1
	integer, parameter :: n = (t_stop - t_start) / dt
	integer :: i, j
        real(kind=rk), dimension(m, n) :: T					!Temperature

	!Set initial condition
	do i = 1, m
		T(i,1) = 273.15d0
	end do
	
	!Set soil-top boundary condition
	do j = 1, n 
		T(1,j) = 280.0d0
	end do
     
	!Integrate 
	!Forward-Euler with centred finite-difference and zero-Neumann at soil bottom.
	do j = 1, n-1
		do i = 2, m-1
			T(i, j+1)=T(i, j) + xi * (T(i+1, j) - 2*T(i, j) + T(i-1, j))
		end do
		T(m, j+1) = T(m, j) + xi * (-T(m, j) + T(m-1, j)) 
	end do
	
	!Print results
	do i = 1, m
		print*, (T(i,j), j = 1, n)
	end do

end program


