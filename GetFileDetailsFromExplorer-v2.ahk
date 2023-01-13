#Requires Autohotkey v2.0-beta.1+
; path := Explorer_GetPath()
; all := Explorer_GetAll()
F13::
{
	; Open Folder(s)/File(s) in VSCode
	sel := Explorer_GetSelected()
	Run "C:\Program Files\Microsoft VS Code\Code.exe " sel
}

F14::
{
	; Extract file(s) using 7zip --- will absolutely overwrite with -y flag
	workingDir := Explorer_GetPath()
	sel := Explorer_GetFor_7zip()
	if sel.Length > 0
		for file in sel
			Run "C:\Program Files\7-Zip\7zr.exe x -y " file, workingDir
}

Explorer_GetPath(hwnd:="")
{
	if !(window := Explorer_GetWindow(hwnd))
		return ErrorLevel := "ERROR"
	if (window="desktop")
		return A_Desktop
	path := window.LocationURL
	path := RegExReplace(path, "ftp://.*@", "ftp://")
	; StrReplace() is not case sensitive
	; check for StringCaseSense in v1 source script
	; and change the CaseSense param in StrReplace() if necessary
	path := StrReplace(path, "file:///")
	; StrReplace() is not case sensitive
	; check for StringCaseSense in v1 source script
	; and change the CaseSense param in StrReplace() if necessary
	path := StrReplace(path, "/", "\")

	; thanks to polyethene
	Loop
		If RegExMatch(path, "i)(?<=%)[\da-f]{1,2}", &hex)
			; StrReplace() is not case sensitive
			; check for StringCaseSense in v1 source script
			; and change the CaseSense param in StrReplace() if necessary
			path := StrReplace(path, "%" . hex[0], Chr("0x" . hex[0]))
		Else Break
	return path
}
Explorer_GetAll(hwnd:="")
{
	return Explorer_Get(hwnd)
}
Explorer_GetSelected(hwnd:="")
{
	return Explorer_Get(hwnd,true)
}

Explorer_GetWindow(hwnd:="")
{
	; thanks to jethrow for some pointers here
    process := WinGetprocessName("ahk_id" hwnd := hwnd? hwnd:WinExist("A"))
    class := WinGetClass("ahk_id " hwnd)

	if (process!="explorer.exe")
		return
	if (class ~= "(Cabinet|Explore)WClass")
	{
		for window in ComObject("Shell.Application").Windows
			if (window.hwnd==hwnd)
				return window
	}
	else if (class ~= "Progman|WorkerW")
		return "desktop" ; desktop found
}
Explorer_Get(hwnd:="",selection:=false)
{
	if !(window := Explorer_GetWindow(hwnd))
		return ErrorLevel := "ERROR"
	if selection
	{
		if window.document.SelectedItems.Count == 0
		{
			ret := '"' . window.document.Folder.Self.Path . '"'
		}
		else
		{
			collection := window.document.SelectedItems
			for item in collection
				ret .= '"' . item.path . '"' . '`s'
		}
	}
	else
	{
		ret := window.document.Folder.Self.Path
	}
	return ret
}

Explorer_GetFor_7zip(hwnd:="")
{
	if !(window := Explorer_GetWindow(hwnd))
		return ErrorLevel := "ERROR"

		; for more property information, see MS documentation on COM Objects
		; Need to: $ShellExp = New-Object -ComObject Shell.Application
		; Then you can traverse object properties using Get-Member
		; So if Explorer is open, you could:
		; ($ShellExp).Windows()[0].Document | Get-Member
	ret := []
	if !(window.document.SelectedItems.Count == 0)
	{
		collection := window.document.SelectedItems
		for item in collection
			if !item.IsFolder
				ret.Push('"' . item.path . '"')
	}
	return ret
}