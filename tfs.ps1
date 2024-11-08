param(
    [Parameter()]$releaseUrl,
    [Parameter()]$envSearchPattern,
    [Parameter()]$approvalComment
)
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$releaseUrl = 'http://401ktfsprod.es.ad.adp.com:8080/tfs/RSWebsites/RSWebsites/RSWebsites%20Team/_release?releaseId=&_a=release-summary'
$envSearchPattern = 'PROD'
$approvalComment = 'go'
$baseUri = 'https://401ktfsprod.es.ad.adp.com/tfs/RSWebSites/RSWebSites/_apis'

$queryPairs = @{};
($releaseUrl -split '\?')[1] -split '&' | %{
$pair = $_ -split '='
    if ($queryPairs.ContainsKey($pair[0])){
        $queryPairs[$pair[0]] = $pair[1];
        return;
    }
    $queryPairs.Add($pair[0], $pair[1]);
}
$releaseId = $queryPairs['releaseId']

$tfsHeaders = @{
    'Accept'= 'application/json;api-version=3.0-preview.1'
}

$release = Invoke-WebRequest -Uri "$baseUri/release/releases/$releaseId" -ContentType 'application/json' -Headers $tfsHeaders -UseDefaultCredentials
$releaseContent = ConvertFrom-Json $release.Content
$environments = $releaseContent.environments |? -Match Name $envSearchPattern

Write-Host ('Ok to approve the following {0} environment(s)?' -f $environments.Count) -ForegroundColor Yellow
$environments.Name | % {
    Write-Host "  $_" -ForegroundColor Yellow
}


$approveResponses = $environments |% {
    $environmentId = $_.id
    $deployBody = '{"status":0}'

    # get preDeploymentApprovalId
    $queueResponse = Invoke-WebRequest -Uri "$baseUri/release/releases/$releaseid/environments/$environmentId" -Method Patch -ContentType 'application/json' -Headers $tfsHeaders -Body $deployBody -UseDefaultCredentials
    $queueResponseContent = ConvertFrom-Json $queueResponse.Content
    $preDeployApprovalId = $queueResponseContent.preDeployApprovals[0].id

    $body = @"
{
	"status": 2,
	"comments": "your comment here",
	"release": {
		"id": $releaseId
	},
	"releaseEnvironment": {
		"id": $environmentId
	}
}
"@

    Write-Host "approving $($_.name)" -ForegroundColor Yellow
    return Invoke-WebRequest -Uri "$baseUri/Release/approvals/$preDeployApprovalId" -Method Patch -ContentType 'application/json' -Headers $tfsHeaders -Body $body -UseDefaultCredentials
}

$approveResponses.StatusCode
