#include "CFICDesc.hpp"
#include <cstdlib>
#include <ISO_Fortran_binding.h>

CFICDesc::CFICDesc(const CFI_cdesc_t& i_cdesc_t)
    :m_base_addr(i_cdesc_t.base_addr)
    ,m_elem_len(i_cdesc_t.elem_len)
    ,m_version(i_cdesc_t.version)
    ,m_rank(i_cdesc_t.rank)
    ,m_attribute(i_cdesc_t.attribute)
    ,m_type(i_cdesc_t.type)
{
    for(auto i=0; i<m_rank; i++) {
        m_dim.push_back(CFI_dim_t{i_cdesc_t.dim[i].lower_bound, i_cdesc_t.dim[i].extent, i_cdesc_t.dim[i].sm});
    }
}

void CFICDesc::copyToCFI_cdesc_t(CFI_cdesc_t& io) {

    io.base_addr = m_base_addr;
    io.elem_len = m_elem_len;
    io.version = m_version;
    io.rank = m_rank;
    io.attribute = m_attribute;
    io.type = m_type;

    // TODO: here I assume that the passed CFI_cdesc_t reference is already completely allocated
    // and compatible "this" rank
    //    if(io.dim != NULL) {
    //        free(io.dim);
    //    }
    //    io.dim = new CFI_dim_t[io.rank];

    for(auto i=0; i<m_rank; i++) {
        io.dim[i] = {m_dim[i].lower_bound, m_dim[i].extent, m_dim[i].sm};
    }

}
