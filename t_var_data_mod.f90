module var_data
  private
  public :: t_var_data

  type t_var_data
     private
     logical :: is_allocated
     real*8, pointer :: data(:,:)
  end type t_var_data

  interface t_var_data
     module procedure t_var_data_create
  end interface t_var_data

contains

  function t_var_data_create(i_is_allocated, i_data) return(t_var_data)
     logical, intent(in) :: i_is_allocated
     real*8, pointer :: i_data(:,:)
     t_var_data%is_allocated = i_is_allocated
     t_var_data%data => i_data
  end function t_var_data_create
   
end module var_data
