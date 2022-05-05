#include "varlist.h"
#include "VarList.hpp"
#include "CFICDesc.hpp"
#include <ISO_Fortran_binding.h>
#include <string>
#include <cstring>

//TODO: delete
#include <iostream>
#include <stdio.h>

// ctor
VARLISTSTRCFI* varlist_strcfi_create(const char* i_list_name)
{
    return new VarList<std::string,CFICDesc>(std::string(i_list_name));
}

// dtor
void varlist_strcfi_delete(VARLISTSTRCFI* i_varlist)
{
    delete i_varlist;
}

void varlist_strcfi_append(VARLISTSTRCFI* io_varlist, const char* i_name, CFI_cdesc_t* i_value)
{
    io_varlist->append(i_name, CFICDesc(*i_value));
}

// TODO: how to we manage template and C interfacing?
void varlist_strcfi_search(const VARLISTSTRCFI* i_varlist, const char* i_variable_name, CFI_cdesc_t* io_variable)
{
    (i_varlist->search(std::string(i_variable_name)))->copyToCFI_cdesc_t(*io_variable);
}

unsigned int varlist_strcfi_getId(const VARLISTSTRCFI* i_varlist)
{
    return i_varlist->getId();
}

// TODO: Safer implementation needed!
// Signature is different wrt VarList class method to force
// memory management responsability awarness :). The user is
// responsible for memory allocation/deallocation!
void varlist_strcfi_getName(const VARLISTSTRCFI* i_varlist, char* io_varlist_name, int& io_name_length)
{
    // TODO: check io_varlist_name validity
    const std::string varlist_name(i_varlist->getName());
    io_name_length = varlist_name.length();
    std::strcpy(io_varlist_name, varlist_name.c_str());
}

unsigned int varlist_getListLength(const VARLISTSTRCFI* i_varlist)
{
    return i_varlist->getListLength();
}
