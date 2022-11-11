#ifdef __cplusplus

#include <string>
#include "CFICDesc.hpp"

template <typename T, typename V>
class VarList;

// TODO: what is the best way to manage template parameters?
typedef VarList<int,double> VarListIntDouble;
typedef VarList<std::string,CFICDesc> VarListStringCFI;


extern "C" {

    struct VarListItem {

        VarListItem(int i_name, const double* i_value_ptr)
                   :m_name(i_name)
                   ,m_value_ptr(i_value_ptr)
        {}

        int m_name;
        const double* m_value_ptr;
    };

    struct VarListCFIItem {

        VarListCFIItem(std::string i_name, const CFICDesc* i_value_ptr)
                   :m_name(i_name)
                   ,m_value_ptr(i_value_ptr)
        {}

        std::string m_name;
        const CFICDesc* m_value_ptr;
    };


    typedef VarListItem VARLISTITEM;
    typedef VarListIntDouble VARLIST;
    typedef VarListStringCFI VARLISTSTRCFI;

#else

    typedef struct VARLISTITEM VARLISTITEM;
    typedef struct VARLIST VARLIST;
    typedef struct VARLISTSTRCFI VARLISTSTRCFI;

#endif

    // ctor
    VARLIST* varlist_create(const char* i_list_name);

    // ctor
    VARLISTSTRCFI* varlist_strcfi_create(const char* i_list_name);

    // dtor
    void varlist_delete(VARLIST* i_varlist);

    // dtor
    void varlist_strcfi_delete(VARLISTSTRCFI* i_varlist);

    // TODO: missing
    // explicit VarList(const VarList& i_var_list)

    // TODO: missing
    // VarList& operator=(const VarList& i_varlist)

    /**
     * Append new variable to the list
     *
     * @param io_varlist The VarList instance to be modified
     * @param name Variable name (integer, string, etc...)
     * @param value Variable value
     */
    // TODO: use generic variable_type
    void varlist_append(VARLIST* io_varlist, int i_name, double i_value);

    // TODO: is it possible to avoid code duplication varlist_strcfi_append, varlist_append, etc...
    void varlist_strcfi_append(VARLISTSTRCFI* io_varlist, const char* i_name, CFI_cdesc_t* i_value);

    // TODO: fix design and signature
    //    void varlist_addMetadata(VARLISTSTRCFI* io_varlist, const char* i_name, const char* i_standard_name,
    //                         const char* i_units, const char* i_long_name, int i_datatype, const char* i_short_name);

    void varlist_finalize(VARLIST* i_varlist);

    // TODO: how to we manage template and C interfacing?
    const double* varlist_search(const VARLIST* i_varlist, const int& i_variable_name);

    void varlist_strcfi_search(const VARLISTSTRCFI* i_varlist, const char* i_variable_name, CFI_cdesc_t* io_variable);

    unsigned int varlist_getId(const VARLIST* i_varlist);

    unsigned int varlist_strcfi_getId(const VARLISTSTRCFI* i_varlist);

    void varlist_getName(const VARLIST* i_varlist, char* io_varlist_name, int& io_name_length);

    void varlist_strcfi_getName(const VARLISTSTRCFI* i_varlist, char* io_varlist_name, int& io_name_length);

    unsigned int varlist_getListLength(const VARLIST* i_varlist);

    VARLISTITEM varlist_getFirstVariable(const VARLIST* i_varlist);

    VARLISTITEM varlist_getNextVariable(const VARLIST* i_varlist, int i_current_variable_key);

#ifdef __cplusplus
}
#endif
