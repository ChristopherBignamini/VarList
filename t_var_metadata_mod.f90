module var_metadata_mod
  private
  public :: t_var_metadata

  type t_var_metadata
     private
     character(len=*) :: standard_name
     character(len=*) :: units
     character(len=*) :: long_name
     integer :: datatype
     character(len=*) :: short_name
  end type t_var_metadata

  interface t_var_metadata
     module procedure t_var_metadata_create
  end interface t_var_metadata

contains

  function t_var_metadata_create(i_standard_name, i_units, i_long_name, i_datatype, i_short_name) result(var_metadata)
    type(t_var_metadata) :: var_metadata
    character(len=*) :: i_standard_name
    character(len=*) :: i_units
    character(len=*) :: i_long_name
    integer :: i_datatype
    character(len=*) :: i_short_name
    var_metadata%standard_name = i_standard_name
    var_metadata%units = i_units
    var_metadata%long_name = i_long_name
    var_metadata%datatype = i_datatype
    var_metadata%short_name = i_short_name
  end function t_var_metadata_create
  
end module var_metadata_mod
