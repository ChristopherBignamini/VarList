#ifdef __cplusplus

#include <string>
#include "CFICDesc.hpp"

template <typename T, typename V>
class VarList;

// TODO: what is the best way to manage template parameters?
typedef VarList<std::string,CFICDesc> VarListStringCFI;


extern "C" {

    struct VarListCFIItem {

        VarListCFIItem(std::string i_name, const CFICDesc* i_value_ptr)
                   :m_name(i_name)
                   ,m_value_ptr(i_value_ptr)
        {}

        std::string m_name;
        const CFICDesc* m_value_ptr;
    };


    typedef VarListStringCFI VARLISTSTRCFI;

#else

    typedef struct VARLISTSTRCFI VARLISTSTRCFI;

#endif


    // ctor
    VARLISTSTRCFI* varlist_strcfi_create(const char* i_list_name);


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
    // TODO: is it possible to avoid code duplication varlist_strcfi_append, varlist_append, etc...
    void varlist_strcfi_append(VARLISTSTRCFI* io_varlist, const char* i_name, CFI_cdesc_t* i_value);

    void varlist_strcfi_search(const VARLISTSTRCFI* i_varlist, const char* i_variable_name, CFI_cdesc_t* io_variable);

    unsigned int varlist_strcfi_getId(const VARLISTSTRCFI* i_varlist);

    void varlist_strcfi_getName(const VARLISTSTRCFI* i_varlist, char* io_varlist_name, int& io_name_length);

    unsigned int varlist_getListLength(const VARLISTSTRCFI* i_varlist);

#ifdef __cplusplus
}
#endif
