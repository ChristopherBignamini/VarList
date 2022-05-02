#ifdef __cplusplus

#include <string>
#include "CFICDesc.hpp"

template <typename T, typename V>
class VarCollection;

// TODO: what is the best way to manage template parameters?
typedef VarCollection<VarDescriptor,ExtendedVar> VariableCollection;

extern "C" {

    /*    struct VarCollectionItem {

        VarCollectionItem(std::string i_name, const CFICDesc* i_value_ptr)
                   :m_name(i_name)
                   ,m_value_ptr(i_value_ptr)
        {}

        std::string m_name;
        const CFICDesc* m_value_ptr;
    };
    */

    typedef VariableCollection VARCOLLECTION;

#else

    typedef struct VARCOLLECTION VARCOLLECTION;

#endif

    // ctor
    VARCOLLECTION* varcollection_create(const char* i_name);

    // dtor
    void varcollection_delete(VARCOLLECTION* i_varlist);

    // TODO: missing
    // explicit VarList(const VarList& i_var_list)

    // TODO: missing
    // VarList& operator=(const VarList& i_varlist)


    // TODO: is it possible to avoid code duplication varlist_strcfi_append, varlist_append, etc...
    void varcollection_append_h2_v0_wp(VARCOLLECTION* io_varcollection, const VarDescriptor& var_descriptor,
                                       const char* i_standard_name, const char* i_units, const char* i_long_name,
                                       const char* i_short_name, int datatype,
                                       CFI_cdesc_t* i_value);


    void varcollection_search(const VARCOLLECTION* i_varcollection, const VarDescriptor& i_variable_descriptor, CFI_cdesc_t* io_variable_values);

    unsigned int varcollection_getId(const VARCOLLECTION* i_varlist);

    void varcollection_getName(const VARCOLLECTION* i_varcollection, char* io_varcollection_name, int& io_name_length);

    unsigned int varcollection_getSize(const VARCOLLECTION* i_varcollection);


#ifdef __cplusplus
}
#endif
