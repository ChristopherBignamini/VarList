#include "varcollection.h"
#include "VarCollection.hpp"
#include "CFICDesc.hpp"
#include <ISO_Fortran_binding.h>
#include <string>
#include <cstring>

//TODO: delete
#include <iostream>
#include <stdio.h>

// ctor
VARCOLLECTION* varcollection_create(const char* i_name)
{
    return new VarCollection<VarDescriptor,ExtendedVar>(std::string(i_name));
}

// dtor
void varcollection_delete(VARCOLLECTION* i_varcollection)
{
    delete i_varcollection;
}


void varcollection_append_h2_v0_wp(VARCOLLECTION* io_varcollection, const VarDescriptor& i_var_descriptor,
                                   const char* i_standard_name, const char* i_units, const char* i_long_name,
                                   const char* i_short_name, int i_datatype,
                                   CFI_cdesc_t* i_value)
{
    io_varcollection->append(i_var_descriptor, i_standard_name, i_units, i_long_name,
                             i_short_name, i_datatype, CFICDesc(*i_value));
}


// TODO: how do we check compatibility between return type and fortran type in the calling function
void varcollection_search(const VARCOLLECTION* i_varcollection, const VarDescriptor& i_variable_descriptor, CFI_cdesc_t* io_variable)
{
    (i_varcollection->search(i_variable_descriptor))->extractCFI_cdesc_t(*io_variable);
}

unsigned int varcollection_getId(const VARCOLLECTION* i_varcollection)
{
    return i_varcollection->getId();
}


// TODO: Safer implementation needed!
// Signature is different wrt VarList class method to force
// memory management responsability awarness :). The user is
// responsible for memory allocation/deallocation!
void varcollection_getName(const VARCOLLECTION* i_varcollection, char* io_varcollection_name, int& io_name_length)
{
    // TODO: check io_varlist_name validity
    const std::string varcollection_name(i_varcollection->getName());
    io_name_length = varcollection_name.length();
    std::strcpy(io_varcollection_name, varcollection_name.c_str());
}

unsigned int varcollection_getSize(const VARCOLLECTION* i_varcollection)
{
    return i_varcollection->getSize();
}
