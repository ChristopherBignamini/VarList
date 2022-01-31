interface
    function varlist_create_c(str) bind(C, name="varlist_create")
        use iso_c_bindings
        implicit none
        type(c_ptr) :: varlist_create_c
        character(len=1, kind=C_CHAR), intent(in) :: str(*)
    end function create_varlist_c

    subroutine varlist_delete_c(varlist) bind(C, name="varlist_delete")
        use iso_c_binding
        implicit none
        type(c_ptr), value :: varlist
    end subroutine

    subroutine varlist_finalize_c(varlist) bind(C, name="varlist_finalize")
        use iso_c_binding
        implicit none
        type(c_ptr), value :: varlist
    end subroutine

    function varlist_getId_c(varlist) bind(C, name="varlist_getId")
        use iso_c_binding
        implicit none
        integer(c_int), value :: varlist_getId_c
        type(c_ptr), intent(in), value :: varlist
    function

    function varlist_getName_c(varlist) bind(C, name="varlist_getName")
        use iso_c_binding
        implicit none
        character(len=:, kind=C_CHAR), pointer :: varlist_getName_c
        type(c_ptr), intent(in), value :: varlist
    end function

    function varlist_getListLength_c(varlist) bind(C, name="varlist_getId")
        use iso_c_binding
        implicit none
        integer(c_int), value :: varlist_getListLength_c
        type(c_ptr), intent(in), value :: varlist
    end function
end interface
