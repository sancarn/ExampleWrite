;Get file path of example file:
FileSelectFile, ExampleFile

if !ExampleFile
	ExitApp

;Get file contents:
FileRead, ExampleContents, %ExampleFile%

;Prepare Regex:
ExampleExtract := "(.+?\.\w+?)\s*\{\s*[\r\n]+((?:.|\s)*?)\}"

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
	FileName := objOut.Value(1)
	FileContents := objOut.Value(2)
	FileDelete, %FileName%
	FileContents := RemoveIndent(FileContents)
	FileAppend, %FileContents%, %FileName%
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
