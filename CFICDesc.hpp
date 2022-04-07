#ifndef CFICDESC_HPP
#define CFICDESC_HPP

#include <ISO_Fortran_binding.h>
#include <vector>

/**
 * Copy of the CFI_cdesc_t struct
 *
 * I am temporarily using this structure because a deep copy is needed
 * when a new CFI_cdesct_t objects is stored in VarList.hpp unordered map.
 * The original C struct contains a raw array that is replicated here with
 * a vector.
 *
 * TODO: find a better procedure for insert/deep copy
 */
struct CFICDesc {

    CFICDesc(const CFI_cdesc_t& i_cdesc_t);

    // TODO: check design
    // TODO: can copy be avoided?
    void copyToCFI_cdesc_t(CFI_cdesc_t& io);

    //TODO private:
    void *m_base_addr;
    size_t m_elem_len;
    int m_version;
    CFI_rank_t m_rank;
    CFI_attribute_t m_attribute;
    CFI_type_t m_type;
    std::vector<CFI_dim_t> m_dim;
};

#endif
