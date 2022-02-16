program test_varlist
    use libvarlist
    use libvarlistitem
    implicit none
    type(varlist) :: f_varlist
    type(varlist_item) :: f_varlist_first_item, f_varlist_next_item
    real*8, pointer :: val_ptr
    integer :: number_of_items, item_number

    ! Create varlist
    f_varlist = varlist("test varlist")

    ! Print varlist data
    print*, f_varlist%getId()
    print*, f_varlist%getName()

    ! Add elements to varlist
    call f_varlist%append(1,1.1D0)
    call f_varlist%append(2,2.2D0)
    call f_varlist%append(3,3.3D0)

    ! Search element and print if found
    val_ptr => f_varlist%search(1)
    print*, "f_varlist variable 1"
    print*, " "
    if (associated(val_ptr)) print*, val_ptr
    print*, " "

    ! Get first variable and print 
    f_varlist_first_item = f_varlist%getFirstVariable()
    print*, "f_varlist first variable name and value"
    print*, f_varlist_first_item%getName()
    print*, f_varlist_first_item%getValuePtr()
    print*, " "

    ! Loop over other varlist elements    
    number_of_items = f_varlist%getListLength()
    item_number = 1
    f_varlist_next_item = f_varlist_first_item
    do while (item_number<number_of_items)
        f_varlist_next_item = f_varlist%getNextVariable(f_varlist_next_item)
        print*, "f_varlist next variable name and value"
        print*, f_varlist_next_item%getName()
        print*, f_varlist_next_item%getValuePtr()
        print*, " "
        item_number = item_number + 1
     enddo

#ifdef __GNUC__
    call f_varlist%delete
#endif
end program

