Attribute VB_Name = "Module2"

Sub RBD()
Attribute RBD.VB_ProcData.VB_Invoke_Func = "r\n14"
    Dim pairs As New Collection
    Dim Sh As Worksheet
    
    For Each Sh In ThisWorkbook.Worksheets
        If (InStr(Sh.Range("A1").Value, "Infection Assay") = 0) Then
            GoTo skipsheet1
        End If
        
        If GTcount(Sh) > ngt Then
            ngt = GTcount(Sh)
        End If
        If trtcount(Sh) > ntrt Then
             ntrt = trtcount(Sh)
        End If
        
skipsheet1:
    Next Sh
 
    For i = 0 To ngt * ntrt - 1
        trt = (i Mod ntrt) + 1
        gt = Int(i / ntrt) + 1
        If ngt = 1 Then
            pair = trt
        ElseIf ntrt = 1 Then
            pair = gt
        Else
            pair = gt & " ~ " & trt
        End If
        pairs.Add (pair)
    Next i
    
    Dim alltrt As New Collection
    For rep = 1 To 36
        Set alltrt = collmerge(alltrt, shuffle(pairs))
    Next rep

    For Each Sh In ThisWorkbook.Worksheets
        If (InStr(Sh.Range("A1").Value, "Infection Assay") = 0) Then
            GoTo skipsheet2
        End If
        Sh.Activate
        x = welldesignation(alltrt, Sh)
        'y = plateno(Sh)
skipsheet2:
    Next
    
    lay = RDBlayout(alltrt)
    
End Sub

Function shtexist(shtname As String)
    shtexist = Evaluate("ISREF('" & shtname & "'!A1)")
End Function
Function makesht(shtname As String, Optional clear As Boolean)
    If shtexist(shtname) Then
        Worksheets(shtname).Activate
        If clear Then
            Worksheets(shtname).Cells.clear
        End If
    Else
        Worksheets.Add.Name = shtname
    End If
End Function

Function GTcount(Sh, Optional test As String)
    Dim gtLoc As Range
    Dim ngt As Integer
    'Set gtCode = Nothing
    
    Set gtLoc = Sh.Cells.Find(what:="Genotypes")
    If (Not gtLoc Is Nothing) Then
        r = gtLoc.Row + 1 'row number
        col = gtLoc.Column 'column number

        ngt = 0
        Do While Not IsEmpty(Sh.Cells(r, col + 1).Value)
            ngt = ngt + 1
            r = r + 1
        Loop
    Else
        Debug.Print "Genotype setting not found"
        MsgBox "Genotype setting not found in sheet: " & ActiveSheet.Name
        GTcount = 0
        Exit Function
    End If
    
    GTcount = ngt
    
    If (test = "TEST") And (Not gtLoc Is Nothing) Then
        Debug.Print "Sheet: " & Sh.Name
        Debug.Print "genotype location: " & gtLoc.Address
        Debug.Print "total genotypes found:" & ngt
    End If
End Function

Function trtcount(Sh, Optional test As String)
    Dim trtLoc As Range
    Dim ntrt As Integer
    'Set gtCode = Nothing
    
    Set trtLoc = Sh.Cells.Find(what:="Treatments")
    If (Not trtLoc Is Nothing) Then
        r = trtLoc.Row + 1 'row number
        col = trtLoc.Column
        ntrt = 0
        Do While Not IsEmpty(Sh.Cells(r, col + 1).Value)
            ntrt = ntrt + 1
            r = r + 1
        Loop
    
    Else
        Debug.Print "Treatment setting not found"
        MsgBox "Treatment setting not found in sheet: " & ActiveSheet.Name
        trtcount = 0
        Exit Function
    End If
    trtcount = ntrt
    
    If (test = "TEST") And (Not trtLoc Is Nothing) Then
        Debug.Print "Sheet: " & Sh.Name
        Debug.Print "treatment location: " & trtLoc.Address
        Debug.Print "total treatment found:" & ntrt
    End If
End Function

Function shuffle(coll As Collection, Optional test As String) As Collection
    Dim shufcoll As New Collection
    Dim tempColl As New Collection
    
    For icoll = 1 To coll.count
        tempColl.Add coll(icoll)
    Next
    
    n = tempColl.count
    For i = 1 To n
        r = Int(Rnd(1) * (n - i + 1) + 1)
        'Debug.Print r
        shufcoll.Add tempColl(r)
        tempColl.Remove (r)
    Next i
    
    Set shuffle = shufcoll
End Function

