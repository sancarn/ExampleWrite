;Get file path of example file:
FileSelectFile, ExampleFile

if !ExampleFile
	ExitApp

;Get file contents:
FileRead, ExampleContents, %ExampleFile%

;Prepare Regex:
ExampleExtract := "(?![\r\n])(.+?\.\w+?)\s*\{\s*[\r\n]+((?:.|\s)*?)\}"

;Find all matches and use doActions function
Pos:=1
While Pos {

	Pos:=RegExMatch(ExampleContents,"iO)" . ExampleExtract, objOut, Pos)
	If Pos <> 0
	{
		Pos := Pos + objOut.Len(0)
		doActions(objOut)
	}
}
ExitApp

doActions(objOut){
	;get fileName from objOut
	FileName := Trim(objOut.Value(1))
	
	;make containing folders
	MakeFolders(FileName)
	
	;get file contents
	FileContents := objOut.Value(2)
	
	;Delete old file, if exists
	FileDelete, %FileName%
	
	;Get file contents
	FileContents := RemoveIndent(FileContents)
	
	;Append fileContents to file
	FileAppend, %FileContents%, %FileName%
	
	
	;msgbox, %FileName%`r`n%FileContents%
}

RemoveIndent(s){
	;Removes a single indentation from the script given.
	
	;Get indent of first line
	Pos:=RegExMatch(s,"\S")
		
	;Create new indentless string
	r := ""
	Loop, Parse, s, `n, `r
	{
		r := r . (r ? "`r`n" : "") . SubStr(A_LoopField,Pos)
	}
	
	return r
}

MakeFolders(s){
	pos := InStr(s,"\",,-1)
	if pos {
		DirName := trim(SubStr(s,1,pos-1))
		FileCreateDir, %DirName%
	}
}
