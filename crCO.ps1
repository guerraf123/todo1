$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")

$body = "{
`n	`"Activity`": `"Multiple`",
`n	`"AffectedOrganization`": `"Retirement Services`",
`n	`"ApplicationProduct`": `"RS - Hosted`",
`n	`"BackoutDuration`":  60,
`n	`"BackoutNotification`":  `"Service Desk Admins`",
`n	`"BackoutPlan`": `"Backout Plan: Test test test`",
`n	`"BackoutTeams`": `"RS SRE`",
`n	`"BackoutTeamsAvailability`": false,
`n	`"BackoutTeamsAwareness`": true,
`n	`"BackoutTested`": true,
`n	`"BackoutType`": `"Scripted`",
`n	`"BusinessCase`": `"Business Case: TEST WS CO Creation`",
`n	`"BusinessImpact`": 5,
`n	`"Category`": `"chgcat:400150`",
`n	`"CertificationGroup`": `"Retirement Services QA`",
`n	`"ConfigurationItems`": [`"dc1prcauap00001`"],
`n	`"DataCenterLocation`": `"DC 1`",
`n	`"Description`": `"Description: TEST WS CO Creation`",
`n	`"Environment`": `"Production`",
`n	`"ExceptionType`": `"zChg_ExceptionType:400006`",
`n	`"HpooRunId`": 999999,
`n	`"Impact`": 5,
`n	`"ImpactObjectDetails`": 	`"Impact object details`",
`n	`"ImpactOnOtherProducts`": `"Impact to other products`",
`n	`"ImpactOtherProducts`": true,
`n	`"ImpactRiskAssessment`": `"Impact/Risk Assessment: TEST WS CO Creation`",
`n	`"ImpactedAppProduct`": `"servicedesk`",
`n	`"ImpactedSupportingTechnology`": `"multiple`",
`n	`"ImpactsCode`": true,
`n	`"ImpactsConfiguration`": true,
`n	`"ImpactsData`": true,
`n	`"ImpactsInfrastructure`": false,
`n	`"ImpactsNone`": false,
`n	`"ImplementationDate`": `"10/28/2021 9:00 PM`",
`n	`"ImplementerTaskDescriptions`": [`"Task 1`"],
`n	`"Implementers`": [`"guerraf`"],
`n	`"OperatingUnit`": `"Global Command Center Hosting (GCC)`",
`n	`"Properties`":`"Production,New,No,,,Software -  Remote Access Only,No,No`",
`n	`"RelatedChangeOrders`": `"Related Change Orders`",
`n	`"RelationToOtherChangeOrder`": `"tied to another co on same date`",
`n	`"Requester`": `"gajdaj`",
`n	`"Risk`": 3,
`n	`"ScheduleDuration`": 10200,
`n	`"SelectedActivities`": [`"400002`", 	`"400003`"],
`n	`"SelectedImpactedSupportingTechnologies`": [`"400002`", 	`"400003`"],
`n	`"Summary`": `"Summary: TEST WS CO Creation with Impact/Risk, backout, and VP approval`",
`n	`"SupportingOrganizations`": [`"GETS Service Tools`"],
`n	`"SuspendMonitoring`": false,
`n	`"TechnicalComplexity`": `"400003`",
`n	`"UrgencyOfChange`": `"urgency of change`",
`n	`"ValidationPlan`": `"Validation Plan: TEST WS CO Creation`",
`n	`"ValidationPlanOfBackoutPlan`": `"validation plan of backout plan`",
`n	`"VmSnapshot`": true,
`n	`"Vp1Approver`": `"chamberm`",
`n	`"WSPassword`": `"90908`",
`n	`"WSUserId`": `"RSSRE_ReqAuto`"
`n}
`n"

$response = Invoke-RestMethod 'http://dpopsweb-stag/Chg2/WS/CABChgWS.svc/rest/CreateCABChangeOrder' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
