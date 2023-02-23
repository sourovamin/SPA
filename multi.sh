# Run command: sh multi.sh Directory c mpi
# Directory as 1st argument (required)
# Program type as 2nd argument, default c (optinal)
if [ -z "$2" ]; then
    type=$(echo "c")
else
    type=$(echo ${2})
fi

# MPI as 3rd argument, default null (optional)
if [ "$3" == "mpi" ]; then
    if [ "$type" == "c" ]; then
        cc=$(echo "mpicc")
    else
        cc=$(echo "mpicxx")
    fi
else
    if [ "$type" == "c" ]; then
        cc=$(echo "clang")
    else
        cc=$(echo "clang++ -std=c++17")
    fi
fi

a_file=""
for FILE in $1/*.${type}; do
    #echo $FILE
    a_name=$(basename ${FILE})
    f_name=$(echo "${a_name%.*}")

    # Generate ll file
    ${cc} -Wall -Wextra -emit-llvm -S -fno-discard-value-names $FILE -o $1/$f_name.ll
    
    # Generate bc file
    # llvm-as $1/$f_name.ll -o $1/$f_name.bc
    a_file="${a_file} ${1}/${f_name}.ll"
done

# LLVM link to one ll file
# If error arise can use --only-needed or --internalize flag 
llvm-link -S ${a_file} -o $1/$1_output.ll