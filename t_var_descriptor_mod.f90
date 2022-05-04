module var_descriptor_mod
  implicit none

  private
  public :: t_var_descriptor

  type t_var_descriptor
     character(:), allocatable :: name      !< ICON-internal short name
     integer :: jg        !< logical patch ID
     integer :: hgridID   !< cell/vertex/edge/lat-lon/...
     integer :: vgridID   !< vertical grid ID
     integer :: timeID    !< distinguishes nnow/nnew
  end type t_var_descriptor

  interface t_var_descriptor
     procedure t_var_descriptor_create
  end interface t_var_descriptor
  
contains

  function t_var_descriptor_create(i_name, i_jg, i_hgridID, i_vgridID, i_timeID) result(var_descriptor)
     implicit none
     type(t_var_descriptor) :: var_descriptor
     character(:),allocatable :: i_name      !< ICON-internal short name
     integer :: i_jg        !< logical patch ID
     integer :: i_hgridID   !< cell/vertex/edge/lat-lon/...
     integer :: i_vgridID   !< vertical grid ID
     integer :: i_timeID    !< distinguishes nnow/nnew
     var_descriptor%name = i_name
     var_descriptor%jg = i_jg
     var_descriptor%hgridID = i_hgridID
     var_descriptor%vgridID = i_vgridID
     var_descriptor%timeId = i_timeID
  end function t_var_descriptor_create
  
end module var_descriptor_mod
