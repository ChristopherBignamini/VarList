#ifdef __cplusplus

class MetadataCF;

extern "C" {

    typedef MetadataCF METADATACF;

#else

    typedef METADATACF METADATACF;

#endif

    // ctor
    METADATACF* metadatacf_create(void);

    void metadatacf_setStandardName(METADATACF* io_metadata_cf, const char* i_standard_name);

    void metadatacf_getStandardName(const METADATACF* io_metadata_cf, char* io_standard_name, int& io_name_length);

#ifdef __cplusplus
}
#endif
