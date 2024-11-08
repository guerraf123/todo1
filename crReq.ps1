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
$integer = [int]$bn.Envelope.Body.LoginResponse.LoginResult



$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "text/xml")
$headers.Add("SOAPAction", "`"http://tempuri.org/ICASDWS/createRequest`"")

$body = "<soapenv:Envelope xmlns:soapenv=`"http://schemas.xmlsoap.org/soap/envelope/`" xmlns:tem=`"http://tempuri.org/`" xmlns:arr=`"http://schemas.microsoft.com/2003/10/Serialization/Arrays`">
`n   <soapenv:Header/>
`n   <soapenv:Body>
`n      <tem:createRequest>
`n         <!--Optional:-->
`n         <tem:sid>$integer</tem:sid>
`n         <!--Optional:-->
`n         <tem:creatorHandle/>
`n         <!--Optional:-->
`n         <tem:attrVals>
`n            <!--Zero or more repetitions:-->
`n            <arr:string>customer</arr:string>
`n            <arr:string>cnt:4000937BD40C2A45B52495BF1D59E5AD</arr:string>
`n            <arr:string>category</arr:string>
`n            <arr:string>pcat:400269 </arr:string>
`n            <arr:string>urgency</arr:string>
`n            <arr:string>urg:1104</arr:string>
`n            <arr:string>impact</arr:string>
`n            <arr:string>impact:1600</arr:string>
`n            <arr:string>summary</arr:string>
`n            <arr:string>Create Rquest</arr:string>
`n            <arr:string>description</arr:string>
`n            <arr:string>Create Resquest for test</arr:string>
`n            <arr:string>type</arr:string>
`n            <arr:string>crt:182</arr:string>
`n         </tem:attrVals>
`n         <!--Optional:-->
`n         <tem:propertyValues>
`n</tem:propertyValues>
`n         <!--Optional:-->
`n         <tem:template></tem:template>
`n         <!--Optional:-->
`n         <tem:addlAttributes>
`n            <!--Zero or more repetitions:-->
`n            <arr:string>persistent_id</arr:string>
`n            <arr:string>ref_num</arr:string>
`n         </tem:addlAttributes>
`n         <!--Optional:-->
`n         <tem:strNewRequestHandle></tem:strNewRequestHandle>
`n         <!--Optional:-->
`n         <tem:strNewRequestNumber></tem:strNewRequestNumber>
`n      </tem:createRequest>
`n   </soapenv:Body>
`n</soapenv:Envelope>"

$response = Invoke-WebRequest 'https://dpopsweb-stag/CASDWS_WCF/WS/CASDWS.svc' -Method 'PUT' -Headers $headers -Body $body
#$response | ConvertTo-Json
write-host $response