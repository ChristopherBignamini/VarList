module libvarlistitem_c
    use, intrinsic :: iso_c_binding

    private
    public :: varlist_item_c

    type, bind(C) :: varlist_item_c
        integer(c_int) :: name
        type(c_ptr) :: value_ptr
    end type varlist_item_c

end module libvarlistitem_c
