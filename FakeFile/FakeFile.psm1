
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
    [System.IO.DirectoryInfo]$FolderPath = ($pwd).Path
    [int64]$TotalSize = 1MB
    [Int]$NumberOfFiles = 5
    [System.Collections.ArrayList] $Extensions = [System.Collections.ArrayList]@()

    FakeFileGenerator(){}

    [System.IO.FileInfo[]]Create(){
        
        $SingleSize = $this.TotalSize / $this.NumberOfFiles
        $out = new-object byte[] $SingleSize
        $AllFiles = @()

        for ($i = $This.NumberOfFiles; $i -ge 0; $i--) {
            $FileNAme = $this.GetFileName()
            If(!($this.FolderPath.Exists)){
                $this.FolderPath.Create()
            }
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
        Return ($this.Extensions | Get-Random)
        
    }

    [Void]SetFolderPath([System.IO.DirectoryInfo]$FolderPath){
        $This.FolderPath = $FolderPath
    }

    [Void]SetTotalSize([Int64]$TotalSize){
        $this.TotalSize = $TotalSize
    }

    [Void]SetNumberOfFiles([Int]$NumberOfFiles){
        $this.NumberOfFiles = $NumberOfFiles
    }

    AddExtension([String[]]$Extension){
        Foreach($Ext in $Extension){
            If($ext.StartsWith(".")){
                $this.Extensions.Add($Ext)
            }else{
                $this.Extensions.Add(".$($Ext)")
            }
            
        }
    }

    AddExtensionFromEnum([String]$EnumName){
        $EnumExtensions = [Enum]::GetNames($EnumName)
        $This.AddExtension($EnumExtensions)
    }
   

}

Function New-FakeFileGenerator {
    Return [FakeFileGenerator]::New()
}
Function New-FakeFile {
    <#
    .SYNOPSIS
        Generates random files with meaningfull names of a specific total size.
    .DESCRIPTION
        I wrote this function during a live coding session for psconfeu 2020 of a function to a class.
        This module represents the result of this exercise. 
        The talk can be found here -> https://youtu.be/sQ8hnEovZpM
        By default, the function will create the file in the current directory ($pwd)
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
        [int]$NumberOfFiles, #= 1,
        $TotalSize ,#=1MB,
        [System.IO.DirectoryInfo]$FolderPath, #=($pwd).Path,
        [FakeFileGenerator]$FakeFileGenerator
    )

    If($FakeFileGenerator){
        $Generator = $FakeFileGenerator
    }else{

        $Generator = [FakeFileGenerator]::New()
        $Generator.AddExtensionFromEnum("OfficeExtensions")
    }

    If($NumberOfFiles){

        $Generator.SetNumberOfFiles($NumberOfFiles)
    }

    If($TotalSize){

        $Generator.SetTotalSize($TotalSize)
    }

    If($FolderPath){
        if ($FolderPath.Exists -eq $false) {
            $FolderPath = New-Item -Path $FolderPath.FullName -ItemType Directory
        }
        $Generator.SetFolderPath($FolderPath)
    }

    
    $Generator.Create()

}

