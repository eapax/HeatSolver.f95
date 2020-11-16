! A program to integrate heat equation
! By Adam Paxton

program heat_solver

	implicit none

	!Declare Variables
	real, parameter :: D = 7 * 10**(-7)				!Diffusivity (m2s-1) 
	real, parameter :: t_start = 0					!Start time (s)
	real, parameter :: t_stop = 60*365*24*60*60			!Stop time (s)
	real, parameter :: H = 60					!Column height (m)
	real, parameter :: dt = 1800 					!Time step (s)
	real, parameter :: dz = 1					!Space step (m)
	real, parameter :: xi = dt * D * dz**(-2)
	
	!Initialize array for temperature
	integer, parameter :: m = H / dz + 1
	integer, parameter :: n = (t_stop - t_start) / dt
	integer :: i, j
	real, dimension(m, n) :: T					!Temperature

	!Set initial condition
	do i = 1, m
		T(i,1) = 273.15
	end do
	
	!Set soil-top boundary condition
	do j = 1, n 
		T(1,j) = 280.0
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


