cls

$term = '"11.10.41.150"'
$outfile = "c:\temp\code-search-$((Get-Date -Format 'yyyyMMdd-HHmmss')).csv"


## list Git repos

$uri = 'http://401ktfsprod.es.ad.adp.com/tfs/RSWebSites/RSWebSites/_apis/git/repositories'
$headers = @{ };
$headers.Accept = 'application/json;api-version=4.1-preview.1';

$rawResponse = $null;
$rawResponse = Invoke-WebRequest -Uri $uri -UseDefaultCredentials -Headers $headers -Method Get -ContentType 'application/json'
$respRepos = @{
    StatusCode = $rawResponse.StatusCode;
    Content    = ($rawResponse | ConvertFrom-Json);
    Response   = $rawResponse;
}

#$respRepos.Content.value

## list TFVC paths

$uri = 'http://401ktfsprod.es.ad.adp.com/tfs/RSWebSites/RSWebSites/_apis/tfvc/items'
$headers = @{ };
$headers.Accept = 'application/json;api-version=4.1-preview.1';

$rawResponse = $null;
$rawResponse = Invoke-WebRequest -Uri $uri -UseDefaultCredentials -Headers $headers -Method Get -ContentType 'application/json'

$respTfvcPaths = @{
    StatusCode = $rawResponse.StatusCode;
    Content    = ($rawResponse | ConvertFrom-Json);
    Response   = $rawResponse;
}

#$respTfvcPaths.Content.value


## build filter list
$filters = New-Object System.Collections.ArrayList
$respRepos.Content.value |%{
    if (
        $_.Name -like 'VSS.*'
    ){
        return;
    }
    [void]$filters.Add([pscustomobject]@{
        repo = $_.Name
        path = $null;
        type = 'git';
    });
}

$respTfvcPaths.Content.value |%{
    $path = $_.path;
    if (
        $path -eq '$/RSWebsites' -or 
        ($path -match 'RSNextGen(_|-)' -and $path -ne '$/RSWebsites/RSNextGen_ExternalAPI')
        ){
        return;
    }
    [void]$filters.Add([pscustomobject]@{
        repo = '$/RSWebsites'
        path = $path;
        type = 'tfvc';
    });
}

##TODO: exclude some paths


$skip = 0;
$top = 1000;


$uri = 'http://401ktfsprod.es.ad.adp.com/tfs/RSWebSites/RSWebSites/_apis/search/codesearchresults'
$headers = @{ };
$headers.Accept = 'application/json;api-version=4.1-preview.1';

$bodyTemplateTfvc = ConvertFrom-Json @'
{
    "searchText": "",
    "scope": "Team Foundation Server",
    "filters": {
        "Project": ["RSWebsites"],
        "Repository": null,
        "Path": null
    },
    "$skip": 0,
    "$top": 1000,
    "sortOptions": "",
    "includeFacets": true
}
'@

$bodyTemplateGit = ConvertFrom-Json @'
{
    "searchText": "",
    "scope": "Team Foundation Server",
    "filters": {
        "Project": ["RSWebsites"],
        "Repository": null
    },
    "$skip": 0,
    "$top": 1000,
    "sortOptions": "",
    "includeFacets": true
}
'@

$searchResults = New-Object System.Collections.ArrayList

$filters | select -First 1000 |% {
    $filter = $_;

    $bodyTemplate = $null;
    if ($filter.type -eq 'git'){
        $bodyTemplate = $bodyTemplateGit
        $bodyTemplate.filters.Repository = @($_.repo); # must be an array
    }
    else{
        $bodyTemplate = $bodyTemplateTfvc
        $bodyTemplate.filters.Repository = @($_.repo); # must be an array
        $bodyTemplate.filters.Path = @($_.path); # must be an array
    }

    do
    {
        $bodyTemplate.searchText = $term;
        $bodyTemplate.'$skip' = $skip
        $bodyTemplate.'$top' = $top

        write-host "requesting term='$term' skip=$skip; repo=$($bodyTemplate.filters.Repository); path=$($bodyTemplate.filters.Path)" -ForegroundColor Gray -NoNewline
        $rawResponse = Invoke-WebRequest -Uri $uri -Body ($bodyTemplate | ConvertTo-Json) -UseDefaultCredentials -Headers $headers -Method Post -ContentType 'application/json'
        $resp = @{
            StatusCode = $rawResponse.StatusCode;
            Content    = ($rawResponse | ConvertFrom-Json);
            Response   = $rawResponse;
        }
        $resultCount = $resp.Content.count;
        $pageSize = $resp.Content.results.Count;
        write-host "  totalResults=$resultCount pageSize=$pageSize"
        if ($resultCount -gt 2000){
            Write-Host "too many results; max is 2000; found $resultCount" -BackgroundColor Red -ForegroundColor White
        }
        $searchResults.AddRange($resp.Content.results);
        $skip = $pageSize
    }while($pageSize -eq 1000 -and $searchResults.Count -lt 2000);

}

## build summary

## write to file (for excel)
$summary = $searchResults |% {
    $result = $_;
    $repoType = $result.repository.type;
    $filePath = [System.Web.HttpUtility]::UrlEncode($result.path)

    $relativeUrl = ''
    if ($repoType -eq 'git') {
            $relativeUrl = "_git/repositories"
        }
        else {
            $relativeUrl = "_versionControl"
        }
        

    $result.matches |% {
        $match = $_;

        return [pscustomobject]@{
            'fileName' = $result.fileName;
            'repository' = $result.repository.name;
            'matchContentLength' = $match.content.Count;
            'charOffset' = $match.content.charOffset -join ', ';
            'length' = $match.content.Length
            'path' = $result.path;
            'link' = "https://401ktfsprod.es.ad.adp.com/tfs/RSWebsites/RSWebsites/$relativeUrl`?path=$filePath"
        }
    }
}
$summary | Export-Csv -NoTypeInformation -Path $outFile
Write-Host "write $outFile" -ForegroundColor Green