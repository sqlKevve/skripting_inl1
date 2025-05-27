# funktion för att skapa huvudmapp med undermappar och en loggfil
function MappFunktion {
    param (
        [string]$huvudMappNamn
    )

    # try sats utifall ett oväntat fel inträffar så catchas det
    try {
        # kontroll så att huvudmappens namn inte redan är upptaget
        if (Test-Path -Path $huvudMappNamn) {
            throw "Mappen '$huvudMappNamn' existerar redan."
        }

        # skapar huvudmappen
        New-Item -Path $huvudMappNamn -ItemType Directory | Out-Null

        # lista med undermappar som ska skapas
        $underMappar = @("logs", "scripts", "temp")

        # skapar undermappar
        foreach ($mapp in $underMappar) {
            New-Item -Path (Join-Path $huvudMappNamn $mapp) -ItemType Directory | Out-Null
        }

        # loggfil skapas i logs-mappen
        $date = Get-Date -Format "yyyy-MM-dd"
        $logFilePath = Join-Path $huvudMappNamn "logs\log-$date.txt"
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        # skriver meddelande i loggen
        "Struktur skapad: $timestamp" | Out-File -FilePath $logFilePath

        Write-Host "Mappstrukturen och loggfilen skapades"
    }
    catch {
        # utifall ett fel inträffar så catchas det
        Write-Error "Fel vid skapande av struktur: $_"
    }
}

$mappNamn = Read-Host "Ange namn på huvudmappen"

# anrop av funktionen
MappFunktion -huvudMappNamn $mappNamn
