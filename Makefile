FC = ftn
CXX = CC
CC = cc

FCFLAGS = -v -Wall -Wextra -g -O0
CCFLAGS = -v -Wall -Wextra -g -O0 -fpermissive
LDFLAGS = -v -lgfortran -lstdc++ -g -O0

all: test_varcollection

test_varcollection.o : varcollection_mod.o t_var_mod.o t_var_data_mod.o t_var_descriptor_mod.o t_var_metadata_mod.o

test_varcollection : test_varcollection.o varcollection_mod.o t_var_mod.o t_var_data_mod.o t_var_descriptor_mod.o t_var_metadata_mod.o varcollection_capi.o CFICDesc.o #VarList.o
	${FC} $^ -o $@ ${LDFLAGS}

test_varcollection.o : test_varcollection.f90
	${FC} ${FCFLAGS} -c test_varcollection.f90 -o test_varcollection.o

varcollection_mod.o : varcollection_mod.f90 t_var_mod.o
	${FC} ${FCFLAGS} -c varcollection_mod.f90 -o varcollection_mod.o

t_var_mod.o : t_var_mod.f90 t_var_descriptor_mod.o t_var_metadata_mod.o t_var_data_mod.o
	${FC} ${FCFLAGS} -c t_var_mod.f90 -o t_var_mod.o

t_var_data_mod.o : t_var_data_mod.f90
	${FC} ${FCFLAGS} -c t_var_data_mod.f90 -o t_var_data_mod.o

t_var_descriptor_mod.o : t_var_descriptor_mod.f90
	${FC} ${FCFLAGS} -c t_var_descriptor_mod.f90 -o t_var_descriptor_mod.o

t_var_metadata_mod.o : t_var_metadata_mod.f90
	${FC} ${FCFLAGS} -c t_var_metadata_mod.f90 -o t_var_metadata_mod.o

#varlist_item_mod.o : varlist_item_mod.f90 varlist_item_c_mod.o
#	${FC} ${FCFLAGS} -c varlist_item_mod.f90 -o varlist_item_mod.o

#varlist_cfi_item_mod.o : varlist_cfi_item_mod.f90 varlist_item_c_mod.o
#     ${FC} ${FCFLAGS} -c varlist_cfi_item_mod.f90 -o varlist_cfi_item_mod.o

#varlist_item_c_mod.o : varlist_item_c_mod.f90
#	${FC} ${FCFLAGS} -c varlist_item_c_mod.f90 -o varlist_item_c_mod.o

varcollection_capi.o : varcollection_capi.cpp
	${CXX} ${CCFLAGS} -c varcollection_capi.cpp -o varcollection_capi.o

#VarList.o: VarList.cpp VarList.hpp
#	${CXX} ${CCFLAGS} -c VarList.cpp -o VarList.o

CFICDesc.o: CFICDesc.cpp CFICDesc.hpp
	${CXX} ${CCFLAGS} -c CFICDesc.cpp -o CFICDesc.o

.PHONY : clean

clean :
	${RM} -rf *.o *.mod f_test_varlist
