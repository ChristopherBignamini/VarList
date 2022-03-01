#include <string>
#include <memory>
#include "VarList.hpp"

class VarListInterface {

public:


    VarListInterface(std::string i_list_name)
        :m_id(getGlobalId())
        ,m_list_name(i_list_name)
    {
    }

    // TODO: define copy/move ctors behaviour
    explicit VarListInterface(const VarListInterface& i_var_list_interface)
        :m_data(i_var_list_interface.m_data)
        ,m_id(getGlobalId())
        ,m_list_name(i_var_list_interface.m_list_name)
    {
    }

    VarListInterface& operator=(const VarListInterface& i_var_list_interface)
    {
        m_data = i_var_list_interface.m_data;
        m_list_name = i_var_list_interface.m_list_name;

        return *this;
    }

    void append(auto i_var_list_item)
    {
        typedef decltype(i_var_list_item) var_list_item_type;
        //typedef VarList<int,double> var_list_item_type;
        typedef typename var_list_item_type::name_type name_type;
        typedef typename var_list_item_type::value_type value_type;

        if(!m_data) {
            m_data = std::shared_ptr< VarList<name_type, value_type> >(new VarList<name_type, value_type>(m_list_name));
        }
        m_data->append(i_var_list_item);
    }

    void append(auto i_variable_name, auto i_variable_value)
    {
        typedef decltype(i_variable_name) name_type;
        typedef decltype(i_variable_value) value_type;

        if(!m_data) {
            m_data = std::shared_ptr< VarList<name_type, value_type> >(new VarList<name_type, value_type>(m_list_name));
        }
        m_data->append(VarListItem<name_type, value_type>(i_variable_name,i_variable_value));
    }


    void finalize(void)
    {
        m_data->finalize();
    }

    unsigned int getId(void) const
    {
        return m_id;
    }

    std::string getName(void) const
    {
        return m_list_name;
    }

    unsigned int getLength(void) const
    {
        return m_data->getListLength();
    }


private:

    // TODO: smart or standard pointer?
    std::shared_ptr<VarListBase> m_data;

    const unsigned int m_id;

    std::string m_list_name;

    // TODO: this ID is template specialization specific, do we need a global one?
    // TODO: not thread safe
    static unsigned int getGlobalId(void)
    {
       static unsigned int global_list_id = 0;
       return global_list_id++;
    }

};
