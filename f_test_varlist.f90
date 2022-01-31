program test_varlist
    use libvarlist
    implicit none
    type(varlist) :: f_varlist

    f_varlist = varlist("test varlist")
    write(*,*) f_varlist%getId()

#ifdef __GNUC__
    call f_varlist%delete
#endif
end program
