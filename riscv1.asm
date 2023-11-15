# TRABALHO M2 - ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES II
# PROF. THIAGO FELSKI PEREIRA

# ALUNOS:
# - NICOLAS DOS SANTOS RENAUX
# - PEDRO HENRIQUE CAMARGO RUTHES

.data
    Matriz_A: .word 0:100        # Declaração da matriz Matriz_A com 100 elementos inicializados com 0
    Matriz_B: .word 1:100        # Declaração da matriz Matriz_B com 100 elementos inicializados com 1
    Matriz_C: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99  # Declaração da matriz Matriz_C com elementos inicializados de 0 a 99

    solicitacao: .asciz "\nEntre com o tamanho do índice das matrizes (máx. = 10): "
    textoInvalido: .asciz "Valor inválido"
    percorrida: .asciz "\nInforme como a matriz será percorrida: (0: linha-coluna) ou (1: coluna-linha): "
    formatoMatriz: .asciz "\nMatriz_C = "
    espaco: .asciz " "

.text
jal zero, main

main:
    addi a7, zero, 4               # Chamada do sistema para imprimir a solicitação
    la a0, solicitacao
    ecall

    addi a7, zero, 5               # Chamada do sistema para ler o valor inserido pelo usuário
    ecall
    add a1, zero, a0               # Salva o valor inserido em a1

    li t1, 2                        # Limites para o tamanho do índice (2 a 10)
    li t2, 10
    blt a1, t1, Invalido             # Se a1 < 2, vai para a etiqueta Invalido
    bgt a1, t2, Invalido             # Se a1 > 10, vai para a etiqueta Invalido

    j Perc_Mensagem                 # Se estiver dentro dos limites, vai para Perc_Mensagem

Invalido:
    addi a7, zero, 4               # Chamada do sistema para imprimir mensagem de valor inválido
    la a0, textoInvalido
    ecall
    j main                          # Reinicia o programa

Perc_Mensagem:
    addi a7, zero, 4               # Chamada do sistema para imprimir a mensagem de percorrida
    la a0, percorrida
    ecall

    addi a7, zero, 5               # Chamada do sistema para ler o valor de percorrida
    ecall
    add a2, zero, a0               # Salva o valor de percorrida em a2

    li t2, 0                        # Limites para o modo de percorrer (0 ou 1)
    li t3, 1
    blt a2, t2, Perc_Invalido       # Se a2 < 0, vai para Perc_Invalido
    bgt a2, t3, Perc_Invalido       # Se a2 > 1, vai para Perc_Invalido

    j Perc_Matriz                   # Se estiver dentro dos limites, vai para Perc_Matriz

Perc_Invalido:
    addi a7, zero, 4               # Chamada do sistema para imprimir mensagem de valor inválido
    la a0, textoInvalido
    ecall
    j Perc_Mensagem                 # Reinicia o programa

Perc_Matriz:
    la s0, Matriz_A                 # Carrega o endereço de Matriz_A em s0
    la s1, Matriz_B                 # Carrega o endereço de Matriz_B em s1
    la s2, Matriz_C                 # Carrega o endereço de Matriz_C em s2

    beqz a2, Perc_LinhaColuna       # Se a2 == 0, vai para Perc_LinhaColuna
    j Perc_ColunaLinha              # Se a2 == 1, vai para Perc_ColunaLinha

Perc_LinhaColuna:
    add t6, zero, a1                # t6 = a1 (tamanho do índice)
    add t5, zero, s2                # t5 = s2 (endereço de Matriz_C)
    li t0, 0

    linha_loop:
        beq t0, t6, fim_linha        # Se t0 == t6, vai para fim_linha
        li t1, 0

        coluna_loop:
            beq t1, t6, fim_coluna    # Se t1 == t6, vai para fim_coluna
            lw t2, 0(s0)              # Carrega o valor de Matriz_A em t2
            lw t3, 0(s1)              # Carrega o valor de Matriz_B em t3

            add t4, t2, t3            # Soma os valores
            sw t4, 0(t5)              # Armazena o resultado em Matriz_C

            addi t5, t5, 4            # Incrementa o endereço de Matriz_C
            addi s0, s0, 4            # Incrementa o endereço de Matriz_A
            addi s1, s1, 4            # Incrementa o endereço de Matriz_B

            addi t1, t1, 1            # Incrementa o contador da coluna
            j coluna_loop
        fim_coluna:
            addi t0, t0, 1            # Incrementa o contador da linha
            j linha_loop
    fim_linha:
        j Fim

Perc_ColunaLinha:
    add t6, zero, a1                # t6 = a1 (tamanho do índice)
    add t5, zero, s2                # t5 = s2 (endereço de Matriz_C)
    li t0, 0

    coluna_loop_cl:
        beq t0, t6, fim_coluna_cl    # Se t0 == t6, vai para fim_coluna_cl
        li t1, 0

        linha_loop_cl:
            beq t1, t6, fim_linha_cl  # Se t1 == t6, vai para fim_linha_cl
            lw t2, 0(s0)              # Carrega o valor de Matriz_A em t2
            lw t3, 0(s1)              # Carrega o valor de Matriz_B em t3

            add t4, t2, t3            # Soma os valores
            sw t4, 0(t5)              # Armazena o resultado em Matriz_C
			
            addi a4, zero, 4             # Constante 4 para a multiplicação
            mul a5, t6, a4               # Multiplica o tamanho do índice por 4

            add t5, t5, a5              # Incrementa o endereço de Matriz_C
            add s0, s0, a5              # Incrementa o endereço de Matriz_A
            add s1, s1, a5              # Incrementa o endereço de Matriz_B

            addi t1, t1, 1              # Incrementa o contador da linha
            j linha_loop_cl
        fim_linha_cl:
            addi t0, t0, 1              # Incrementa o contador da coluna
            j coluna_loop_cl
    fim_coluna_cl:
        j Fim

Fim:
    addi t6, zero, 10               # t6 = 10 (limite do loop)
    addi t0, zero, 0                # t0 = 0 (inicialização do contador externo)

    addi a7, zero, 4                # Chamada do sistema para imprimir a mensagem de formato da matriz
    la a0, formatoMatriz
    ecall

    for_i_c:
        beq t0, t6, fim_i_c          # Se t0 == t6, vai para fim_i_c
        add t1, zero, zero          # t1 = 0 (inicialização do contador interno)

        for_j_c:
            beq t1, t6, fim_j_c      # Se t1 == t6, vai para fim_j_c
            lw a0, 0(s2)             # Carrega o valor de Matriz_C em a0

            addi a7, zero, 1         # Chamada do sistema para imprimir o valor de a0
            ecall

            addi a7, zero, 4         # Chamada do sistema para imprimir um espaço
            la a0, espaco
            ecall

            addi s2, s2, 4           # Incrementa o endereço de Matriz_C
            addi t1, t1, 1           # Incrementa o contador interno
            j for_j_c
        fim_j_c:
            j for_i_c
    fim_i_c:
        j Fim_Programa

Fim_Programa:
    addi a7, zero, 10               # Chamada do sistema para encerrar o programa
    ecall
