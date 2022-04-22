FC = ftn
CXX = CC
CC = cc

FCFLAGS = -v -Wall -Wextra -g -O0
CCFLAGS = -v -Wall -Wextra -g -O0 -fpermissive
LDFLAGS = -v -lgfortran -lstdc++ -g -O0

all: f_test_varlist

f_test_varlist.o : varlist_mod.o varlist_cfi_mod.o memory_mod.o

f_test_varlist : f_test_varlist.o varlist_mod.o varlist_cfi_mod.o varlist_capi.o memory_capi.o varlist_item_mod.o varlist_item_c_mod.o varlist_cfi_item_mod.o varlist_cfi_item_c_mod.o memory_mod.o CFICDesc.o VarList.o
	${FC} $^ -o $@ ${LDFLAGS}

f_test_varlist.o : f_test_varlist.f90
	${FC} ${FCFLAGS} -c f_test_varlist.f90 -o f_test_varlist.o

varlist_mod.o : varlist_mod.f90 varlist_item_mod.o
	${FC} ${FCFLAGS} -c varlist_mod.f90 -o varlist_mod.o

varlist_cfi_mod.o : varlist_cfi_mod.f90 varlist_cfi_item_mod.o
	${FC} ${FCFLAGS} -c varlist_cfi_mod.f90 -o varlist_cfi_mod.o

memory_mod.o : memory_mod.f90
	${FC} ${FCFLAGS} -c memory_mod.f90 -o memory_mod.o

varlist_item_mod.o : varlist_item_mod.f90 varlist_item_c_mod.o
	${FC} ${FCFLAGS} -c varlist_item_mod.f90 -o varlist_item_mod.o

varlist_cfi_item_mod.o : varlist_cfi_item_mod.f90 varlist_cfi_item_c_mod.o
	${FC} ${FCFLAGS} -c varlist_cfi_item_mod.f90 -o varlist_cfi_item_mod.o

varlist_item_c_mod.o : varlist_item_c_mod.f90
	${FC} ${FCFLAGS} -c varlist_item_c_mod.f90 -o varlist_item_c_mod.o

varlist_cfi_item_c_mod.o : varlist_cfi_item_c_mod.f90
	${FC} ${FCFLAGS} -c varlist_cfi_item_c_mod.f90 -o varlist_cfi_item_c_mod.o

varlist_capi.o : varlist_capi.cpp
	${CXX} ${CCFLAGS} -c varlist_capi.cpp -o varlist_capi.o

memory_capi.o : memory_capi.cpp
	${CXX} ${CCFLAGS} -c memory_capi.cpp -o memory_capi.o

VarList.o: VarList.cpp VarList.hpp
	${CXX} ${CCFLAGS} -c VarList.cpp -o VarList.o

CFICDesc.o: CFICDesc.cpp CFICDesc.hpp
	${CXX} ${CCFLAGS} -c CFICDesc.cpp -o CFICDesc.o

.PHONY : clean

clean :
	${RM} -rf *.o *.mod f_test_varlist
