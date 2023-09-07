# Define a codificação de caracteres para UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Especifique o caminho do arquivo contendo as URLs
$ArquivoURLs = "C:\temp\links.txt"

# Especifique o diretório de destino para salvar as imagens
$DiretorioDestino = "C:\temp\fotos\"

# Crie o diretório de destino se ele não existir
if (-not (Test-Path -Path $DiretorioDestino -PathType Container)) {
    New-Item -Path $DiretorioDestino -ItemType Directory
}

# Função para fazer o download da imagem com resiliência
function BaixarImagemComResiliencia($URL, $CaminhoDestino) {
    $maxTentativas = 5
    $tentativaAtual = 1

    do {
        try {
            Invoke-WebRequest -Uri $URL -OutFile $CaminhoDestino -ErrorAction Stop
            Write-Host "Baixada a imagem: $CaminhoDestino"
            return $true
        } catch {
            Write-Host "Tentativa ${tentativaAtual}: Falha ao baixar a imagem de $URL"
            $tentativaAtual++
        }
    } while ($tentativaAtual -le $maxTentativas)

    Write-Host "Número máximo de tentativas excedido para ${URL}"
    return $false
}

# Lê as URLs do arquivo e baixa cada imagem
Get-Content $ArquivoURLs | ForEach-Object {
    $URL = $_
    $NomeArquivo = [System.IO.Path]::GetFileName($URL)
    $CaminhoDestino = Join-Path -Path $DiretorioDestino -ChildPath $NomeArquivo

    # Verifica se o arquivo já existe antes de fazer o download
    if (-not (Test-Path -Path $CaminhoDestino -PathType Leaf)) {
        BaixarImagemComResiliencia $URL $CaminhoDestino
    } else {
        Write-Host "A imagem ${CaminhoDestino} já existe. Pulando o download."
    }
}

Write-Host "Download das imagens concluído!"
