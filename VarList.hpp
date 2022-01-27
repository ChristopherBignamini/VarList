#include <string>
#include <unordered_map>

template <typename T, typename V>
class VarList {

public:

    // TODO: missing methods
    // finalize
    // append
    // search

    // TODO: add check (with traits) on ContainerType, with original var list requirements

    // TODO: the varlist example int icon-kernels uses an array of var list, define a container for VarList


    VarList(std::string i_list_name)
        :m_list_id(getGlobalId())
        ,m_list_name(i_list_name)
    {
    }

    // TODO: define copy/move ctors behaviour
    explicit VarList(const VarList& i_var_list)
        :m_list(i_var_list.m_list)
        ,m_list_id(getGlobalId())
        ,m_list_name(i_var_list.m_list_name)
    {
    }

    VarList& operator=(const VarList& i_var_list)
    {
        m_list = i_var_list.m_list;
        m_list_name = i_var_list.m_list_name;

        return *this;
    }

    //    void append(const typename ContainerType<T>::value_type& i_new_variable);
    void append(const typename std::unordered_map<T,V>::value_type& i_new_variable)
    {
        m_list.insert(i_new_variable);
    }

    unsigned int getId(void) const
    {
        return m_list_id;
    }

    std::string getName(void) const
    {
        return m_list_name;
    }

    T const * getFirstVariable(void) const
    {
        return &(*m_list.begin()); // begin is available in all stl containers
    }

    T const * getNextVariable(T const * i_current_element) const
    {
        if(i_current_element){
            // Find iterator position for the input element (ugly, possibly buggy)
            // TODO: if correct switch to algorithm
            for(typename std::unordered_map<T,V>::iterator it = m_list.begin(); it<m_list.end(); ++it) {
                if(std::addressof(*it) == i_current_element) {
                    return &(*(it.next()));
                }
            }
        }
        return NULL;
    }

private:

    std::unordered_map<T,V> m_list;

    const unsigned int m_list_id;

    std::string m_list_name;

    // TODO: this ID is template specialization specific, do we need a global one?
    // TODO: not thread safe
    static unsigned int getGlobalId(void)
    {
       static unsigned int global_list_id = 0;
       return global_list_id++;
    }

};
