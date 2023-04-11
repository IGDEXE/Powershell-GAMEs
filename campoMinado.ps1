# Define o tamanho do tabuleiro
[int]$tamanho = 10

# Gera aleatoriamente as posições das minas
$count = $tamanho * 2
$maximo = $tamanho * $tamanho
$minas = Get-Random -Count $count -Minimum 0 -Maximum $maximo

# Cria a matriz do tabuleiro com todas as células ocultas
$tabuleiro = New-Object 'object[,]' $tamanho, $tamanho
for ($i = 0; $i -lt $tamanho; $i++) {
    for ($j = 0; $j -lt $tamanho; $j++) {
        $tabuleiro[$i, $j] = "O"
    }
}

# Define a função para exibir o tabuleiro
function Exibir-Tabuleiro {
    for ($i = 0; $i -lt $tamanho; $i++) {
        for ($j = 0; $j -lt $tamanho; $j++) {
            Write-Host $tabuleiro[$i, $j] -NoNewline
        }
        Write-Host
    }
}

# Exibe o tabuleiro inicial
Exibir-Tabuleiro

# Define a função para verificar se uma célula contém uma mina
function Verificar-Mina {
    param(
        [int]$linha,
        [int]$coluna
    )
    if ($minas -contains $linha*$tamanho + $coluna) {
        return $true
    }
    return $false
}

# Loop principal do jogo
while ($true) {
    # Solicita a posição do jogador
    $linha = Read-Host "Informe a linha (1 a $tamanho)"
    $coluna = Read-Host "Informe a coluna (1 a $tamanho)"
    $linha = [int]$linha - 1
    $coluna = [int]$coluna - 1

    # Verifica se a célula contém uma mina
    if (Verificar-Mina $linha $coluna) {
        $tabuleiro[$linha, $coluna] = "X"
        Exibir-Tabuleiro
        Write-Host "BOOM! Você perdeu."
        break
    }

    # Marca a célula como descoberta
    $tabuleiro[$linha, $coluna] = " "
    Exibir-Tabuleiro

    # Verifica se o jogador venceu
    $vitoria = $true
    for ($i = 0; $i -lt $tamanho; $i++) {
        for ($j = 0; $j -lt $tamanho; $j++) {
            if ($tabuleiro[$i, $j] -eq "O") {
                $vitoria = $false
            }
        }
    }
    if ($vitoria) {
        Write-Host "Parabéns! Você venceu."
        break
    }
}
