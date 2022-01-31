interface
    function create_varlist_c(str) bind(C, name="create_varlist")
        use iso_c_bindings
        implicit none
        type(c_ptr) :: create_varlist_c
        character(len=1, kind=C_CHAR), intent(in) :: str(*)
        ! TODO: what do we return?
    end function create_varlist_c

    subroutine delete_varlist_c(cpp_varlist) bind(C, name="delete_varlist")
        use iso_c_binding
        implicit none
        type(c_ptr), value :: cpp_varlist
    end subroutine

    subroutine varlist_finalize_c(cpp_varlist) bind(C, name="varlist_finalize")
        use iso_c_binding
        implicit none
        type(c_ptr), value :: cpp_varlist
    end subroutine

    function varlist_getId_c(cpp_varlist) bind(C, name="varlist_getId")
        use iso_c_binding
        implicit none
        integer(c_int), value :: id
        type(c_ptr), intent(in), value :: cpp_varlist
    function

    function varlist_getName_c(cpp_varlist) bind(C, name="varlist_getName")
        use iso_c_binding
        implicit none
        character(len=1, kind=C_CHAR), intent(out) :: str(*)
        type(c_ptr), intent(in), value :: cpp_varlist
    end function

    function varlist_getListLength_c(cpp_varlist) bind(C, name="varlist_getId")
        use iso_c_binding
        implicit none
        integer(c_int), value :: list_length
        type(c_ptr), intent(in), value :: cpp_varlist
    end function
end interface
