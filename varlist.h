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

    // TODO: missing
    // void append(const typename std::unordered_map<T,V>::value_type& i_new_variable)

    void varlist_finalize(VARLIST* i_varlist);

    // TODO: missing, how to we manage template and C interfacing?
    // const V* search(const T& i_variable_name) const

    unsigned int varlist_getId(const VARLIST* i_varlist);

    const char* varlist_getName(const VARLIST* i_varlist);

    unsigned int varlist_getListLength(const VARLIST* i_varlist);

    // TODO: missing, should we have a wrapper for std::pair?
    // std::pair<T,const V*> getFirstVariable(void) const

    // TODO: missing, should we have a wrapper for std::pair?
    // std::pair<T,const V*> getNextVariable(const std::pair<T,const V*>& i_current_element) const

#ifdef __cplusplus
}
#endif
