# FakeFile

FakeFile is a powershell module which allows to create fake files with human understandable names, of various sizes.


# Installation

```powershell
Install-module FakeFile

```

## Example of usage

```powershell

#Creates 4 files for a total size of 32MB (Each file will be 8MB)
 New-FakeFile -NumberOfFiles 4 -TotalSize 32MB 


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-----          06/06/2020    08:48        8388608 RestoreDeploy.docx
-----          06/06/2020    08:48        8388608 ImportBuild.dot
-----          06/06/2020    08:48        8388608 StopFormat.doc
-----          06/06/2020    08:48        8388608 ConnectOut.pptx
```

# Features

Fake file can do the following tasks

- Create dummy files with human understandable names
- Create a specific amount of dummy files for a total amount of size (4 files of with a total size of 4GB -> each file will automatically be 1GB)
- Create a large amount of small files (1000 files of 1kb)

# PsConfeu 2020 Talk

This module was written during a live coding for the psconfeu 2020. 
The full video recording [is available on youtube here ](https://youtu.be/sQ8hnEovZpM)

The exerice I was doing was to convert an old powershell script to a powershell class.

The conversion part is availbe at [1h09min of the recording](https://youtu.be/sQ8hnEovZpM?t=4160)

