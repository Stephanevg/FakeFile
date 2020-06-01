
Enum OfficeExtensions {
    pptx
    docx
    xls
    doc
    pdf
    ppt
    dot
}

Enum MediaExtensions {
    mp3
    mp4
    jpg
    mpeg2
}

Class FakeFileGenerator {
    [System.IO.DirectoryInfo]$FolderPath = $PSScriptRoot
    [int]$TotalSize = 1MB
    [Int]$NumberOfFiles = 5

    FakeFileGenerator(){}

    [System.IO.FileInfo[]]Create(){
        
        $SingleSize = $this.TotalSize / $this.NumberOfFiles
        $out = new-object byte[] $SingleSize
        $AllFiles = @()

        for ($i = $This.NumberOfFiles; $i -gt 0; $i--) {
            $FileNAme = $this.GetFileName()
            $FileFullPath = Join-Path -Path $this.FolderPath -ChildPath $FileName
            $Null = [IO.File]::WriteAllBytes($FileFullPath, $out)
            $AllFiles += [System.IO.FileInfo]$FileFullPath 
        }
        
        Return $AllFiles
        
    }

    [String] GetFileName(){
        $Array = (Get-Verb | Select-Object verb | Get-Random -Count 2).verb
        
        $FName = $Array -join ""
        Return ($FName + $This.GetExtension())
    }

    [String] GetExtension(){
        REturn ( "." + ([Enum]::GetNames("OfficeExtensions") | Get-Random))
        
    }

    [Void]SetFolderPath([System.IO.DirectoryInfo]$FolderPath){
        $This.FolderPath = $FolderPath
    }

    [Void]SetTotalSize([Int]$TotalSize){
        $this.TotalSize = $TotalSize
    }

    [Void]SetNumberOfFiles([Int]$NumberOfFiles){
        $this.NumberOfFiles = $NumberOfFiles
    }
   

}

Function New-FakeFile {
    <#
    .SYNOPSIS
        Generates random files with meaningfull names of a specific total size.
    .DESCRIPTION
        Function example for the PSConfEu2020 
    .EXAMPLE
        New-FakeFile -NumberOfFiles 4 -TotalSize 32MB
    .OUTPUTS
        [System.Io.FileInfo[]]
    .NOTES
        Author:Stephane van Gulick

    .LINK
        https://github.com/Stephanevg/FakeFile
    #>
    Param(
        $NumberOfFiles = 1,
        $TotalSize = 1MB,
        $FolderPath = $PSScriptRoot
    )

    $Generator = [FakeFileGenerator]::New()
    $Generator.SetNumberOfFiles($NumberOfFiles)
    $Generator.SetTotalSize($TotalSize)
    $Generator.SetFolderPath($FolderPath)
    $Generator.Create()

}


