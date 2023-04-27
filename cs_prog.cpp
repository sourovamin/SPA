#include <iostream>
#include <string>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
//#include <omp.h>
#include <sys/time.h>
#include <chrono>
#include <mpi.h>

void F1(int N, int rank, int size)
{      
    // -----------------------------------------
    // In this function you initialize 3 matrices and performa a matrix multiplication. 
    // You spread these matrices using MPI. 
    // You should be able to calculate the number of basic blocks as function of the input N.     
    // -----------------------------------------
    
    // Initialize matrices in function of the input N
    int M1[N][N];
    int M2[N][N];
    int M3[N][N];
    
    // Initial matrices
    if(rank == 0)
    {
        int num;
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < N; j++)
            {
                num = (rand() % 10);
                M1[i][j] = num;
                num = (rand() % 10);
                M2[i][j] = num;
                M3[i][j] = 0;
            }
        }
    }

    // New variables
    int ROWS = N; 
    int COLS = N;

    // Broadcast matrix M1, M2 and M3 to all processes
    MPI_Bcast(M1, ROWS * COLS, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(M2, ROWS * COLS, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(M3, ROWS * COLS, MPI_INT, 0, MPI_COMM_WORLD);

    for (int i = 0; i < ROWS; i++) 
    {
        for (int j = 0; j < COLS; j++) 
        {            
            for (int k = 0; k < COLS; k++) 
            {
                M3[i][j] += M1[i][k] * M2[k][j];
            }
        }
    }
}

void F2(int N, int rank, int size)
{      
    // -----------------------------------------
    // In this function we combine both variables: the input N and the number of MPI process (size)
    // The variable chunck_size divide the matrix A. Your model cannot calculate that exactly, but you can point to the user. 
    // You can leave the final equation in function of chunk_size, and then the user can replace by N/size or N/p. 
    // -----------------------------------------    
    // Initialize matrices in function of the input N
    int M1[N][N];
    int M2[N][N];
    int M3[N][N];
    
    // Initial matrices
    if(rank == 0)
    {
        int num;
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < N; j++)
            {
                num = (rand() % 10);
                M1[i][j] = num;
                num = (rand() % 10);
                M2[i][j] = num;
                M3[i][j] = 0;
            }
        }
    }

    // New variables
    int ROWS = N; 
    int COLS = N;
    int chunk_size = N/size;

    // Broadcast matrix M2 to all processes
    MPI_Bcast(M2, ROWS * COLS, MPI_INT, 0, MPI_COMM_WORLD);

    // Scatter matrix M1 to all processes
    int chunk[chunk_size][COLS];
    MPI_Scatter(M1, chunk_size * COLS, MPI_INT, chunk, chunk_size * COLS, MPI_INT, 0, MPI_COMM_WORLD);

    // Perform matrix multiplication
    int result[chunk_size][ROWS];
    for (int i = 0; i < chunk_size; i++) 
    {
        for (int j = 0; j < ROWS; j++) 
        {
            result[i][j] = 0;
            for (int k = 0; k < COLS; k++) 
            {
                result[i][j] += chunk[i][k] * M2[k][j];
            }
        }
    }

    // Gather results from all processes
    MPI_Gather(result, chunk_size * ROWS, MPI_INT, M3, chunk_size * ROWS, MPI_INT, 0, MPI_COMM_WORLD);
}

void F4(int N, int rank, int size)
{ 
    // -----------------------------------------
    // This function has two loops, but the execution doens't change with the inputs. 
    // So, it is a constant exeuction. 
    // -----------------------------------------
    if (rank == 0) 
    {
        printf("N: %d. Size: %d. \n", N, size);
    } 
    int num = 0;
    for (int i = 0; i < 100; i++) 
    {
        for (int j = 0; j < 50; j++) 
        {
            num++;
        }
    }
}

void F3(int N, int rank, int size)
{ 
    // -----------------------------------------
    // This function performs a matrix-vector multiplication
    // In this function we declare a matrix that changes in function of N and size, and two vectors, the first changes in function of N and seze and the second is equal to N
    // -----------------------------------------    
    int N_ext = N*size;
    int M1[N_ext][N_ext];
    int V1[N];
    int V2[N_ext];

    // Initialization
    if(rank == 0)
    {
        int num;
        for (int i = 0; i < N; i++)
        {
            V1[i] = 0;
        }
        for (int i = 0; i < N_ext; i++)
        {
            V2[i] = 0;
            for (int j = 0; j < N_ext; j++)
            {
                num = (rand() % 10);
                M1[i][j] = num;
            }
        }
    }

    // New variables
    int ROWS = N_ext; 
    int COLS = N_ext;
    int chunk_size = N_ext/size;

    // Scatter matrix M1 to all processes
    int chunk[chunk_size][COLS];
    MPI_Scatter(M1, chunk_size * COLS, MPI_INT, chunk, chunk_size * COLS, MPI_INT, 0, MPI_COMM_WORLD);

    // Broadcast vector V1 to all processes
    MPI_Bcast(V1, N, MPI_INT, 0, MPI_COMM_WORLD);

    // Perform multiplication
    int result[chunk_size];
    for (int i = 0; i < chunk_size; i++) 
    {
        result[i] = 0;
        for (int j = 0; j < N; j++) 
        {
            result[i] += chunk[i][j] * V1[i];
            F4(N, rank, size);
        }
    }
    // Gather results from all processes            
    MPI_Gather(result, chunk_size, MPI_INT, V2, chunk_size, MPI_INT, 0, MPI_COMM_WORLD);    
}


int main(int argc, char** argv)
{    

    // ------------------------------
    // Variable n is input of the code
    // ------------------------------
    if(argc!=2)
    {
        argc = 2;
        char* appname = argv[0];
        argv = new char* [2];
        argv[0] = appname;
        //argv[1] = "100";
        char arg[] = "100";
        argv[1] = arg;
    }     
    int N = std::stoul(argv[1]);

    // ------------------------------
    // Initialize MPI
    // ------------------------------
    int rank, size;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    
    // ------------------------------
    // Functions
    // ------------------------------
    if (rank == 0) 
    {
        printf("N: %d. Size: %d. \n", N, size);
    } 
    F1(N, rank, size);
    F2(N, rank, size);
    F3(N, rank, size);
    F4(N, rank, size);
    
    // End
    MPI_Finalize();
    return 0;
}