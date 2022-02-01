FC = ftn
CXX = CC

FCFLAGS = -Wall -Wextra
CCFLAGS = -Wall -Wextra
LDFLAGS = -lgfortran -lstdc++

all: f_test_varlist
f_test_varlist.o : varlist_mod.o

f_test_varlist : f_test_varlist.o varlist_mod.o varlist_capi.o
	${FC} $^ -o $@ ${LDFLAGS}

f_test_varlist.o : f_test_varlist.f90
	${FC} ${FCFLAGS} -c f_test_varlist.f90 -o f_test_varlist.o

varlist_mod.o : varlist_mod.f90
	${FC} ${FCFLAGS} -c varlist_mod.f90 -o varlist_mod.o

varlist_capi.o : varlist_capi.cpp
	${CXX} ${CCFLAGS} -c varlist_capi.cpp -o varlist_capi.o

.PHONY : clean

clean :
	${RM} -rf *.o *.mod f_test_varlist
