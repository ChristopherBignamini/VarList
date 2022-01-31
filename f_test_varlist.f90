program test_varlist
    use varlist
    implicit none
    type(cpp_varlist) :: f_varlist

    f_varlist = cpp_varlist("test varlist")
    write(*,*) f_varlist%getId()

#ifdef __GNUC__
    call f_varlist%delete
#endif
end program