Function collmerge(colla As Collection, collb As Collection)
    Dim merged As New Collection
    
    For Each Item In colla
        merged.Add Item
    Next Item
    
    For Each Item In collb
        merged.Add Item
    Next Item
    Set collmerge = merged
End Function

Function shuftest(n As Integer, r As Integer, Optional coll As Collection)
    Dim testcoll As New Collection
    Dim newcoll As New Collection
    
    Debug.Print "== collection shuffle test =="
    makesht ("shuffled")
    
    For i = 1 To n
      testcoll.Add i
    Next i
    
    For j = 1 To r
        Set newcoll = shuffle(testcoll)
        Debug.Print "shuffle # " & j
        Debug.Print " shuffled: "
        For k = 1 To newcoll.count
            Cells(j, k).Value = newcoll(k)
            Debug.Print "  " & newcoll(k)
        Next k
        
        Set newcoll = New Collection
    Next j
End Function

Function welldesignation(trts As Collection, sht As Worksheet)
    ' to designate radomrized (genotype - treatment) pairs to each well on one replication
    ' and empty extra wells when all pairs are designated
    
    Dim plateLoc As Range
    Dim n As Integer
    
    Set plateLoc = sht.Cells.Find(what:="Plate ")
    If plateLoc Is Nothing Then
        Exit Function
    End If
    
    FirstFound = plateLoc.Address
    
    n = 1 'to track items in trts
    Do
        startrow = plateLoc.Row + 2
        startcol = plateLoc.Column + 1
        For r = 0 To 2
            For c = 0 To 3
            
                If n <= trts.count Then
                    sht.Cells(r * 4 + startrow, c + startcol).Value = trts(n)
                Else
                    sht.Cells(r * 4 + startrow, c + startcol).Value = "na" 'when all treatments are designated, empty following wells
                End If
                sht.Cells(r * 4 + startrow, c + startcol).HorizontalAlignment = xlCenter
                n = n + 1
            Next c
        Next r
    
        Set plateLoc = sht.Cells.FindNext(plateLoc)
    Loop While (Not plateLoc Is Nothing) And plateLoc.Address <> FirstFound '
    
End Function
    
Function plateno(sht As Worksheet)
    ' assign constitutive number to plates
    
    Dim plateLoc As Range
    
    Set plateLoc = sht.Cells.Find(what:="Plate ")
    If plateLoc Is Nothing Then
        Exit Function
    End If
    
    FirstFound = plateLoc.Address
    n = 1
    Do
        Debug.Print "Plate #: " & n
        plateLoc.Value = "Plate " & n
        n = n + 1
        Set plateLoc = sht.Cells.FindNext(plateLoc)
    Loop While (Not plateLoc Is Nothing) And plateLoc.Address <> FirstFound
End Function


Function RDBlayout(coll As Collection)
    Dim pltLoc As Range
    
    ms = makesht("RBDlayout", 1)
    Worksheets("RBDlayout").Activate
    Cells(1, 1).Value = "Randomized Block Design Layout"
    Cells(1, 1).Font.Bold = True

    nplt = coll.count / 12
    i = 1
    For p = 1 To nplt
        For wr = 1 To 3
          For wc = 1 To 4
            If ((i - 1) Mod 12) = 0 Then
                pltnum = Int(i / 12) + 1
                pltrow = Int((pltnum - 1) / 2) * 6 + 3
                pltcol = ((pltnum - 1) Mod 2) * 6 + 1
                pltdr = drawplt(pltrow, pltcol, pltnum)
            End If
            
            Cells(wr + pltrow + 1, wc + pltcol) = coll(i)
            Cells(wr + pltrow + 1, wc + pltcol).HorizontalAlignment = xlCenter
            i = i + 1
          Next
        Next
    Next

End Function

Function drawplt(r, c, num, Optional addrow As Integer)
    Dim loc As Range
    Dim first As Range
    Dim last As Range
    
    Dim pltrange As Range
    
    Set loc = Cells(r, c)
    Set first = Cells(r + 2, c + 1)
    Set last = Cells(r + 2 + 2, c + 1 + 3)
    
    collett = Chr(Asc("A") + c - 1)
    Columns(collett & ":" & collett).ColumnWidth = 2
    
    Range(first, last).Borders.LineStyle = xlContinuous
    
    loc.Value = "Plate " & num
    loc.Font.Bold = True
    For i = 1 To 4
        Cells(r + 1, c + i).Value = i
        Cells(r + 1, c + i).HorizontalAlignment = xlCenter
    Next
    For j = 1 To 3
        Cells(r + j + 1, c).Value = Chr(Asc("A") + j - 1)
        Cells(r + j + 1, c).HorizontalAlignment = xlCenter
    Next

End Function
