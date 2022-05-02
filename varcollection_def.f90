interface
    function varcollection_create_c(str) bind(C, name="varcollection_create")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr) :: varcollection_create_c
        character(len=1, kind=C_CHAR), intent(in) :: str(*)
    end function varcollection_create_c

    subroutine varcollection_delete_c(varcollection) bind(C, name="varcollection_delete")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), value :: varcollection
    end subroutine varlist_delete_c

    ! TODO: use generic variable_type
    ! TODO: this should be a subroutine, right?
    subroutine varcollection_append_c(varcollection, var_descriptor, &
         standard_name, units, long_name, short_name, datatype, &
         value_pointer) bind(C, name="varcollection_append_h2_v0_wp")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), value :: varcollection
        type(c_ptr), value :: var_descriptor ! TODO: unpack
        character(len=1, kind=C_CHAR), intent(in) :: standard_name(*) 
        character(len=1, kind=C_CHAR), intent(in) :: units(*)        
        character(len=1, kind=C_CHAR), intent(in) :: long_name(*)    
        character(len=1, kind=C_CHAR), intent(in) :: short_name(*)   
        integer(c_int), intent(in) :: datatype                       
        real(dp) :: val(:,:)
    end subroutine varcollection_append_c

    subroutine varcollection_append_2D_c(varcollection, name, val) bind(C, name="varcollection_strcfi_append")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), value :: varcollection
        character(len=1, kind=C_CHAR), intent(in) :: name(*)
        real(c_double) :: val(:,:)
    end subroutine varcollection_append_2D_c

    subroutine varcollection_append_scalar_c(varcollection, name, val) bind(C, name="varcollection_strcfi_append")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), value :: varcollection
        character(len=1, kind=C_CHAR), intent(in) :: name(*)
        real(c_double) :: val
    end subroutine varcollection_append_scalar_c

    subroutine varcollection_search_c(varcollection, name, variable) bind(C, name="varcollection_strcfi_search")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), intent(in), value :: varcollection
        real(c_double) :: variable(:)
        character(len=1, kind=C_CHAR), intent(in) :: name(*)
    end subroutine varcollection_search_c

    subroutine varcollection_search_2D_c(varcollection, name, variable) bind(C, name="varcollection_strcfi_search")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), intent(in), value :: varcollection
        real(c_double) :: variable(:,:)
        character(len=1, kind=C_CHAR), intent(in) :: name(*)
    end subroutine varcollection_search_2D_c

    subroutine varcollection_search_scalar_c(varcollection, name, variable) bind(C, name="varcollection_strcfi_search")
        use, intrinsic :: iso_c_binding
        implicit none
        type(c_ptr), intent(in), value :: varcollection
        real(c_double) :: variable
        character(len=1, kind=C_CHAR), intent(in) :: name(*)
    end subroutine varcollection_search_scalar_c

    function varcollection_getId_c(varcollection) bind(C, name="varcollection_strcfi_getId")
        use, intrinsic :: iso_c_binding
        implicit none
        integer(c_int) :: varcollection_getId_c
        type(c_ptr), intent(in), value :: varcollection
    end function varcollection_getId_c

    subroutine varcollection_getName_c(varcollection, varcollection_name, varcollection_name_length) bind(C, name="varcollection_strcfi_getName") ! TODO: I'm not sure of signature and implementation
        use, intrinsic :: iso_c_binding
        implicit none
        character(len=1, kind=C_CHAR) :: varcollection_name
        integer(c_int) :: varcollection_name_length
        type(c_ptr), intent(in), value :: varcollection
    end subroutine varcollection_getName_c

    function varcollection_getSize_c(varcollection) bind(C, name="varcollection_getSize")
        use, intrinsic :: iso_c_binding
        implicit none
        integer(c_int) :: varcollection_getSize_c
        type(c_ptr), intent(in), value :: varcollection
    end function varcollection_getSize_c

 end interface
