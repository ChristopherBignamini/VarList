module varcollection_mod
    use, intrinsic :: iso_c_binding
    use var_mod, only : t_var
    
    private
    public :: varcollection

    type varcollection
        private
        type(c_ptr) :: varcollection_ptr
    contains
        final :: varcollection_delete
        procedure :: search => varcollection_search
        procedure :: search_2D => varcollection_search_2D
        procedure :: search_scalar => varcollection_search_scalar
        procedure :: getId => varcollection_getId
        procedure :: getName => varcollection_getName
        procedure :: getCollectionSize => varcollection_getCollectionSize
    end type varcollection

    interface varcollection
       module procedure varcollection_create ! TODO: why not in contains section above?
    end interface varcollection

contains

    function varcollection_create(str, var_array)
        implicit none
        type(varcollection) :: varcollection_create
        character(len=*), intent(in) :: str
        type(t_var), intent(in) :: var_array(:)
        character(len=1, kind=C_CHAR) :: c_str(len_trim(str) + 1)
        integer i, N
        call convertToCString(str,c_str)
        varcollection_create%varcollection_ptr = varcollection_create_c(c_str)
        do i=1:N
           call append(this, var_array(i))
        enddo
    end function varlist_create
    
    subroutine varcollection_delete(this)
        implicit none
        type(varcollection) :: this
        call varcollection_delete_c(this%varcollection_ptr)
    end subroutine varcollection_delete
      
    subroutine append(this, var)
        implicit none
        type(varcollection) :: this
        type(t_var), intent(in) :: var
        ! TODO: p type detection procedure implementation 
        call variable_append_c(this%varlist_cfi_ptr, &
             var%var_descriptor, &
             var%meta_data.standard_name, var%meta_data.units, var%meta_data.long_name, var%meta_data.short_name, var%meta_data.datatype, &
             var%var_data%p)
    end subroutine append
      
!    subroutine varlist_append(this, name, val)
!        implicit none
!        class(varlist_cfi), intent(in) :: this
!        character(len=*), intent(in) :: name
!        real*8, intent(in) :: val(:)
!        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
!        call convertToCString(name,c_name)
!        call varlist_append_c(this%varlist_cfi_ptr, c_name, val)
!    end subroutine varlist_append

!    subroutine varlist_append_2D(this, name, val)
!        implicit none
!        class(varlist_cfi), intent(in) :: this
!        character(len=*), intent(in) :: name
!        real*8, intent(in) :: val(:,:)
!        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
!        call convertToCString(name,c_name)
!        call varlist_append_2D_c(this%varlist_cfi_ptr, c_name, val)
!    end subroutine varlist_append_2D

!    subroutine varlist_append_scalar(this, name, val)
!        implicit none
!        class(varlist_cfi), intent(in) :: this
!        character(len=*), intent(in) :: name
!        real*8, intent(in) :: val
!        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
!        call convertToCString(name,c_name)
!        call varlist_append_scalar_c(this%varlist_cfi_ptr, c_name, val)
!    end subroutine varlist_append_scalar

    function varcollection_search(this, name)
        implicit none
        real*8, pointer :: varcollection_search(:)
        class(varcollection), intent(in) :: this
        character(len=*), intent(in) :: name
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varcollection_search_c(this%varlist_cfi_ptr, c_name, varlist_search)
    end function varcollection_search

    function varlist_search_2D(this, name)
        implicit none
        real*8, pointer :: varlist_search_2D(:,:)
        class(varlist_cfi), intent(in) :: this
        character(len=*), intent(in) :: name
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_search_2D_c(this%varlist_cfi_ptr, c_name, varlist_search_2D)
    end function varlist_search_2D

    function varlist_search_scalar(this, name)
        implicit none
        real*8 :: varlist_search_scalar
        class(varlist_cfi), intent(in) :: this
        character(len=*), intent(in) :: name
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_search_scalar_c(this%varlist_cfi_ptr, c_name, varlist_search_scalar)
    end function varlist_search_scalar

    subroutine varlist_finalize(this)
        implicit none
        class(varlist_cfi) :: this
        call varlist_finalize_c(this%varlist_cfi_ptr)
    end subroutine varlist_finalize

    integer function varlist_getId(this)
        implicit none
        class(varlist_cfi), intent(in) :: this
        varlist_getId = varlist_getId_c(this%varlist_cfi_ptr)
    end function varlist_getId

    !! TODO: "strongly inspired" by the following link..
    !! https://stackoverflow.com/questions/9972743/creating-a-fortran-interface-to-a-c-function-that-returns-a-char
    function varlist_getName(this) ! TODO: I'm not sure of signature and implementation
        use, intrinsic :: iso_c_binding
        implicit none
        character*255 :: varlist_getName
        character*255 list_name
        integer name_length
        class(varlist_cfi), intent(in) :: this

        call varlist_getName_c(this%varlist_cfi_ptr, list_name, name_length)

        varlist_getName = list_name(1:name_length)
    end function varlist_getName

    integer function varlist_getListLength(this)
        implicit none
        class(varlist_cfi), intent(in) :: this
        varlist_getListLength = varlist_getListLength_c(this%varlist_cfi_ptr)
    end function varlist_getListLength

!    function varlist_getFirstVariable(this) result(varlist_first_variable)
!        implicit none
!        class(varlist_cfi), intent(in) :: this
!        type(varlist_item) :: varlist_first_variable
!        type(varlist_item_c) :: varlist_first_variable_c
!        varlist_first_variable_c = varlist_getFirstVariable_c(this%varlist_cfi_ptr)
!        varlist_first_variable = varlist_item(varlist_first_variable_c%name, varlist_first_variable_c%value_cfi_ptr)
!    end function varlist_getFirstVariable

!    function varlist_getNextVariable(this, current_variable) result(varlist_next_variable)
!        implicit none
!        class(varlist_cfi), intent(in) :: this
!        class(varlist_cfi_item), intent(in) :: current_variable ! TODO: only the key is needed
!        type(varlist_cfi_item) :: varlist_next_variable
!        type(varlist_item_c) :: varlist_next_variable_c
!        varlist_next_variable_c = varlist_getNextVariable_c(this%varlist_cfi_ptr, current_variable%getName())
!        varlist_next_variable = varlist_item(varlist_next_variable_c%name, varlist_next_variable_c%value_cfi_ptr)
!    end function varlist_getNextVariable

    ! TODO: buggy subroutine? Do I need to allocate io_cstring outside with the correct lenght?
    subroutine convertToCString(i_fstring, io_cstring)
        implicit none
        character(len=*), intent(in) :: i_fstring
        character(len=1, kind=C_CHAR) :: io_cstring(len_trim(i_fstring) + 1)
        integer :: N, i

        ! TODO: check for code duplication
        ! Converting Fortran string to C string
        N = len_trim(i_fstring)
        do i = 1, N
            io_cstring(i) = i_fstring(i:i) ! TODO: this line or the entire subroutine is buggy! Memory access issue?
        end do
        io_cstring(N + 1) = C_NULL_CHAR

    end subroutine convertToCString

end module varcollection_mod
