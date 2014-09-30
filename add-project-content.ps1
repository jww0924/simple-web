param($csproj, $filesToAdd)

$csproj = Resolve-Path $csproj
$contents = [IO.File]::ReadAllText($csproj)
$projectDir = [IO.Path]::GetDirectoryName($csproj)
$searchPath = [IO.Path]::Combine($projectDir, $filesToAdd)

$itemGroup = '<ItemGroup>' + (Get-ChildItem $searchPath | `
     % { "<Content Include=`"$($_.FullName.Substring($projectDir.Length + 1))`" />" }) + '</ItemGroup>'
$contents = $contents.Insert($contents.LastIndexOf('</Project>'), $itemGroup)

[IO.File]::WriteAllText($csproj, $contents)
