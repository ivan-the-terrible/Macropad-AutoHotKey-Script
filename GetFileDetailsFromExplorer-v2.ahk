#Requires Autohotkey v2.0-beta.1+

F13::
{
	path := Explorer_GetPath()
	all := Explorer_GetAll()
	sel := Explorer_GetSelected()
	; MsgBox(path)
	; MsgBox(all)
	MsgBox(sel)
return
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
	if (window="desktop")
	{
		hwWindow := ControlGetHWND("SysListView321", "ahk_class Progman")
		if !hwWindow ; #D mode
			hwWindow := ControlGetHWND("SysListView321", "A")
		files := ListViewGetContent(( selection ? "Selected":"") "Col1",,ahk_id %hwWindow%)
		base := SubStr(A_Desktop, -1, 1)=="\" ? SubStr(A_Desktop, 1, -1) : A_Desktop
		Loop Parse, files, "`n", "`r"
		{
			path := base "\" A_LoopField
			if FileExist(path) ; ignore special icons like Computer (at least for now)
				ret .= path "`n"
		}
	}
	else
	{
		if selection
			collection := window.document.SelectedItems
		else
			collection := window.document.Folder.Items
		for item in collection
			ret .= item.path "`n"
	}
	return Trim(ret,"`n")
}