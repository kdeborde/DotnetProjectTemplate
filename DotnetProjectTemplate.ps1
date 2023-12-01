$projectName = Read-Host("What will your solution be named?");

# TODO: Implement
# $boolCreateFolderStructure = Read-Host("Would you like to add folder structure template?(y/n)");
# $useGlobalJson = Read-Host("Add global.json file to specify .NET version?(y/n)");
# Add opportunity to rename project files, else use default.
# Add unit test project? if so which kind? Default xunit.
# Add frontend Project? If so what?

mkdir $projectName/src | cd -Path {$_ }

# Create Projects
Write-Host("Creating projects...") -ForegroundColor Green;
dotnet new sln -n $projectName;
dotnet new webapi -n WebApi;
dotnet new classlib -n Infrastructure; # Contracts (Interfaces), Repositories, Data Access
dotnet new classlib -n Domain; # Models and Business Objects
dotnet new classlib -n Common; # Shared Code
dotnet new xunit -n Tests; # Unit Test Project

Write-Host("Adding Projects to solution...") -ForegroundColor Green;
dotnet sln add WebApi;
dotnet sln add Infrastructure;
dotnet sln add Domain;
dotnet sln add Common;
dotnet sln add Tests;

Write-Host("Adding Project References...") -ForegroundColor Green;
dotnet add .\WebApi reference .\Infrastructure
dotnet add .\WebApi reference .\Common
dotnet add .\Infrastructure reference .\Domain
dotnet add .\Infrastructure reference .\Common
dotnet add .\Domain reference .\Common
dotnet add .\Tests reference .\Common
dotnet add .\Tests reference .\Infrastructure
dotnet add .\Tests reference .\Domain

Write-Host("Running dotnet restore") -ForegroundColor Green
dotnet restore

Write-Host("Dotnet restore completed") -ForegroundColor Green
$openInCode = Read-Host("Open Project in vscode?(y/n)");

if($openInCode.Trim().ToLower().Substring(0, 1) -eq 'y') {
    cd ..
    code .
}
else {
    $openInCode = Read-Host("Open Project in Visual Studio? (y/n)");

    if($openInCode.Trim().ToLower().Substring(0, 1) -eq 'y')
    {
        Start-Process($projectName + '.sln');
    }
}