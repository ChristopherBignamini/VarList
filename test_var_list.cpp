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

}
