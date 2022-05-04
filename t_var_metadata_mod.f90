module var_metadata_mod
  private
  public :: t_var_metadata

  type t_var_metadata
     private
     ! TODO: can we use variable lenght strings?
     character(len=128) :: standard_name
     character(len=128) :: units
     character(len=128) :: long_name
     integer :: datatype
     character(len=128) :: short_name
  contains
     procedure :: getStandardName => t_var_metadata_getStandardName
     procedure :: getUnits => t_var_metadata_getUnits
     procedure :: getLongName => t_var_metadata_getLongName
     procedure :: getDatatype => t_var_metadata_getDatatype
     procedure :: getShortName => t_var_metadata_getShortName
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
     
  function t_var_metadata_getStandardName(this) result(standard_name)
    implicit none
    class(t_var_metadata), intent(in) :: this
    character(len=:), allocatable :: standard_name
    allocate(character(len(this%standard_name)) :: standard_name)
    standard_name = this%standard_name
  end function t_var_metadata_getStandardName
  
  
  function t_var_metadata_getUnits(this) result(units)
    implicit none
    class(t_var_metadata), intent(in) :: this
    character(len=:), allocatable :: units
    allocate(character(len(this%units)) :: units) 
    units = this%units
  end function t_var_metadata_getUnits
  
  
  function t_var_metadata_getLongName(this) result(long_name)
    implicit none
    class(t_var_metadata), intent(in) :: this
    character(len=:), allocatable :: long_name
    allocate(character(len(this%long_name)) :: long_name) 
    long_name = this%long_name
  end function t_var_metadata_getLongName
  
  
  function t_var_metadata_getDataType(this) result(datatype)
    implicit none
    class(t_var_metadata), intent(in) :: this
    integer :: datatype
    datatype = this%datatype
  end function t_var_metadata_getDataType
  
  
  function t_var_metadata_getShortName(this) result(short_name)
    implicit none
    class(t_var_metadata), intent(in) :: this
    character(len=:), allocatable :: short_name
    allocate(character(len(this%short_name)) :: short_name) 
    short_name = this%short_name
  end function t_var_metadata_getShortName
  
end module var_metadata_mod
