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
VARLIST* varlist_create(const char* i_list_name)
{
    // TODO: how do we deal with template pars??
    return new VarList<int,double>(std::string(i_list_name));
}

// ctor
VARLISTSTRCFI* varlist_strcfi_create(const char* i_list_name)
{
    return new VarList<std::string,CFICDesc>(std::string(i_list_name));
}

// dtor
void varlist_delete(VARLIST* i_varlist)
{
    delete i_varlist;
}

// dtor
void varlist_strcfi_delete(VARLISTSTRCFI* i_varlist)
{
    delete i_varlist;
}

// TODO: missing
// VarList& operator=(const VarList& i_varlist)
void varlist_append(VARLIST* io_varlist, int i_name, double i_value)
{
    io_varlist->append(i_name, i_value);
}

void varlist_strcfi_append(VARLISTSTRCFI* io_varlist, const char* i_name, CFI_cdesc_t* i_value)
{
    io_varlist->append(i_name, CFICDesc(*i_value));
}

void varlist_finalize(VARLIST* io_varlist)
{
    io_varlist->finalize();
}

void varlist_finalize(VARLISTSTRCFI* io_varlist)
{
    io_varlist->finalize();
}

// TODO: how to we manage template and C interfacing?
const double* varlist_search(const VARLIST* i_varlist, const int& i_variable_name)
{
    return i_varlist->search(i_variable_name);
}

// TODO: how to we manage template and C interfacing?
void varlist_strcfi_search(const VARLISTSTRCFI* i_varlist, const char* i_variable_name, CFI_cdesc_t* io_variable)
{
    (i_varlist->search(std::string(i_variable_name)))->copyToCFI_cdesc_t(*io_variable);
}

// TODO: debug and delete
void varlist_strcfi_accessArray(const VARLISTSTRCFI* i_varlist, CFI_cdesc_t* io_variable)
{
    std::cout<<"in varlist_strcfi_accessArray"<<std::endl;
    std::cout<<"Base address "<<io_variable->base_addr<<std::endl;
    printf("Input rank  %d\n", io_variable->rank);
    for(int i=0; i<io_variable->dim[0].extent; i++){
        CFI_index_t subscript[1] = {i};
        double data_value = *((double *) CFI_address(io_variable, subscript));
        printf("Element %d value: %f\n", i, data_value);
    }
}

unsigned int varlist_getId(const VARLIST* i_varlist)
{
    return i_varlist->getId();
}

unsigned int varlist_strcfi_getId(const VARLISTSTRCFI* i_varlist)
{
    return i_varlist->getId();
}

// TODO: Safer implementation needed!
// Signature is different wrt VarList class method to force
// memory management responsability awarness :). The user is
// responsible for memory allocation/deallocation!
void varlist_getName(const VARLIST* i_varlist, char* io_varlist_name, int& io_name_length)
{
    // TODO: check io_varlist_name validity
    const std::string varlist_name(i_varlist->getName());
    io_name_length = varlist_name.length();
    std::strcpy(io_varlist_name, varlist_name.c_str());
}

void varlist_strcfi_getName(const VARLISTSTRCFI* i_varlist, char* io_varlist_name, int& io_name_length)
{
    // TODO: check io_varlist_name validity
    const std::string varlist_name(i_varlist->getName());
    io_name_length = varlist_name.length();
    std::strcpy(io_varlist_name, varlist_name.c_str());
}

unsigned int varlist_getListLength(const VARLIST* i_varlist)
{
    return i_varlist->getListLength();
}

VARLISTITEM varlist_getFirstVariable(const VARLIST* i_varlist)
{
    // TODO: add safety checks
    std::pair<int,const double*> first_variable(i_varlist->getFirstVariable());
    return VARLISTITEM(first_variable.first, first_variable.second);
}

VARLISTITEM varlist_getNextVariable(const VARLIST* i_varlist, int i_current_variable_key)
{
    // TODO: add safety checks
    std::pair<int,const double*> next_variable(i_varlist->getNextVariable(i_current_variable_key));
    return VARLISTITEM(next_variable.first, next_variable.second);
}
