#include <string>
#include <variant>
#include <unordered_map>

/**
 * MetadataBase
 *
 * TODO: add documentation
 */
class MetadataBase {};

/**
 * MetadataCF
 *
 * TODO: add documentation
 */
class MetadataCF : public MetadataBase {

public:

    // TODO: check interface
    std::string m_standard_name;
    std::string m_units;
    std::string m_long_name;
    int m_datatype;
    std::string m_short_name;

};

/**
 * MetadataGRIB2
 *
 * TODO: add documentation
 */
/*
class MetadataGRIB2 : public MetadataBase {

public:

    MetadataGRIB2(int i_discipline, int i_category, int i_parameter)
        :m_discipline(i_discipline)
        ,m_category(i_category)
        ,m_parameter(i_parameter)
    {}

private:

    int m_discipline;
    int m_category;
    int m_parameter;
    int m_bits;
    int m_grid;
    int m_subgrid;
    std::unordered_map<std::string, std::variant<int, double>> m_extra_grib2_keys;

};
*/
