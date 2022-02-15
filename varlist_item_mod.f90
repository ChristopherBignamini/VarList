module libvarlistitem
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

    integer function varlist_item_getName(this)
        implicit none
        class(varlist_item), intent(in) :: this
        varlist_item_getName = this%item%name
    end function varlist_item_getName

    function varlist_item_getValuePtr(this) result(value_ptr)
        implicit none
        real*8, pointer :: value_ptr
        class(varlist_item), intent(in) :: this
        call c_f_pointer(this%item%value_ptr, value_ptr) 
    end function varlist_item_getValuePtr

end module libvarlistitem
