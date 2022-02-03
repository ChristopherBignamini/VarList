module libvarlist
    use, intrinsic :: iso_c_binding

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
        procedure :: getId => varlist_getId
        procedure :: getName => varlist_getName
        procedure :: getListLength => varlist_getListLength
    end type varlist

    interface varlist
       procedure varlist_create ! TODO: why not in contains section above?
    end interface

contains

    function varlist_create(str)
        implicit none
        type(varlist) :: varlist_create
        character(len=*), intent(in) :: str
        varlist_create%varlist_ptr = varlist_create_c(str)
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
        class(varlist) :: this
        integer(c_int), intent(in) :: name
        real(c_double), intent(in) :: val
        call varlist_append_c(this%varlist_ptr, name, val)
    end subroutine varlist_append

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

        varlist_getName = list_name(1:name_length-1)
    end function varlist_getName

    integer function varlist_getListLength(this)
        implicit none
        class(varlist), intent(in) :: this
        varlist_getListLength = varlist_getListLength_c(this%varlist_ptr)
    end function varlist_getListLength

end module libvarlist
