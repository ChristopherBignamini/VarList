module libvarlistcfiitem
    use, intrinsic :: iso_c_binding
    use libvarlistcfiitem_c
    
    private
    public :: varlist_cfi_item
    
    type varlist_cfi_item
        type(varlist_cfi_item_c) :: item
    contains
        procedure :: getName => varlist_item_getName
        procedure :: getValuePtr => varlist_item_getValuePtr
    end type varlist_cfi_item

    interface varlist_cfi_item
        procedure varlist_item_create
    end interface varlist_cfi_item

contains

    function varlist_item_create(name, value_ptr)
        implicit none
        type(varlist_cfi_item) :: varlist_item_create
        character(len=*), intent(in) :: name
        type(c_ptr), intent(in):: value_ptr
        varlist_item_create%item%name = name
        varlist_item_create%item%value_ptr = value_ptr
    end function varlist_item_create

    function varlist_item_getName(this) result(name)
        use, intrinsic :: iso_c_binding
        implicit none
        character(len=1, kind=C_CHAR) :: name
        class(varlist_cfi_item), intent(in) :: this
        name = this%item%name
    end function varlist_item_getName

    function varlist_item_getValuePtr(this) result(value_ptr)
        implicit none
        type(c_ptr) :: value_ptr
        class(varlist_cfi_item), intent(in) :: this
        value_ptr = this%item%value_ptr
    end function varlist_item_getValuePtr

end module libvarlistcfiitem
