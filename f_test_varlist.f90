program test_varlist
    use libvarlist
    implicit none
    type(varlist) :: f_varlist1, f_varlist2

    f_varlist1 = varlist("test varlist 1")
    write(*,*) f_varlist1%getId()

    f_varlist2 = varlist("test varlist 2")
    write(*,*) f_varlist2%getId()

#ifdef __GNUC__
    call f_varlist1%delete
    call f_varlist2%delete
#endif
end program
