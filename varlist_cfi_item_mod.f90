module libvarlistcfiitem
    use, intrinsic :: iso_c_binding
    use libvarlistitem_c
    
    private
    public :: varlist_item
    
    type varlist_item
        type(varlist_item_c) :: item
    contains
        procedure :: getName => varlist_item_getName
        procedure :: getValuePtr => varlist_item_getValuePtr
    end type varlist_item

    interface varlist_item
        procedure varlist_item_create
    end interface varlist_item

contains

    function varlist_item_create(name, value_ptr)
        implicit none
        type(varlist_item) :: varlist_item_create
        integer, intent(in) :: name
        type(c_ptr), intent(in) :: value_ptr
        varlist_item_create%item%name = name
        varlist_item_create%item%value_ptr = value_ptr
    end function varlist_item_create

    function varlist_item_getName(this) result(name)
        use, intrinsic :: iso_c_binding
        implicit none
        integer(c_int) :: name
        class(varlist_item), intent(in) :: this
        name = this%item%name
    end function varlist_item_getName

    function varlist_item_getValuePtr(this) result(value_ptr)
        implicit none
        type(c_ptr) :: value_ptr
        class(varlist_item), intent(in) :: this
        value_ptr = this%item%value_ptr
    end function varlist_item_getValuePtr

end module libvarlistcfiitem
