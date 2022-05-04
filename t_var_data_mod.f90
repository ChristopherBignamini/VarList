module var_data_mod
  private
  public :: t_var_data

  type t_var_data
     private
     logical :: is_allocated
     real*8, pointer :: data(:,:)
   contains
     procedure :: getDataPointer => t_var_data_getDataPointer
  end type t_var_data

  interface t_var_data
!     procedure t_var_data_create
  end interface t_var_data

contains

!  function t_var_data_create(i_is_allocated, i_data) return(var_data)
!     type(t_var_data) :: var_data
!     logical, intent(in) :: i_is_allocated
!     real*8, pointer :: i_data(:,:)
!     var_data%is_allocated = i_is_allocated
!     var_data%data => i_data
!  end function t_var_data_create

  function t_var_data_getDataPointer(this) result(data)
    implicit none
    class(t_var_data), intent(in) :: this
    real*8, pointer :: data(:,:)
    data => this%data
  end function t_var_data_getDataPointer
  
end module var_data_mod
