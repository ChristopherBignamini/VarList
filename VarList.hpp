#include <string>

template <typename ContainerType>
class VarList {

public:

    VarList(std::string i_list_name): m_list_id(getGlobalId()), m_list_name(i_list_name)
    {
    }

    const unsigned int getListId(void)
    {
        return m_list_id;
    }

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
