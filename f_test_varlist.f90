program test_varlist
    use libvarlist
    implicit none
    type(varlist) :: f_varlist, f_varlist_2D
    real*8, pointer :: val_ptr
    integer :: i, j, m, n, p
    real*8, pointer :: mem_wind_speed_x(:), mem_wind_speed_y(:), mem_wind_short_speed_x(:), mem_wind_short_speed_xy(:,:)
    real*8, dimension(5) :: wind_speed_x, wind_speed_y
    real*8, dimension(3) :: wind_short_speed_x
    real*8, dimension(3,3) :: wind_short_speed_xy
    real*8 :: pressure, mem_pressure
    integer :: number_of_items, item_number

    ! Create varlist
    f_varlist = varlist("test varlist cfi")
    
    ! Allocate and store 1D field
    m = 5
    n = 3
    p = 6
    wind_speed_x = (/1.0, 2.0, 3.0, 4.0, 5.0/)
    wind_speed_y = (/10.0, 20.0, 30.0, 40.0, 50.0/)
    wind_short_speed_x = (/0.1, 0.2, 0.3/)
    wind_short_speed_xy = reshape([100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0], [3,3])
    pressure = 23.0
    
    ! Add elements to varlist
    print*,'Append 1'
    call f_varlist%append("wind_speed_in_x",wind_speed_x)
    print*,'Append 2'
    call f_varlist%append("wind_speed_in_y",wind_speed_y)
    print*,'Append 3'
    call f_varlist%append("wind_short_speed_in_x",wind_short_speed_x)
    print*,'Append 2D'
    call f_varlist%append_2D("wind_short_speed_in_xy",wind_short_speed_xy) 
    print*, 'Append scalar'
    call f_varlist%append_scalar("pressure",pressure)
    
    
    ! Search element
    print*,'Search'
    mem_wind_speed_y => f_varlist%search("wind_speed_in_y")
    print*, " "
    print*, "wind_speed_in_y"
    if (associated(mem_wind_speed_y)) then
       do i=1,5
          print*, mem_wind_speed_y(i)
       end do
    endif

    mem_wind_speed_x => f_varlist%search("wind_speed_in_x")
    print*, " "
    print*, "wind_speed_in_x"
    if (associated(mem_wind_speed_x)) then
       do i=1,5
          print*, mem_wind_speed_x(i)
       end do
    endif

    mem_wind_short_speed_x => f_varlist%search("wind_short_speed_in_x")
    print*, " "
    print*, "wind_short_speed_in_x"
    if (associated(mem_wind_short_speed_x)) then
       do i=1,3
          print*, mem_wind_short_speed_x(i)
       end do
    endif

    mem_wind_short_speed_xy => f_varlist%search_2D("wind_short_speed_in_xy")
    print*, " "
    print*, "wind_short_speed_in_xy"
    if (associated(mem_wind_short_speed_xy)) then
       do i=1,3
          do j=1,3
             print*, mem_wind_short_speed_xy(i,j)
          end do
       end do
    endif

    print*, " "
    print*, "pressure"
    mem_pressure = f_varlist%search_scalar("pressure") 
    print*, pressure

    
#ifdef __GNUC__
    call f_varlist%delete
#endif
end program

