#ifdef __cplusplus

template <typename T, typename V>
class VarList;

typedef VarList<int,double> VarListIntDouble;

extern "C" {


    // TODO: what is the best way to manage template parameters?
    typedef VarListIntDouble VARLIST;

#else

    typedef struct VARLIST VARLIST;

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
    void append(VARLIST* io_varlist, int i_name, double i_value);

    void varlist_finalize(VARLIST* i_varlist);

    // TODO: missing, how to we manage template and C interfacing?
    // const V* search(const T& i_variable_name) const

    unsigned int varlist_getId(const VARLIST* i_varlist);

    void varlist_getName(const VARLIST* i_varlist, char* io_varlist_name, int& io_name_length);

    unsigned int varlist_getListLength(const VARLIST* i_varlist);

    // TODO: missing, should we have a wrapper for std::pair?
    // std::pair<T,const V*> getFirstVariable(void) const

    // TODO: missing, should we have a wrapper for std::pair?
    // std::pair<T,const V*> getNextVariable(const std::pair<T,const V*>& i_current_element) const

#ifdef __cplusplus
}
#endif
