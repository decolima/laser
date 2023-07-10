mensagem = "Olá, mundo!"
print(mensagem)


# Criando uma matriz 3x3
matriz = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

# Acessando elementos da matriz
elemento = matriz[0][1]  # Acessando o elemento da primeira linha e segunda coluna (valor: 2)

# Modificando elementos da matriz
matriz[2][1] = 10  # Modificando o elemento da terceira linha e segunda coluna para o valor 10

# Percorrendo a matriz
for linha in matriz:
    for elemento in linha:
        print(elemento, end=' - ')
    print()
