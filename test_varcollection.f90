program test_varcollection
    use varlistcollection
    implicit none
    type(varcollection) :: f_varcollection
    integer :: i, j, m, n, p
    real*8, pointer :: mem_wind_speed_x(:), mem_wind_speed_y(:), mem_wind_short_speed_x(:), mem_wind_short_speed_xy(:,:)
    real*8, target, dimension(5) :: wind_speed_x, wind_speed_y
    real*8, target, dimension(3) :: wind_short_speed_x
    real*8, target, dimension(3,3) :: wind_short_speed_xy
    real*8 :: pressure, mem_pressure
    integer :: number_of_items, item_number
    type(t_var) :: var_array(3)

    ! Allocate and store fields
    m = 5
    n = 3
    p = 6
    wind_speed_x = (/1.0, 2.0, 3.0, 4.0, 5.0/)
    wind_speed_y = (/10.0, 20.0, 30.0, 40.0, 50.0/)
    wind_short_speed_x = (/0.1, 0.2, 0.3/)
    wind_short_speed_xy = reshape([100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0], [3,3])
    pressure = 23.0

    
    var_array(1) = t_var(t_var_descriptor("name_x",0, 1, 2, 3), &
         t_metadata("standard_name_x", "units_x", "long_name_x", 1, "short_name_x"), &
         t_var_data(.true., wind_speed_x)) 

    var_array(2) = t_var(t_var_descriptor("name_y",0, 1, 2, 3), &
         t_metadata("standard_name_y", "units_y", "long_name_y", 2, "short_name_y"), &
         t_var_data(.true., wind_speed_y)) 

    var_array(3) = t_var(t_var_descriptor("name_short_x",0, 1, 2, 3), &
         t_metadata("standard_name_short_x", "units_short_x", "long_name_short_x", 3, "short_name_short_x"), &
         t_var_data(.true., wind_short_speed_xy)) 

    ! Create varcollection
    f_varcollection = varcollection("test varcollection", var_array)

    
    ! Print varlist data
!    print*, f_varlist%getId()
!    print*, f_varlist%getName()
!    print*, f_varlist_cfi%getId()
!    print*, f_varlist_cfi%getName()

    ! Add elements to varlist
!    call f_varlist%append(1,1.1D0)
!    call f_varlist%append(2,2.2D0)
!    call f_varlist%append(3,3.3D0)

    ! Search element and print if found
!    val_ptr => f_varlist%search(1)
!    print*, "f_varlist variable 1"
!    print*, " "
!    if (associated(val_ptr)) print*, val_ptr
!    print*, " "

    ! Get first variable and print 
!    f_varlist_first_item = f_varlist%getFirstVariable()
!    print*, "f_varlist first variable name and value"
!    print*, f_varlist_first_item%getName()
!    print*, f_varlist_first_item%getValuePtr()
!    print*, " "

    ! Loop over other varlist elements    
!    number_of_items = f_varlist%getListLength()
!    item_number = 1
!    f_varlist_next_item = f_varlist_first_item
!    do while (item_number<number_of_items)
!        f_varlist_next_item = f_varlist%getNextVariable(f_varlist_next_item)
!        print*, "f_varlist next variable name and value"
!        print*, f_varlist_next_item%getName()
!        print*, f_varlist_next_item%getValuePtr()
!        print*, " "
!        item_number = item_number + 1
!     enddo

    
    ! Add elements to varlist
!    print*,'Append 1'
!    call f_varlist_cfi%append("wind_speed_in_x",wind_speed_x)
!    print*,'Append 2'
!    call f_varlist_cfi%append("wind_speed_in_y",wind_speed_y)
!    print*,'Append 3'
!    call f_varlist_cfi%append("wind_short_speed_in_x",wind_short_speed_x)
!    print*,'Append 2D'
!    call f_varlist_cfi%append_2D("wind_short_speed_in_xy",wind_short_speed_xy) 
!    print*, 'Append scalar'
!    call f_varlist_cfi%append_scalar("pressure",pressure)
    
    
    ! Search element
!    print*,'Search'
!    mem_wind_speed_y => f_varlist_cfi%search("wind_speed_in_y")
!    print*, " "
!    print*, "wind_speed_in_y"
!    if (associated(mem_wind_speed_y)) then
!       do i=1,5
!          print*, mem_wind_speed_y(i)
!       end do
!    endif

!    mem_wind_speed_x => f_varlist_cfi%search("wind_speed_in_x")
!    print*, " "
!    print*, "wind_speed_in_x"
!    if (associated(mem_wind_speed_x)) then
!       do i=1,5
!          print*, mem_wind_speed_x(i)
!       end do
!    endif

!    mem_wind_short_speed_x => f_varlist_cfi%search("wind_short_speed_in_x")
!    print*, " "
!    print*, "wind_short_speed_in_x"
!    if (associated(mem_wind_short_speed_x)) then
!       do i=1,3
!          print*, mem_wind_short_speed_x(i)
!       end do
!    endif

!    mem_wind_short_speed_xy => f_varlist_cfi%search_2D("wind_short_speed_in_xy")
!    print*, " "
!    print*, "wind_short_speed_in_xy"
!    if (associated(mem_wind_short_speed_xy)) then
!       do i=1,3
!          do j=1,3
!             print*, mem_wind_short_speed_xy(i,j)
!          end do
!       end do
!    endif

!    print*, " "
!    print*, "pressure"
!    mem_pressure = f_varlist_cfi%search_scalar("pressure") 
!    print*, pressure

    
#ifdef __GNUC__
    call f_varcollection%delete
#endif
end program

