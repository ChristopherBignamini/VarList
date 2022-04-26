#include "metadata.h"
#include "Metadata.hpp"

METADATACF* metadatacf_create(void)
{
    return new MetadataCF();
}

void metadatacf_setStandardName(METADATACF* io_metadata_cf, const char* i_standard_name)
{
    return;
}

void metadatacf_getStandardName(const METADATACF* io_metadata_cf, char* io_standard_name, int& io_name_length)
{
    return;
}
