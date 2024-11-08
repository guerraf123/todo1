[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} ;
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "text/xml")
$headers.Add("SOAPAction", "`"http://tempuri.org/ICASDWS/Login`"")

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:tem=`"http://tempuri.org/`" xmlns:arr=`"http://schemas.microsoft.com/2003/10/Serialization/Arrays`">
`n   <soapenv:Header/>
`n   <soapenv:Body>
`n      <tem:Login>
`n         <!--Optional:-->
`n         <tem:Username>RSSRE_ReqAuto</tem:Username>
`n         <!--Optional:-->
`n         <tem:Password>90908</tem:Password>
`n      </tem:Login>
`n   </soapenv:Body>
`n</soapenv:Envelope>"

$response = Invoke-WebRequest 'https://dpopsweb-stag/CASDWS_WCF/WS/CASDWS.svc' -Method 'PUT' -Headers $headers -Body $body
#$response | ConvertTo-Json
write-host $response
$bn = [xml]$response.Content
write-host $bn.Envelope.Body.LoginResponse.LoginResult


