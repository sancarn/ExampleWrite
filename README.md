# ExampleWrite
A solution for sharing coding projects in single files.

## Example

```
BobTheBuilder.DEF
{
    Declare Sub Build()
    Dim Building as String}
}

BobTheBuilder.MB
{
    Include "BobTheBuilder.DEF"
    Sub Build()
        print "Building: " & Building
    End Sub
}

BuildingProject.DEF
{
    Declare Sub Main()
}


BuildingProject.MB
{
    Include "BuildingProject.DEF"
    Include "BobTheBuilder.DEF"
    Sub Main()
        Building = "Tower"
        Call Build()
    End Sub
}

BuildingProject.MBP
{
	[Link]
	Application = BuildingProject.mbx
	Module = BobTheBuilder.MBO
	Module = BuildingProject.MBO
}
```

When the above is processed by the Example Writer engine Seperate files will be created for:

```
BobTheBuilder.DEF
BobTheBuilder.MB
BuildingProject.DEF
BuildingProject.MB
BuildingProject.MBP
```

And each of these files will contain the text contained in the `{}`

P.S.

Currently the programme can not deal with Javascript, C++ or any other language that uses the `{` or `}` characters while programming. This is a future improvement I intend to make. 
