' Author: iBug
' Converts all PPTX to PDF in current directory
' Author: iBug

Option Explicit

Dim Shell, FS
Set Shell = CreateObject("WScript.Shell")
Set FS = CreateObject("Scripting.FileSystemObject")
Dim PowerPoint

Dim SupportedExtension : SupportedExtension = "pptx"

Sub Conv(FileName, ext)
  Dim PPT, Range, SaveName
  Set PPT = PowerPoint.Presentations.Open(FileName)
  Set Range = PPT.PrintOptions.Ranges.Add(1, 1)
  SaveName = Replace(FileName, "." & ext, ".pdf")
  PPT.ExportAsFixedFormat SaveName, 2, 2, 0, 2, 4, 0, Range, 1, False, False, False, False, False
  PPT.Close
End Sub

Sub ConvAll(Dir)
  Dim Item
  For Each Item In Dir.Files
    If LCase(FS.GetExtensionName(Item.Path)) = "pptx" or LCase(FS.GetExtensionName(Item.Path)) = "ppsx" or LCase(FS.GetExtensionName(Item.Path)) = "ppt" or LCase(FS.GetExtensionName(Item.Path)) = "pps" Then
      Conv Item.Path, LCase(FS.GetExtensionName(Item.Path))
    End If
  Next
  For Each Item In Dir.SubFolders
    ConvAll Item
  Next
End Sub

Set PowerPoint = CreateObject("PowerPoint.Application")
PowerPoint.Visible = True
ConvAll FS.GetFolder(".")
PowerPoint.Quit