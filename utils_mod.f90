module libutils

  use, intrinsic :: iso_c_binding

contains
  
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

end module libutils
