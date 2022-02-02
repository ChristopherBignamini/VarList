#include "varlist.h"
#include "VarList.hpp"
#include <string>
#include <cstring>

// ctor
VARLIST* varlist_create(const char* i_list_name)
{
    // TODO: how do we deal with template pars??
    return new VarList<int,double>(std::string(i_list_name));
}

// dtor
void varlist_delete(VARLIST* i_varlist)
{
    delete i_varlist;
}

// TODO: missing
// VarList& operator=(const VarList& i_varlist)

// TODO: missing
// void append(const typename std::unordered_map<T,V>::value_type& i_new_variable)

void varlist_finalize(VARLIST* io_varlist)
{
    io_varlist->finalize();
}


// TODO: missing, how to we manage template and C interfacing?
// const V* search(const T& i_variable_name) const

unsigned int varlist_getId(const VARLIST* i_varlist)
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

unsigned int varlist_getListLength(const VARLIST* i_varlist)
{
    return i_varlist->getListLength();
}

// TODO: missing, should we have a wrapper for std::pair?
// std::pair<T,const V*> getFirstVariable(void) const

// TODO: missing, should we have a wrapper for std::pair?
// std::pair<T,const V*> getNextVariable(const std::pair<T,const V*>& i_current_element) const
