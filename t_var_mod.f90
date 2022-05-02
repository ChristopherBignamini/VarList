module var_mod
  use var_descriptor_mod, only: t_var_descriptor
  use var_metadata_mod, only: t_var_metadata  
  use var_data_mod, only: t_var_data

  private
  public :: t_var

  type t_var
     private
!     type(c_ptr) :: t_var_ptr
     type(t_var_descriptor) :: var_descriptor 
     class(t_var_metadata), pointer  :: meta_data
     class(t_var_data), pointer  :: vardata
  end type t_var

  interface t_var
     module procedure t_var ! TODO: why not in contains section above?
  end interface t_var

contains

  function t_var_create(i_var_descriptor, i_meta_data, i_vardata) result(t_var)
    implicit none
    type(t_var_descriptor), intent(in) :: i_var_descriptor
    class(t_var_metadata), intent(in) :: i_meta_data
    class(t_var_data), intent(in) :: i_vardata
    t_var%var_descriptor = i_var_descriptor
    t_var%meta_data => i_meta_data
    t_var%vardata => i_vardata
  end function t_var_create
  
end module var_mod
