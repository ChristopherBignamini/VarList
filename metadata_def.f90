interface
   function metadata_cf_create_c() bind(C, name="metadatacf_create")
     use, intrinsic :: iso_c_binding
     implicit none
     type(c_ptr) :: metadata_cf_create_c
   end function metadata_cf_create_c

   subroutine metadata_setStandardName_c(metadata_cf, standard_name) bind(C, name="metadatacf_setStandardName")
     use, intrinsic :: iso_c_binding
     implicit none
     type(c_ptr), value :: metadata_cf
     character(len=1, kind=C_CHAR), intent(in) :: standard_name(*)
   end subroutine metadata_setStandardName_c

   subroutine metadata_getStandardName_c(metadata_cf, standard_name, standard_name_length) &
        bind(C, name="metadatacf_getStandardName")
     ! TODO: I'm not sure of signature and implementation
     use, intrinsic :: iso_c_binding
     implicit none
     character(len=1, kind=C_CHAR) :: standard_name
     integer(c_int) :: standard_name_length
     type(c_ptr), intent(in), value :: metadata_cf
   end subroutine metadata_getStandardName_c

end interface
