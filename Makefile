FC = ftn
CXX = CC

FCFLAGS = -Wall -Wextra
CCFLAGS = -Wall -Wextra
LDFLAGS = -lc++

all: f_test_varlist
f_test_varlist.o : mo_varlist_mod.o

f_test_varlist : %.o mo_varlist_mod.o varlist_capi.o VarList.o
	${FC} $^ -o $@ ${LDFLAGS}

%.o : %.f90
	${FC} ${FCFLAGS} -c $< -o $@

%.o : %.cpp
	${CXX} ${CCFLAGS} -c $^ -o $@

.PHONY : clean

clean :
	${RM} -rf *.o *.mod f_test_varlist
