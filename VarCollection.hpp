#include <string>
#include <unordered_map>

template <typename T, typename V>
class VarCollection {

public:

    // TODO: add exception handling
    // TODO: add check (with traits) on ContainerType, with original var list requirements
    // TODO: the varlist example int icon-kernels uses an array of var list, define a container for VarCollection

    VarCollection(std::string i_list_name)
        :m_list_id(getGlobalId())
        ,m_list_name(i_list_name)
    {
    }

    // TODO: define copy/move ctors behaviour
    explicit VarCollection(const VarCollection& i_var_list)
        :m_list(i_var_list.m_list)
        ,m_list_id(getGlobalId())
        ,m_list_name(i_var_list.m_list_name)
    {
    }

    VarCollection& operator=(const VarCollection& i_var_list)
    {
        m_list = i_var_list.m_list;
        m_list_name = i_var_list.m_list_name;

        return *this;
    }

    void append(const T& i_new_variable_name, const V& i_new_variable_value)
    {
        m_list.insert({i_new_variable_name, i_new_variable_value});
    }

    void finalize(void)
    {
        m_list.clear();
    }

    // TODO: is key-based search the only one we need?
    // TODO: do not forget that unordered map ordering can change, do we really need a ptr???
    const V* search(const T& i_variable_key) const
    {
        typename std::unordered_map<T,V>::const_iterator item = m_list.find(i_variable_key);
        if(item != m_list.end())
            return &(item->second);
        else
            return NULL;
    }

    unsigned int getId(void) const
    {
        return m_list_id;
    }

    std::string getName(void) const
    {
        return m_list_name;
    }

    unsigned int getSize(void) const
    {
        return m_list.size();
    }

    /*
    // TODO: do not forget that unordered map ordering can change!
    std::pair<T,const V*> getFirstVariable(void) const
    {
        // begin is available in all stl containers
        std::pair<T,const V*> first_variable(m_list.begin()->first, &(m_list.begin()->second));
        return first_variable;
    }

    // TODO: do not forget that unordered map ordering can change!
    // TODO: why do we need this method?
    std::pair<T,const V*> getNextVariable(const T& i_current_element_key) const
    {
        typename std::unordered_map<T,V>::const_iterator item = m_list.find(i_current_element_key);
        item++;
        if(item != m_list.end())
            return std::pair<T,const V*>(item->first, &(item->second));
        else
            return std::pair<T,const V*>(item->first, NULL);
            }*/

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
