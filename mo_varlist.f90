module varlist
    use iso_c_binding

    implicit none

    private
    public :: cpp_varlist

    include "varlist_def.f90"???

    type cpp_varlist
        private
        type(c_ptr) :: varlist_ptr
    contains
        final :: delete_varlist
        procedure :: delete => delete_varlist_polymorph ???
        procedure :: finalize => varlist_finalize
        procedure :: getId => varlist_getId
        procedure :: getName => varlist_getName
        procedure :: getListLength => varlist_getListLength
    end type cpp_varlist

    interface cpp_varlist
       procedure create_varlist
    end interface

contains

    function create_varlist(str)
        implicit none
        type(c_ptr) :: create_varlist_c
        character(len=1, kind=C_CHAR), intent(in) :: str(*)
        create_varlist_c%ptr = create_varlist_c(str)
    end function create_varlist_c

    subroutine delete_varlist(this)
        implicit none
        type(c_ptr) :: this
        call delete_varlist_c(this%ptr)
    end subroutine

    ! TODO: I don't understand why we need this one
    subroutine delete_varlist_polymorph(this)
        implicit none
        class(c_ptr) :: this
        call delete_varlist_c(this%ptr)
    end subroutine

    subroutine varlist_finalize(this)
        implicit none
        type(c_ptr) :: this
        call varlist_finalize_c(this%ptr)
    end subroutine

    integer function varlist_getId(this)
        implicit none
        class(cpp_varlist), intent(in) :: this
        varlist_getId = varlist_getId_c(this%ptr)
    end function

    character(len=*) function varlist_getName(this)
        implicit none
        type(c_ptr), intent(in), value :: cpp_varlist
        varlist_getName = varlist_getName_c(this%ptr)
    end function

    function varlist_getListLength(this)
        implicit none
        type(c_ptr), intent(in), value :: cpp_varlist
        varlist_getName = varlist_getName_c(this%ptr)
    end function


end module class_varlist
