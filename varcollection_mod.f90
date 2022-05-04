module varcollection_mod
    use, intrinsic :: iso_c_binding
    use var_mod, only : t_var
    use var_metadata_mod, only : t_var_metadata
    use var_data_mod, only : t_var_data
    
    private
    public :: varcollection

    include "varcollection_def.f90"
    
    type varcollection
        private
        type(c_ptr) :: varcollection_ptr
    contains
        final :: delete
        procedure :: search => varcollection_search
        procedure :: search_2D => varcollection_search_2D
        procedure :: search_scalar => varcollection_search_scalar
        procedure :: getId => varcollection_getId
!        procedure :: getName => varcollection_getName
        procedure :: getSize => varcollection_getSize
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
        integer :: i, N
        call convertToCString(str,c_str)
        varcollection_create%varcollection_ptr = varcollection_create_c(c_str)
        do i = 1, N
           call append(varcollection_create, var_array(i))
        enddo
    end function varcollection_create
    
    subroutine delete(this)
        implicit none
        type(varcollection) :: this
        call varcollection_delete_c(this%varcollection_ptr)
    end subroutine delete
      
    subroutine append(this, var)
        implicit none
        class(varcollection) :: this
        type(t_var), intent(in) :: var
        type(t_var_metadata), pointer :: meta_data_ptr
        type(t_var_data), pointer :: data_ptr
        meta_data_ptr => var%getMetadata()
        data_ptr => var%getData()
        ! TODO: p type detection procedure implementation 
        call variable_append_c(this%varcollection_ptr, &
             var%getDescriptor(), &
             meta_data_ptr%getStandardName(), meta_data_ptr%getUnits(), meta_data_ptr%getLongName(), &
             meta_data_ptr%getShortName(), meta_data_ptr%getDatatype(), &
             data_ptr%getDataPointer())
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
        call varcollection_search_c(this%varcollection_ptr, c_name, varcollection_search)
    end function varcollection_search

    function varcollection_search_2D(this, name)
        implicit none
        real*8, pointer :: varcollection_search_2D(:,:)
        class(varcollection), intent(in) :: this
        character(len=*), intent(in) :: name
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_search_2D_c(this%varcollection_ptr, c_name, varcollection_search_2D)
    end function varcollection_search_2D

    function varcollection_search_scalar(this, name)
        implicit none
        real*8 :: varcollection_search_scalar
        class(varcollection), intent(in) :: this
        character(len=*), intent(in) :: name
        character(len=1, kind=C_CHAR) :: c_name(len_trim(name) + 1)
        call convertToCString(name,c_name)
        call varlist_search_scalar_c(this%varcollection_ptr, c_name, varcollection_search_scalar)
    end function varcollection_search_scalar

    integer function varcollection_getId(this)
        implicit none
        class(varcollection), intent(in) :: this
        varcollection_getId = varcollection_getId_c(this%varcollection_ptr)
    end function varcollection_getId

!    !! TODO: "strongly inspired" by the following link..
!    !! https://stackoverflow.com/questions/9972743/creating-a-fortran-interface-to-a-c-function-that-returns-a-char
!    function varcollection_getName(this) ! TODO: I'm not sure of signature and implementation
!        use, intrinsic :: iso_c_binding
!       implicit none
!        character*255 :: varlist_getName
!        character*255 list_name
!        integer name_length
!        class(varlist_cfi), intent(in) :: this
!
!        call varlist_getName_c(this%varlist_cfi_ptr, list_name, name_length)
!
!        varlist_getName = list_name(1:name_length)
!    end function varlist_getName

    integer function varcollection_getSize(this)
        implicit none
        class(varcollection), intent(in) :: this
        varcollection_getSize = varcollection_getSize_c(this%varcollection_ptr)
    end function varcollection_getSize

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
