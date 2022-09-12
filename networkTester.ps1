function testConnection {
    param (
        $ipAddress,
        $testType
    )
    Write-Host "`nTrying to connect to " $testType"`n"
    if ((Test-NetConnection $ipAddress -InformationLevel "Quiet") -eq "True") {
        Write-Host "Success: Machine is connected to $ipAddress`n" -ForegroundColor Green
        $printReport = Read-Host -Prompt "Show full log? `n(Y/N)"
        if (($printReport -eq 'Y') -or ($printReport -eq 'y')) {
            Test-NetConnection $ipAddress -InformationLevel "Detailed"
        }
        Read-Host -Prompt "Press Enter to continue"
        Clear-Host
        selectorMenu
    }
    else {
        Write-Host "`nError: Machine not connected to $testType`n" -ForegroundColor Red
        $printReport = Read-Host -Prompt "Show full log? `n(Y/N)"
        if (($printReport -eq 'Y') -or ($printReport -eq 'y')) {
            Test-NetConnection $ipAddress -InformationLevel "Detailed"
        }
        Read-Host -Prompt "Press Enter to continue"
        Clear-Host
        selectorMenu
    }
}

function localTestConnection {
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

    testConnection -ipAddress $ipType -testType "LAN"
}

function selectorMenu{
    Write-Host "==============`n--------------`nNetwork Tester`n--------------`n==============`n`n" 
    Start-Sleep -Seconds 1
    Write-Host "Basic Network Tester`n
                1 ) LAN (Local Area Network)
                2 ) WAN (Wide Area Network)
                3 ) Advanced`n"
    $testType = Read-Host -Prompt 'Type the test number to execute'
    if ($testType -eq 1) {
        localTestConnection
    }
    elseif ($testType -eq 2) {
        testConnection -testType "WAN" -ipAddress www.google.ie
    }
    elseif ($testType -eq 3) {
        $ipType = Read-Host -Prompt 'Manually enter a valid IP here'
        testConnection -testType $ipType -ipAddress $ipType
    }
    else {
        Write-Host "`nError: '" $testType "' is not a valid input`n" -ForegroundColor Red
        Write-Host ""
        selectorMenu
    }
}

selectorMenu