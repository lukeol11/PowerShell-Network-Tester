Write-Host "==============`n--------------`nNetwork Tester`n--------------`n==============`n`n" 

Write-Host "Basic Network Tester`n
            1 ) LAN (Local Area Network)
            2 ) WAN (Wide Area Network)
            3 ) Advanced`n"
$testType = Read-Host -Prompt 'Type the test number to execute'

if ($testType -eq 1) {
    if ((Get-NetRoute "0.0.0.0/0").NextHop -is [array]){
        Write-Host "`nPlease Select the option that has numbers other than 0's`n"
        $arrayLength = (Get-NetRoute "0.0.0.0/0").NextHop.length
        for ($i = 0; $i -lt $arrayLength; $i = $i + 1) {
            Write-Host "            "($i+1)")"((Get-NetRoute "0.0.0.0/0").NextHop)[$i]
        }
        Write-Host ""
        $ipType = Read-Host -Prompt 'Type the correct format number (or manually enter a valid IP)'
        $ipType = ((Get-NetRoute "0.0.0.0/0").NextHop)[$ipType-1]
    } else {
        $ipType = ((Get-NetRoute "0.0.0.0/0").NextHop)
    }

    Write-Host "`nTrying to connect to " $ipType"`n"
    if ((Test-NetConnection $ipType -InformationLevel "Quiet") -eq "True") {
        Write-Host "Success: Machine is connected to LAN`n" -ForegroundColor Green
        $printReport = Read-Host -Prompt "Show full log? `n(Y/N)"
        if (($printReport -eq 'Y') -or ($printReport -eq 'y')) {
            Test-NetConnection $ipType -InformationLevel "Detailed"
        }
        Read-Host -Prompt "Press Enter to exit"
    }
    else {
        Write-Host "`nError: Machine not connected to LAN`n" -ForegroundColor Red
        $printReport = Read-Host -Prompt "Show full log? `n(Y/N)"
        if (($printReport -eq 'Y') -or ($printReport -eq 'y')) {
            Test-NetConnection $ipType -InformationLevel "Detailed"
        }
        Read-Host -Prompt "Press Enter to exit"
    }
}
elseif ($testType -eq 2) {
    Write-Host "`nTrying to connect to www.google.ie`n"
    if ((Test-NetConnection www.google.ie -InformationLevel "Quiet") -eq "True") {
        Write-Host "Success: Machine is connected to WAN`n" -ForegroundColor Green
        $printReport = Read-Host -Prompt "Show full log? `n(Y/N)"
        if (($printReport -eq 'Y') -or ($printReport -eq 'y')) {
            Test-NetConnection www.google.ie -InformationLevel "Detailed"
        }
        Read-Host -Prompt "Press Enter to exit"
    }
    else {
        Write-Host "`nError: Machine not connected to WAN`n" -ForegroundColor Red
        $printReport = Read-Host -Prompt "Show full log? `n(Y/N)"
        if (($printReport -eq 'Y') -or ($printReport -eq 'y')) {
            Test-NetConnection www.google.ie -InformationLevel "Detailed"
        }
        Read-Host -Prompt "Press Enter to exit"
    }
}
elseif ($testType -eq 3) {
    Write-Host ""
    $ipType = Read-Host -Prompt 'Manually enter a valid IP here'

    Write-Host "`nTrying to connect to " $ipType"`n"
    if ((Test-NetConnection $ipType -InformationLevel "Quiet") -eq "True") {
        Write-Host "Success: Machine is connected to $iptype`n" -ForegroundColor Green
        $printReport = Read-Host -Prompt "Show full log? `n(Y/N)"
        if (($printReport -eq 'Y') -or ($printReport -eq 'y')) {
            Test-NetConnection $ipType -InformationLevel "Detailed"
        }
        Read-Host -Prompt "Press Enter to exit"
    }
    else {
        Write-Host "`nError: Machine not connected to $iptype`n" -ForegroundColor Red
        $printReport = Read-Host -Prompt "Show full log? `n(Y/N)"
        if (($printReport -eq 'Y') -or ($printReport -eq 'y')) {
            Test-NetConnection $ipType -InformationLevel "Detailed"
        }
        Read-Host -Prompt "Press Enter to exit"
    }
}
else {
    Write-Host "`nError: '" $testType "' is not a valid input`n" -ForegroundColor Red
    Read-Host -Prompt "Press Enter to exit"
}