#include "CFICDesc.hpp"
#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <ISO_Fortran_binding.h>


CFICDesc::CFICDesc(const CFI_cdesc_t& i_cdesc_t)
    :m_base_addr(i_cdesc_t.base_addr)
    ,m_elem_len(i_cdesc_t.elem_len)
    ,m_version(i_cdesc_t.version)
    ,m_rank(i_cdesc_t.rank)
    ,m_attribute(i_cdesc_t.attribute)
    ,m_type(i_cdesc_t.type)
{
    // TODO: by default dim[i].lower_bound is 0 even if the corresponding fortran array has lbound = 1
    for(auto i=0; i<m_rank; i++) {
        m_dim.push_back(CFI_dim_t{i_cdesc_t.dim[i].lower_bound+1, i_cdesc_t.dim[i].extent, i_cdesc_t.dim[i].sm});
    }
}


 /*CFICDesc::CFICDesc(const CFI_cdesc_t& i_cdesc_t)
{

  CFI_rank_t rank = i_cdesc_t.rank;

  //    this is supposed to store the extents of a
  // TODO: use smart pointers
  // TODO: memory leak here, use smart pointers
  CFI_cdesc_t* cdesc_copy = (CFI_cdesc_t *) malloc(sizeof(CFI_cdesc_t));
  std::cout<<"Memory leak!!!"<<std::endl;
  CFI_index_t* extents = (CFI_index_t *) malloc(sizeof(CFI_index_t)*rank);

  //    total number of elements to be in the data part of a
  size_t asize = 1;

  for (int i = 0; i < rank; i++) {
      extents[i] = i_cdesc_t.dim[i].extent;
      asize *= extents[i];
  }

  // 1/ use rank as handed in (retieved already above
  // 2/ allocate memory space (size) of whole array including alignment
  // 3/ Establish
  //      This currently crashes
  //
  int ret = CFI_establish(cdesc_copy, i_cdesc_t.base_addr, CFI_attribute_pointer, i_cdesc_t.type, i_cdesc_t.elem_len, rank, extents);
  fprintf(stderr, "BASE_ADDR: %llu\n", (uintmax_t) i_cdesc_t.base_addr);
  std::cout<<"HERE1"<<std::endl;
  if (ret != CFI_SUCCESS) {
      fprintf(stderr,"%i \n", (int) ret);
      exit(2);
  }

  // 4/ set lower bounds
  //  CFI_index_t* lower_bounds = (CFI_index_t *) malloc(sizeof(CFI_index_t)*rank);
  //for (int i = 0; i < i_cdesc_t.rank; i++) {
  //    lower_bounds[i] = 1;
  //}
  for (int i = 0; i < i_cdesc_t.rank; i++){
      cdesc_copy->dim[i].lower_bound = i_cdesc_t.dim[i].lower_bound;
  }

  // 5/ done after freeing locally used memory
  //free(lower_bounds);
  free(extents);
  std::cout<<"HERE2"<<std::endl;
  // Copy everything in
  m_base_addr = cdesc_copy->base_addr;
  m_elem_len = cdesc_copy->elem_len;
  m_version = cdesc_copy->version;
  m_rank = cdesc_copy->rank;
  m_attribute = cdesc_copy->attribute;
  m_type = cdesc_copy->type;
  std::cout<<"HERE3"<<std::endl;
  // TODO: by default dim[i].lower_bound is 0 even if the corresponding fortran array has lbound = 1
  for(auto i=0; i<m_rank; i++) {
      m_dim.push_back(CFI_dim_t{cdesc_copy->dim[i].lower_bound+1, cdesc_copy->dim[i].extent, cdesc_copy->dim[i].sm});
  }
  std::cout<<"HERE4"<<std::endl;
  }*/

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
