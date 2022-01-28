#include "VarList.hpp"
#include <iostream>

#include <unordered_map>

int main() {

    VarList<int, double> i_d_var_list_1("my_first_int_double_varlist");
    std::cout<<i_d_var_list_1.getId()<<std::endl;

    VarList<int, double> i_d_var_list_2("my_second_int_double_varlist");
    std::cout<<i_d_var_list_2.getId()<<std::endl;

    VarList<char, double> c_d_var_list_1("my_firs_char_double_varlist");
    std::cout<<c_d_var_list_1.getId()<<std::endl;

    VarList<char, double> c_d_var_list_2(c_d_var_list_1);
    std::cout<<c_d_var_list_2.getId()<<std::endl;

    c_d_var_list_2.append(std::make_pair('c',23.23));
    c_d_var_list_2.append(std::make_pair('d',46.46));

    auto const * var = c_d_var_list_2.search('c');
    std::cout<<*var<<std::endl;

    auto first_variable = c_d_var_list_2.getFirstVariable();
    std::cout<<first_variable.first<<" "<<*(first_variable.second)<<std::endl;

    auto previous_variable = first_variable;
    for(auto i=1;i<c_d_var_list_2.getListLength();i++) {
      auto next_variable = c_d_var_list_2.getNextVariable(previous_variable);
      std::cout<<next_variable.first<<" "<<*(next_variable.second)<<std::endl;
      previous_variable = next_variable;
    }

    c_d_var_list_2.finalize();
    std::cout<<c_d_var_list_2.getListLength()<<std::endl;

}
