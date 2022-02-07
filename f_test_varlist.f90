program test_varlist
    use libvarlist
    implicit none
    type(varlist) :: f_varlist1, f_varlist2
    real*8, pointer :: val_ptr

    f_varlist1 = varlist("test varlist1")
    print*, f_varlist1%getId()
    print*, f_varlist1%getName()

    f_varlist2 = varlist("test varlist2")
    print*, f_varlist2%getId()
    print*, f_varlist2%getName()
    call f_varlist2%append(1,1.1D0)
    val_ptr => f_varlist2%search(1)
    if (associated(val_ptr)) print*, val_ptr

    
#ifdef __GNUC__
    call f_varlist1%delete
    call f_varlist2%delete
#endif
end program
