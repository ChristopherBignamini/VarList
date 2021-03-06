interface
    function varlist_create_c(str) bind(C, name="varlist_create")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr) :: varlist_create_c
        character(len=1, kind=C_CHAR), intent(in) :: str(*)
    end function varlist_create_c

    subroutine varlist_delete_c(varlist) bind(C, name="varlist_delete")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), value :: varlist
    end subroutine varlist_delete_c

    ! TODO: use generic variable_type
    ! TODO: this should be a subroutine, right?
    subroutine varlist_append_c(varlist, name, val) bind(C, name="varlist_append")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), value :: varlist
        integer(c_int), intent(in), value :: name
        real(c_double), intent(in), value :: val
    end subroutine varlist_append_c

    function varlist_search_c(varlist, name) bind(C, name="varlist_search")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr) :: varlist_search_c
        type(c_ptr), intent(in), value :: varlist
        integer(c_int), intent(in) :: name
    end function varlist_search_c

    subroutine varlist_finalize_c(varlist) bind(C, name="varlist_finalize")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), value :: varlist
    end subroutine varlist_finalize_c

    function varlist_getId_c(varlist) bind(C, name="varlist_getId")
        use, intrinsic :: iso_c_binding
        implicit none
        integer(c_int) :: varlist_getId_c
        type(c_ptr), intent(in), value :: varlist
    end function varlist_getId_c

    subroutine varlist_getName_c(varlist, varlist_name, varlist_name_length) bind(C, name="varlist_getName") ! TODO: I'm not sure of signature and implementation
        use, intrinsic :: iso_c_binding
        implicit none
        character(len=1, kind=C_CHAR) :: varlist_name
        integer(c_int) :: varlist_name_length
        type(c_ptr), intent(in), value :: varlist
    end subroutine varlist_getName_c

    function varlist_getListLength_c(varlist) bind(C, name="varlist_getListLength")
        use, intrinsic :: iso_c_binding
        implicit none
        integer(c_int) :: varlist_getListLength_c
        type(c_ptr), intent(in), value :: varlist
    end function varlist_getListLength_c

    function varlist_getFirstVariable_c(varlist) bind(C, name="varlist_getFirstVariable")
        use, intrinsic :: iso_c_binding
        use libvarlistitem_c, only : varlist_item_c
        implicit none
        type(varlist_item_c) :: varlist_getFirstVariable_c
        type(c_ptr), intent(in), value :: varlist
    end function varlist_getFirstVariable_c

    function varlist_getNextVariable_c(varlist, current_variable_key) bind(C, name="varlist_getNextVariable")
        use, intrinsic :: iso_c_binding
        use libvarlistitem_c, only : varlist_item_c
        implicit none
        type(varlist_item_c) :: varlist_getNextVariable_c
        type(c_ptr), intent(in), value :: varlist
        integer(c_int), intent(in), value  :: current_variable_key
    end function varlist_getNextVariable_c

 end interface
