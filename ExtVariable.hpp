#include "Metadata.hpp"
#include "CFICDesc.hpp"

struct ExtendedVar {

    Metadata m_meta_data;
    CFICDesc m_data_values;

    void extractCFI_cdesc_t(CFI_cdesc_t& io) { m_data_values.copyToCFI_cdesc_t(io_cfi_cdesc); }

};
