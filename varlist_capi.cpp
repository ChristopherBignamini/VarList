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

unsigned int varlist_strcfi_getListLength(const VARLISTSTRCFI* i_varlist)
{
    return i_varlist->getListLength();
}

VARLISTITEM varlist_getFirstVariable(const VARLIST* i_varlist)
{
    // TODO: add safety checks
    std::pair<int,const double*> first_variable(i_varlist->getFirstVariable());
    return VARLISTITEM(first_variable.first, first_variable.second);
}

/*VARLISTCFIITEM varlist_strcfi_getFirstVariable(const VARLISTSTRCFI* i_varlist)
{
    // TODO: add safety checks
    std::cout<<"varlist_strcfi_getFirstVariable"<<std::endl;
    i_varlist->getFirstVariable();
    std::cout<<"varlist_strcfi_getFirstVariable"<<std::endl;
    std::cout<<i_varlist->getFirstVariable().first<<std::endl;
    std::pair<std::string,const CFICDesc*> first_variable(i_varlist->getFirstVariable());
    return VARLISTCFIITEM(first_variable.first, first_variable.second);
    }*/

void varlist_strcfi_getFirstVariable(const VARLISTSTRCFI* i_varlist, VARLISTCFIITEM* io_varlist_item)
{
    // TODO: add safety checks
    std::pair<std::string,const CFICDesc*> first_variable(i_varlist->getFirstVariable());
    std::cout<<"HERE"<<std::endl;
    io_varlist_item->m_name = first_variable.first;
    io_varlist_item->m_value_ptr = first_variable.second;
    std::cout<<"HERE"<<std::endl;
    //    return VARLISTCFIITEM(first_variable.first, first_variable.second);
}

VARLISTITEM varlist_getNextVariable(const VARLIST* i_varlist, int i_current_variable_key)
{
    // TODO: add safety checks
    std::pair<int,const double*> next_variable(i_varlist->getNextVariable(i_current_variable_key));
    return VARLISTITEM(next_variable.first, next_variable.second);
}
