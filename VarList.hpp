#include <string>

template <typename ContainerType>
class VarList {

public:

    // TODO: missing methods
    // finalize
    // append
    // search

    // TODO: add check (with traits) on ContainerType, with original var list requirements

    // TODO: the varlist example int icon-kernels uses an arrai of var list, define a container for VarList


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

    unsigned int getId(void) const
    {
        return m_list_id;
    }

    std::string getName(void) const
    {
        return m_list_name;
    }

    const typename ContainerType::value_type& getFirstVariable(void) const
    {
        return *m_list.begin(); // begin is available in all stl containers
    }

    const typename ContainerType::value_type& getNextVariable(void) const;

private:

    ContainerType m_list;

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

