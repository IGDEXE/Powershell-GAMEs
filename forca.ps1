# Define a lista de palavras
$palavras = @("GATO", "CACHORRO", "ELEFANTE", "GIRAFA", "LEOPARDO", "MACACO", "PAPAGAIO")

# Seleciona uma palavra aleatória
$palavra = $palavras | Get-Random

# Define as variáveis do jogo
$letras = [char[]]$palavra
$letras_descobertas = [bool[]]::new($letras.Length)
$vidas = 6

# Define a função para mostrar a palavra
function Mostrar-Palavra {
    for ($i = 0; $i -lt $letras.Length; $i++) {
        if ($letras_descobertas[$i]) {
            Write-Host $letras[$i] -NoNewline
        } else {
            Write-Host "_" -NoNewline
        }
        Write-Host " " -NoNewline
    }
    Write-Host ""
}

# Inicia o jogo
Write-Host "Bem-vindo ao jogo da forca!"
Write-Host "A palavra tem $($letras.Length) letras."
Mostrar-Palavra

# Enquanto o jogador ainda tem vidas e não acertou todas as letras
while ($vidas -gt 0 -and $letras_descobertas -contains $false) {
    # Pede ao jogador para digitar uma letra
    $letra = Read-Host "Digite uma letra"
    # Verifica se a letra existe na palavra
    $letra_encontrada = $false
    for ($i = 0; $i -lt $letras.Length; $i++) {
        if ($letras[$i] -eq $letra) {
            $letras_descobertas[$i] = $true
            $letra_encontrada = $true
        }
    }
    # Se a letra não existe na palavra, perde uma vida
    if (!$letra_encontrada) {
        $vidas--
        Write-Host "Você errou! Restam $($vidas) vidas."
    }
    # Mostra a palavra
    Mostrar-Palavra
}

# Verifica se o jogador ganhou ou perdeu
if ($vidas -gt 0) {
    Write-Host "Parabéns! Você ganhou!"
} else {
    Write-Host "Que pena! Você perdeu! A palavra era $($palavra)."
}