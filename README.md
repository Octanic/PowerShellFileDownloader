# PowerShellFileDownloader
Will download a list of image files using powershell

Case scenario:
I have a bunch of files to download, so I wrapped it into a PowersHell script, it will download those files for me.

# How to use it 
First, make sure you can set the execution policy to Remote-Signed
```powershell
Set-ExecutionPolicy RemoteSigned
```

Second, make sure you have a `links.txt` file located at `C:\temp` with all your URL. One URL by line.
_you can change it, of course. I'm not making it THAT fancy. I just needed a quick script to do that_ 😅

Then, run it
```powershell
.\FileDownloader.ps1
```

## Remarks
- If there is a network error to download the file, it will retry 5 times.
- The output will be on `c:\temp\fotos\`
