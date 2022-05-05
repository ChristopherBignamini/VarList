module libvarlist
    use, intrinsic :: iso_c_binding
!    use libvarlistcfiitem
!    use libvarlistitem_c

    private
    public :: varlist

    include "varlist_def.f90"

    type varlist
        private
        type(c_ptr) :: varlist_ptr
    contains
        final :: varlist_delete
        procedure :: delete => varlist_delete_polymorph ! TODO: ???
        procedure :: append => varlist_append
        procedure :: append_2D => varlist_append_2D
        procedure :: append_scalar => varlist_append_scalar
        procedure :: search => varlist_search
        procedure :: search_2D => varlist_search_2D
        procedure :: search_scalar => varlist_search_scalar
        procedure :: getId => varlist_getId
        procedure :: getName => varlist_getName
        procedure :: getListLength => varlist_getListLength
!        procedure :: getFirstVariable => varlist_getFirstVariable
!        procedure :: getNextVariable => varlist_getNextVariable
    end type varlist

    interface varlist
       procedure varlist_create ! TODO: why not in contains section above?
    end interface varlist

contains

    function varlist_create(str)
        implicit none
        type(varlist) :: varlist_create
        character(len=*), intent(in) :: str
        character(len=1, kind=C_CHAR) :: c_str(len_trim(str) + 1)
        call convertToCString(str,c_str)
        varlist_create%varlist_ptr = varlist_create_c(c_str)
    end function varlist_create

    subroutine varlist_delete(this)
        implicit none
        type(varlist) :: this
        call varlist_delete_c(this%varlist_ptr)
    end subroutine varlist_delete

    ! TODO: I don't understand why we need this one
    subroutine varlist_delete_polymorph(this)
        implicit none
        class(varlist) :: this
        call varlist_delete_c(this%varlist_ptr)
    end subroutine varlist_delete_polymorph

    subroutine varlist_append(this, name, val)
        implicit none
        class(varlist), intent(in) :: this
        character(len=*), intent(in) :: name
        real*8, intent(in) :: val(:)
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_append_c(this%varlist_ptr, c_name, val)
    end subroutine varlist_append

    subroutine varlist_append_2D(this, name, val)
        implicit none
        class(varlist), intent(in) :: this
        character(len=*), intent(in) :: name
        real*8, intent(in) :: val(:,:)
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_append_2D_c(this%varlist_ptr, c_name, val)
    end subroutine varlist_append_2D

    subroutine varlist_append_scalar(this, name, val)
        implicit none
        class(varlist), intent(in) :: this
        character(len=*), intent(in) :: name
        real*8, intent(in) :: val
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_append_scalar_c(this%varlist_ptr, c_name, val)
    end subroutine varlist_append_scalar

    function varlist_search(this, name)
        implicit none
        real*8, pointer :: varlist_search(:)
        class(varlist), intent(in) :: this
        character(len=*), intent(in) :: name
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_search_c(this%varlist_ptr, c_name, varlist_search)
    end function varlist_search

    function varlist_search_2D(this, name)
        implicit none
        real*8, pointer :: varlist_search_2D(:,:)
        class(varlist), intent(in) :: this
        character(len=*), intent(in) :: name
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_search_2D_c(this%varlist_ptr, c_name, varlist_search_2D)
    end function varlist_search_2D

    function varlist_search_scalar(this, name)
        implicit none
        real*8 :: varlist_search_scalar
        class(varlist), intent(in) :: this
        character(len=*), intent(in) :: name
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_search_scalar_c(this%varlist_ptr, c_name, varlist_search_scalar)
    end function varlist_search_scalar

    integer function varlist_getId(this)
        implicit none
        class(varlist), intent(in) :: this
        varlist_getId = varlist_getId_c(this%varlist_ptr)
    end function varlist_getId

    !! TODO: "strongly inspired" by the following link..
    !! https://stackoverflow.com/questions/9972743/creating-a-fortran-interface-to-a-c-function-that-returns-a-char
    function varlist_getName(this) ! TODO: I'm not sure of signature and implementation
        use, intrinsic :: iso_c_binding
        implicit none
        character*255 :: varlist_getName
        character*255 list_name
        integer name_length
        class(varlist), intent(in) :: this

        call varlist_getName_c(this%varlist_ptr, list_name, name_length)

        varlist_getName = list_name(1:name_length)
    end function varlist_getName

    integer function varlist_getListLength(this)
        implicit none
        class(varlist), intent(in) :: this
        varlist_getListLength = varlist_getListLength_c(this%varlist_ptr)
    end function varlist_getListLength

!    function varlist_getFirstVariable(this) result(varlist_first_variable)
!        implicit none
!        class(varlist), intent(in) :: this
!        type(varlist_item) :: varlist_first_variable
!        type(varlist_item_c) :: varlist_first_variable_c
!        varlist_first_variable_c = varlist_getFirstVariable_c(this%varlist_ptr)
!        varlist_first_variable = varlist_item(varlist_first_variable_c%name, varlist_first_variable_c%value_cfi_ptr)
!    end function varlist_getFirstVariable

!    function varlist_getNextVariable(this, current_variable) result(varlist_next_variable)
!        implicit none
!        class(varlist), intent(in) :: this
!        class(varlist_item), intent(in) :: current_variable ! TODO: only the key is needed
!        type(varlist_item) :: varlist_next_variable
!        type(varlist_item_c) :: varlist_next_variable_c
!        varlist_next_variable_c = varlist_getNextVariable_c(this%varlist_ptr, current_variable%getName())
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

end module libvarlist
