#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct Matrix {
	int row;					//Number of rows
	int column;				//Number of columns
	int* data;	//Address of matrix data
}Matrix;

// Matrix multiplication function declare
extern int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2);
// int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2)
// {
//     if(source1->column!=source2->row)   return 1;
//     results->row=source1->row;
//     results->column=source2->column;
//     for (int i=0;i<source1->row;++i)
//     {
//         for (int j=0;j<source2->column;++j)
//         {
//             for(int k=0;k<source1->column;++k)
//             {
//                 *(results->data+i*results->column+j)+=
//                 (*(source1->data+i*source1->column+k))
//                 *
//                 (*(source2->data+k*source2->column+j));
//             }
//         }
//     }
//     return 0;
// }

// Print matrix data
int print_matrix(const Matrix* matrix)
{
	int i, j;
	
	for (i = 0; i < matrix->row; i++)
	{
		for (j = 0; j < matrix->column; j++)
			printf("%d ", *(matrix->data + i * matrix->column + j));
		printf("\n");
	}
	return 0;
}

void get_matrix_from_file(FILE *fp, Matrix* matrix){
    for (int i = 0; i < matrix->row; i++){
        for (int j = 0; j < matrix->column; j++){
            fscanf(fp, "%d", &matrix->data[i*matrix->column +j]);
        }
    }
}


int main(int argc,char* argv[])
{
	if (argc != 2){
        printf("Please give a file\n");
        exit(-1);
    }
    FILE *fp = fopen(argv[1], "r");
    if(fp == NULL) {
        perror("Error opening file\n");
        return(-1);
    }
    int rows, columns;
    fscanf(fp,"%d",&rows);
    fscanf(fp,"%d",&columns);
    int data_1[rows][columns];
    Matrix source_matrix1 = {
        rows,
        columns,
        &data_1
    };
    get_matrix_from_file(fp, &source_matrix1);
    
    fscanf(fp,"%d",&rows);
    fscanf(fp,"%d",&columns);
    int data_2[rows][columns];
    Matrix source_matrix2 = {
        rows,
        columns,
        &data_2
    };
    get_matrix_from_file(fp, &source_matrix2);

    fclose(fp);

    int results_matrix_data[source_matrix1.row][source_matrix2.column];
    Matrix results_matrix = {
        source_matrix1.row,
        source_matrix2.column,
        &results_matrix_data
    };
    
    //Clear result matrix data
    memset(results_matrix_data, 0, sizeof(int) * results_matrix.row * results_matrix.column);

    //Matrix multiplication
    if (matrix_mul(&results_matrix, &source_matrix1, &source_matrix2) == 0)
        // Success
        print_matrix(&results_matrix);
    else
        // Fail
        printf("Fail to multiply two matrices.\n");

    return 0;
}
