# the file we want to target
$path = "c:\Users\RemkoW\Downloads\ADUserAttributes.exe"

# no need to execute any of the code, we just need the resources
# so this is a safer way to load the assembly
$rawAssembly = [IO.File]::ReadAllBytes($path);
$assembly = [System.Reflection.Assembly]::ReflectionOnlyLoad($rawAssembly)

# there should be only one, but let's select the first 1 just in case
$name = $assembly.GetManifestResourceNames() | select -First 1

# basename is the name without the .resources extension
$baseName = $name.Replace(".resources", "")

# get resourcemanager object
$resourceManager = New-Object System.Resources.ResourceManager($baseName, $assembly)

# get the "Scripts.zip" resource as a byte array
$zippedBytes = $resourceManager.GetObject("Scripts.zip")

# save it as "<path>\Scripts.zip"
$destPath = Join-Path (Split-Path $path) -ChildPath "Scripts.zip"

[IO.File]::WriteAllBytes($destPath, $zippedBytes)

