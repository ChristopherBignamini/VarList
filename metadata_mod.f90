module libmetadata

  use, intrinsic :: iso_c_binding
  use libutils

  private
  public :: metadata_cf

  include "metadata_def.f90"
  
  type metadata_cf
     private
     type(c_ptr) :: metadata_cf_ptr
   contains
!     final :: metadata_cf_delete
     procedure :: setStandardName => metadata_setStandardName
 !    procedure :: set_units => metadata_cf_set_units
 !    procedure :: set_long_name => metadata_cf_set_long_name
 !    procedure :: set_datatype => metadata_cf_set_datatype
 !    procedure :: set_short_name => metadata_cf_set_short_name
     procedure :: getStandardName => metadata_getStandardName
 !    procedure :: get_units => metadata_cf_get_units
 !    procedure :: get_long_name => metadata_cf_get_long_name
 !    procedure :: get_datatype => metadata_cf_get_datatype
 !    procedure :: get_short_name => metadata_cf_get_short_name
  end type metadata_cf

  interface metadata_cf
     procedure metadata_cf_create ! TODO: why not in contains section above?
  end interface metadata_cf

contains

!    character(len=*), intent(in) :: str
!    character(len=1, kind=C_CHAR) :: c_str(len_trim(str) + 1)

  function metadata_cf_create()
    implicit none
    type(metadata_cf) :: metadata_cf_create
    metadata_cf_create%metadata_cf_ptr = metadata_cf_create_c()
  end function metadata_cf_create

  subroutine metadata_setStandardName(this, standard_name)
    implicit none
    class(metadata_cf), intent(in) :: this
    character(len=*), intent(in) :: standard_name
    character(len=1, kind=C_CHAR) :: c_standard_name(len_trim(standard_name) + 1)
    call convertToCString(standard_name, c_standard_name)
    call metadata_setStandardName_c(this%metadata_cf_ptr, c_standard_name)
  end subroutine metadata_setStandardName

  ! TODO code duplication with varlist_getName
  function metadata_getStandardName(this)
    use, intrinsic :: iso_c_binding
    implicit none
    character*255 :: metadata_getStandardName
    character*255 standard_name
    integer name_length
    class(metadata_cf), intent(in) :: this
    
    call metadata_getStandardName_c(this%metadata_cf_ptr, standard_name, name_length)
    
    metadata_getStandardName = standard_name(1:name_length)
  end function metadata_getStandardName

end module libmetadata
