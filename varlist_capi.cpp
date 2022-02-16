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

void varlist_append(VARLIST* io_varlist, int i_name, double i_value)
{
    io_varlist->append(std::unordered_map<int,double>::value_type(i_name, i_value));
}

void varlist_finalize(VARLIST* io_varlist)
{
    io_varlist->finalize();
}

// TODO: how to we manage template and C interfacing?
const double* varlist_search(const VARLIST* i_varlist, const int& i_variable_name)
{
    return i_varlist->search(i_variable_name);
}

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

//std::pair<T,const V*> getFirstVariable(const VARLIST* i_varlist) const
VARLISTITEM varlist_getFirstVariable(const VARLIST* i_varlist)
{
    // TODO: add safety checks
    std::pair<int,const double*> first_variable(i_varlist->getFirstVariable());
    return VARLISTITEM(first_variable.first, first_variable.second);
}

// std::pair<T,const V*> getNextVariable(const std::pair<T,const V*>& i_current_element)
VARLISTITEM varlist_getNextVariable(const VARLIST* i_varlist, int i_current_variable_key)
{
    // TODO: add safety checks
    std::pair<int,const double*> next_variable(i_varlist->getNextVariable(i_current_variable_key));
    return VARLISTITEM(next_variable.first, next_variable.second);
}
