module libvarlist
    use, intrinsic :: iso_c_binding
    use libvarlistitem
    use libvarlistitem_c

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
        procedure :: finalize => varlist_finalize
        procedure :: search => varlist_search
        procedure :: getId => varlist_getId
        procedure :: getName => varlist_getName
        procedure :: getListLength => varlist_getListLength
        procedure :: getFirstVariable => varlist_getFirstVariable
!        procedure :: getNextVariable => varlist_getNextVariable
    end type varlist

    interface varlist
       procedure varlist_create ! TODO: why not in contains section above?
    end interface

contains

    function varlist_create(str)
        implicit none
        type(varlist) :: varlist_create
        character(len=*), intent(in) :: str
        character(len=1, kind=C_CHAR) :: c_str(len_trim(str) + 1)
        integer :: N, i

        ! Converting Fortran string to C string
        N = len_trim(str)
        do i = 1, N
            c_str(i) = str(i:i)
        end do
        c_str(N + 1) = C_NULL_CHAR

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
        integer(c_int), intent(in) :: name
        real(c_double), intent(in) :: val
        call varlist_append_c(this%varlist_ptr, name, val)
    end subroutine varlist_append

    function varlist_search(this, name)
        implicit none
        real(c_double), pointer :: varlist_search
        class(varlist), intent(in) :: this
        integer(c_int), intent(in) :: name
        call c_f_pointer(varlist_search_c(this%varlist_ptr, name), varlist_search)
    end function varlist_search

    subroutine varlist_finalize(this)
        implicit none
        class(varlist) :: this
        call varlist_finalize_c(this%varlist_ptr)
    end subroutine varlist_finalize

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

    function varlist_getFirstVariable(this) result(varlist_first_variable)
        implicit none
        class(varlist), intent(in) :: this
        type(varlist_item) :: varlist_first_variable
        type(varlist_item_c) :: varlist_first_variable_c
        varlist_first_variable_c = varlist_getFirstVariable_c(this%varlist_ptr)
        varlist_first_variable = varlist_item(varlist_first_variable_c%name, varlist_first_variable_c%value_ptr)
    end function varlist_getFirstVariable

!    function varlist_getNextVariable(this, current_variable) result(varlist_next_variable)
!        implicit none
!        class(varlist), intent(in) :: this
!        class(varlist_item), intent(in) :: current_variable ! TODO: only the key is needed
!        type(varlist_item) :: varlist_next_variable
!        type(varlist_item_c) :: varlist_next_variable_c
!        varlist_next_variable_c = varlist_getNextVariable_c(this%varlist_ptr, current_variable%getName())
!        varlist_next_variable = varlist_item(varlist_next_variable_c%name, varlist_next_variable_c%value_ptr)
!    end function varlist_getNextVariable

end module libvarlist
