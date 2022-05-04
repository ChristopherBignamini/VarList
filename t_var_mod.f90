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
!     class(t_var_metadata), pointer  :: meta_data_grib TODO: we need data members for both metadata types 
!     class(t_var_metadata), pointer  :: meta_data(:) TODO: we could store ad array of pointer to base metadata types
     class(t_var_data), pointer  :: vardata
  contains
     procedure :: getDescriptor => t_var_getDescriptor
     procedure :: getMetadata => t_var_getMetadata
     procedure :: getData => t_var_getData
  end type t_var

  interface t_var
     module procedure t_var ! TODO: why not in contains section above?
  end interface t_var

contains

  function t_var_create(i_var_descriptor, i_meta_data, i_vardata) result(var)
    implicit none
    type(t_var) :: var
    type(t_var_descriptor), intent(in) :: i_var_descriptor
    class(t_var_metadata), pointer, intent(in) :: i_meta_data
    class(t_var_data), pointer, intent(in) :: i_vardata
    var%var_descriptor = i_var_descriptor
    var%meta_data => i_meta_data
    var%vardata => i_vardata
  end function t_var_create

  function t_var_getDescriptor(this) result(descriptor)
    implicit none
    class(t_var), intent(in) :: this 
    type(t_var_descriptor) :: descriptor ! TODO: avoid copy!
    descriptor = this%var_descriptor
  end function t_var_getDescriptor

  function t_var_getMetadata(this) result(meta_data_ptr)
    implicit none
    class(t_var), intent(in) :: this 
    type(t_var_metadata), pointer :: meta_data_ptr
    meta_data_ptr => this%meta_data
  end function t_var_getMetadata

  function t_var_getData(this) result(data_ptr)
    implicit none
    class(t_var), intent(in) :: this
    type(t_var_data), pointer :: data_ptr
    data_ptr => this%vardata
  end function t_var_getData

end module var_mod
