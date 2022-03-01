#ifdef __cplusplus

class VarListBase;

template <typename T, typename V>
class VarList;

template <typename T, typename V>
class VarListItem;


extern "C" {

    // TODO: what is the best way to manage template parameters?
    typedef VarList<int,double> VarListIntDouble;
    typedef VarListItem<int,double> VarListIntDoubleItem;

    typedef VarListIntDouble VARLIST;
    //typedef VarListBase VARLIST;
    typedef VarListIntDoubleItem VARLISTITEM;

#else

    typedef struct VARLIST VARLIST;
    typedef struct VARLISTITEM VARLISTITEM;

#endif

    // ctor
    VARLIST* varlist_create(const char* i_list_name);

    // dtor
    void varlist_delete(VARLIST* i_varlist);

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

    void varlist_finalize(VARLIST* i_varlist);

    // TODO: how to we manage template and C interfacing?
    const double* varlist_search(const VARLIST* i_varlist, const int& i_variable_name);

    unsigned int varlist_getId(const VARLIST* i_varlist);

    void varlist_getName(const VARLIST* i_varlist, char* io_varlist_name, int& io_name_length);

    unsigned int varlist_getListLength(const VARLIST* i_varlist);

    VARLISTITEM varlist_getFirstVariable(const VARLIST* i_varlist);

    //    VARLISTITEM varlist_getNextVariable(const VARLIST* i_varlist, int i_current_variable_key);

#ifdef __cplusplus
}
#endif
