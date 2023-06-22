from time import sleep
tabuleiro = [[' ',' ',' '],[' ',' ',' '],[' ',' ',' ']]
rodada = 1
turno = 'X'
colunas = "ABC"
linhas = "123"


def riscar(simbolo, x, y, tab=tabuleiro):
    if ((x in range(3)) and (y in range(3))) and (tab[y][x] == ' '):
        tab[y][x] = simbolo
        return 1, None
    else:
        return 0, "Posição inválida."


def mostrar_tabuleiro(tab=tabuleiro):
    print("    A   B   C ")
    for y in range(3):
        print(f" {y+1}  {tab[y][0]} ║ {tab[y][1]} ║ {tab[y][2]}")
        if y < 2: print("   ═══╬═══╬═══")


def checar_vitoria(tab=tabuleiro):
    if (tab[1][1] in "XY") and ([tab[1][1]]*3 in [[tab[j][j] for j in range(3)], [tab[2-j][j] for j in range(3)]]):
        return tab[1][1]
    for i in range(1,3):
        if (tab[i][0] in "XY") and ([tab[i][0]]*3 in [[tab[i][-j] for j in range(3)], [tab[i-j][0] for j in range(3)]]):
            return tab[i][0]
        elif (tab[0][i] in "XY") and ([tab[0][i]]*3 in [[tab[0][i-j] for j in range(3)], [tab[-j][i] for j in range(3)]]):
            return tab[0][i]
    return 0


# Loop geral do jogo
while True:
    print(f"\n---------------------------\n\nRodada {rodada}" if turno == 'X' else '')
    print(f"É a vez do jogador {turno}!")
    mostrar_tabuleiro()

    # Loop de cada rodada
    while True:
        pos = input("Sua jogada: ").strip().upper()
        if len(pos) == 2:
            x,y = colunas.find(pos[0]), linhas.find(pos[1])
            valido, resultado = riscar(turno, x,y)
            if valido:
                print(f"\nMarcado {turno} na posição {pos[0]}{pos[1]}")
                sleep(1)
                break
            else:
                print(resultado)
                sleep(1)
        else:
            print("Jogada inválida.")
            sleep(1)
    
    # Mudamos de quem é o turno
    if turno == 'X':
        turno = 'O'
    else:
        rodada += 1
        turno = 'X'

    vitoria = checar_vitoria()
    if vitoria:
        print(f"\nVitória do jogador {vitoria} na {rodada}ª rodada!")
        mostrar_tabuleiro()
        break

    if not ((' ' in tabuleiro[0]+tabuleiro[1]+tabuleiro[2])):
        print("\nPutz, deu velha!")
        mostrar_tabuleiro()
        sleep(1)
        print("Reiniciando...")
        sleep(1)
        tabuleiro[:] = [[' ',' ',' '],[' ',' ',' '],[' ',' ',' ']]
        rodada = 1
        turno = 'X'
        