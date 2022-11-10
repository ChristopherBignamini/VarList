module libscalarpointer
  use, intrinsic :: iso_c_binding

  private
  public :: scalarpointer

  type, bind(C) :: scalarpointer
     !        public
        type(c_ptr) :: scalar_p
  end type scalarpointer

end module libscalarpointer
