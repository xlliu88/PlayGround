Attribute VB_Name = "Module1"
'Microsoft VBA
'to sort cyst counting sheets
'Created on Nov 7th, 2016
'Last modified on Nov 26, 2016
'function getGT() added on Nov 26, 2016
'Xunliang Liu
'xlliu88@gmail.com

Sub Melt()

    Dim genotype As New Scripting.Dictionary
    Dim Rep As Integer
    Dim PlateNo As Integer
    Dim CellNo As String
    Dim Ecotype As String
    Dim Plate_date, Inoc_date, Count_14, Count_30 As Date
    Dim ppJ2No As Integer
    Dim ppJ2type As String
    
    Dim welldata As New Scripting.Dictionary
    Dim datatable()

    Dim Sh As Worksheet
    Dim Loc As Range
    Dim FirstFound
    
    
    For Each Sh In ThisWorkbook.Worksheets
        Sh.Activate
        If InStr(Sh.Range("A1").Value, "Infection Assay") Then
            Set genotype = getGT("TEST")  'read genotype setting;
            
            ''' read experiment info
            Rep = Sh.Cells(2, 4).Value
            Ecotype = Sh.Cells(4, 4).Value
            ppJ2No = Sh.Cells(7, 4).Value
            Plate_date = Sh.Cells(5, 4).Value
            Inoc_date = Sh.Cells(6, 4).Value
            Count_14 = Sh.Cells(8, 4).Value
            Count_30 = Sh.Cells(9, 4).Value
            
            If Rep Then
                RepCount = RepCount + 1
            End If
            
            'to read and sort data
            With Sh.UsedRange
                Set Loc = .Cells.Find(what:="Plate ")
                If Not Loc Is Nothing Then
                    FirstFound = Loc.Address
                    Do
                        If UBound(Split(Loc.Value)) > 0 Then
                            PlateNo = CInt(Split(Loc.Value)(1))
                            wellx = Loc.Column + 1
                            welly = Loc.Row + 2
                            For x = 0 To 3
                                For y = 0 To 11 Step 4
                                    Set welldata = CreateObject("Scripting.Dictionary")
                                    Set welldata = Nothing
                                    welldata("Rep") = Rep
                                    welldata("Plate#") = PlateNo
                                    welldata("Well#") = Sh.Cells(welly + y, Loc.Column).Value & Sh.Cells(welly - 1, wellx + x).Value
                                    welldata("Genotype Code") = Sh.Cells(welly + y, wellx + x).Value
                                    welldata("Genotype") = genotype(welldata("Genotype Code"))
                                    welldata("14dpi Count") = Sh.Cells(welly + y + 1, wellx + x).Value
                                    welldata("30dpi Count") = Sh.Cells(welly + y + 2, wellx + x).Value
                                    If InStr(welldata("30dpi Count"), ",") Then
                                    Tsplit = Split(welldata("30dpi Count"), ",")
                                        welldata("30dpi Total") = 0
                                        For i = 0 To UBound(Tsplit)
                                            k = "30dpi-c" & i + 1
                                            welldata(k) = Tsplit(i)
                                            If Not IsNumeric(Tsplit(i)) Then
                                                welldata("30dpi Total") = Tsplit(i)
                                            Else
                                                welldata("30dpi Total") = welldata("30dpi Total") + Tsplit(i)
                                            End If
                                        Next i
                                    End If
                                    welldata("Note") = Sh.Cells(welly + y + 3, wellx + x).Value
                                    '== to test data reading ==
                                    'For wd = 0 To Welldata.Count - 1
                                    '   Debug.Print Welldata.Keys(wd) & ": " & Welldata.Items(wd)
                                    'Next wd
                                    
                                    If ((Not datatable) = -1) Then  'in vba, if an array is not initiated, (Not array) returned -1
                                        ReDim datatable(0)          'if DataTable() is not initiated, ReDim Datatable
                                    Else
                                        ReDim Preserve datatable(UBound(datatable) + 1) 'else, expand TataTable by 1
                                    End If
                                    Set datatable(UBound(datatable)) = welldata         'add the well data as the last element of Datatable

                                Next y
                            Next x
                        End If
                        Set Loc = .FindNext(Loc)                                        'reset Loc to the next cell with "Plate "
                    Loop While Not Loc Is Nothing And Loc.Address <> FirstFound         'end of one plate; exit loop when the location of next found cells is the same as the first found cell
                End If
            End With
            Set Loc = Nothing
        End If  'end of data reading in one sheet
    Next        'Go to next sheet
    
    
    'to write melted data to a new sheet (Melted)
    If Evaluate("ISREF('Melted'!A1)") Then  'to evaluate if 'Melted'!A1 is a reference. aka. to check if sheet "Melted" exist
        ReMelt = MsgBox("Melted data found. Do you want to OVERWRITE the melted data?", vbYesNo, "Melted data found") 'to decide if redo melting
        If ReMelt = vbYes Then
            Worksheets("Melted").Activate
            ActiveSheet.Cells.ClearContents
        Else
            ReMelt = vbNo
        End If
    Else                                    ' if sheet "Melted" not exist, add the "Melted" sheet
        ReMelt = vbYes
        Worksheets.Add.Name = "Melted"
    End If
              
    'Write data
    If ReMelt = vbYes Then
        Dim line As New Scripting.Dictionary
        For wy = 0 To UBound(datatable)
            Set line = datatable(wy)
            If wy = 0 Then                      'for the first line, write the title
                For wx = 0 To line.Count - 1
                    Cells(wy + 1, wx + 1).Value = line.Keys(wx)
                Next wx
            End If
            
            For wx = 0 To line.Count - 1        'write the data
                Cells(wy + 2, wx + 1).Value = line.Items(wx)
            Next wx
        Next wy
    End If
    
End Sub

Function getGT(Optional test As String)
    Dim gtLoc As Range
    Dim gtCode As New Scripting.Dictionary
    Set gtCode = Nothing
    
    Set gtLoc = ActiveSheet.Cells.Find(what:="Genotype Code")
    If (Not gtLoc Is Nothing) Then
        gtRow = gtLoc.Row + 1
        gtColumn = gtLoc.Column

        
        Do While Not IsEmpty(ActiveSheet.Cells(gtRow, gtColumn + 1).Value)
            gtCode(ActiveSheet.Cells(gtRow, gtColumn).Value) = ActiveSheet.Cells(gtRow, gtColumn + 1).Value
            gtRow = gtRow + 1
        Loop
    Else
        Debug.Print "Genotype setting is not found"
    End If
    Set getGT = gtCode
    
    If test = "TEST" Then
        Debug.Print "Sheet: " & ActiveSheet.Name
        Debug.Print "genotype location: " & gtLoc.Address
        Debug.Print "total genotypes found:" & gtCode.Count
        For Each k In gtCode.Keys
            Debug.Print k & ": " & gtCode(k)
        Next k
    End If
End Function
