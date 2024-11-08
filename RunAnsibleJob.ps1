$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Authorization", "Bearer r8HcapeSt0NaOcsu59wXMhNClMDaa1")

$body = "{`"query`":`"`",`"variables`":{}}"

$response = Invoke-RestMethod 'https://etower.oneadp.com/api/v2/job_templates/2142/launch/' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json