$user = $args[0]
$token = $args[1]
$webSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$cookie = New-Object System.Net.Cookie
$cookie.Name = "user"
$cookie.Value = $user + "&" + $token
$cookie.Domain = "news.ycombinator.com"
$webSession.Cookies.Add($cookie)
$response = Invoke-WebRequest https://news.ycombinator.com -WebSession $webSession
$content = $response | Select-Object -ExpandProperty Content
$content -match "<a id='me' href=\`"user\?id=$user\`">$user<\/a>\s+\((?<karma>\d+)\)" | Out-Null
$Matches.karma
