module libvarlist
    use iso_c_binding

    implicit none

    private
    public :: cpp_varlist

    include "varlist_def.f90"

    type varlist
        private
        type(c_ptr) :: varlist_ptr
    contains
        final :: varlist_delete
        procedure :: delete => varlist_delete_polymorph ! TODO: ???
        procedure :: finalize => varlist_finalize
        procedure :: getId => varlist_getId
        procedure :: getName => varlist_getName
        procedure :: getListLength => varlist_getListLength
    end type cpp_varlist

    interface varlist
       procedure varlist_create ! TODO: why not in contains section above?
    end interface

contains

    function varlist_create(str)
        implicit none
        type(c_ptr) :: varlist_create_c
        character(len=*), intent(in) :: str
        varlist_create_c%ptr = create_varlist_c(str)
    end function create_varlist_c

    subroutine varlist_delete(this)
        implicit none
        type(varlist) :: this
        call varlist_delete_c(this%ptr)
    end subroutine

    ! TODO: I don't understand why we need this one
    subroutine delete_varlist_polymorph(this)
        implicit none
        class(varlist) :: this
        call varlist_delete_c(this%ptr)
    end subroutine

    subroutine varlist_finalize(this)
        implicit none
        type(varlist) :: this
        call varlist_finalize_c(this%ptr)
    end subroutine

    integer function varlist_getId(this)
        implicit none
        class(varlist), intent(in) :: this
        varlist_getId = varlist_getId_c(this%ptr)
    end function

    character(len=*) function varlist_getName(this)
        implicit none
        class(varlist), intent(in) :: this
        varlist_getName = varlist_getName_c(this%ptr)
    end function

    integer function varlist_getListLength(this)
        implicit none
        class(varlist), intent(in) :: this
        varlist_getListLength = varlist_getListLength_c(this%ptr)
    end function

end module class_varlist
