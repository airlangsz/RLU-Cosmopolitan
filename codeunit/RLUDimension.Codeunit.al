codeunit 50101 "RLU Dimension"
{
    Permissions = tabledata "Gen. Journal Line" = rimd,
     tabledata "Dimension Set Entry" = rimd;

    var
        DimensionManagement: Codeunit DimensionManagement;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode_Ext(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    var
        MatDim_Rec: Record "RLU Matrix Dimension";
        ConfirmMgt: Codeunit "Confirm Management";
        Text001_Err: Label 'Matrix Dimension not exist, you need to review transaction Dimension vs Matrix Dimension. Continue to post journal ?';
    begin
        MatDim_Rec.SetRange(DimSetId, GenJournalLine."Dimension Set ID");
        if MatDim_Rec.IsEmpty() then
            if not ConfirmMgt.GetResponseOrDefault(Text001_Err, true) then
                Error('Posting canceled');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCodeJob_Ext(var HideDialog: Boolean; var JobJnlLine: Record "Job Journal Line"; var SuppressCommit: Boolean)
    var
        MatDim_Record: Record "RLU Matrix Dimension";
        ConfirmMgt: Codeunit "Confirm Management";
        Text001_Err: Label 'Matrix Dimension not exist, you need to review transaction Dimension vs Matrix Dimension. Continue to post journal ?';
    begin
        MatDim_Record.SetRange(DimSetId, JobJnlLine."Dimension Set ID");
        if MatDim_Record.IsEmpty() then
            if not ConfirmMgt.GetResponseOrDefault(Text001_Err, true) then
                Error('Posting canceled');
    end;

    procedure GetDimSetID(BlockCode: Code[20]): Integer
    var
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        RLUMatrixDimension: Record "RLU Matrix Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Dimension: Record Dimension;
        SetID: Integer;
    begin
        GeneralLedgerSetup.FindFirst();
        if RLUMatrixDimension.Get(BlockCode) then begin
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension1Code) then
                if RLUMatrixDimension."Dimension 1" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension1Code, RLUMatrixDimension."Dimension 1") then begin
                        TempDimensionSetEntry.Init();
                        TempDimensionSetEntry."Dimension Set ID" := -1;
                        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension1Code;
                        TempDimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 1";
                        TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        TempDimensionSetEntry."Dimension Name" := Dimension.Name;
                        TempDimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 1 Name";
                        TempDimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension2Code) then
                if RLUMatrixDimension."Dimension 2" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension2Code, RLUMatrixDimension."Dimension 2") then begin
                        TempDimensionSetEntry.Init();
                        TempDimensionSetEntry."Dimension Set ID" := -1;
                        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension2Code;
                        TempDimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 2";
                        TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        TempDimensionSetEntry."Dimension Name" := Dimension.Name;
                        TempDimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 2 Name";
                        TempDimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension3Code) then
                if RLUMatrixDimension."Dimension 3" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension3Code, RLUMatrixDimension."Dimension 3") then begin
                        TempDimensionSetEntry.Init();
                        TempDimensionSetEntry."Dimension Set ID" := -1;
                        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension3Code;
                        TempDimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 3";
                        TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        TempDimensionSetEntry."Dimension Name" := Dimension.Name;
                        TempDimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 3 Name";
                        TempDimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension4Code) then
                if RLUMatrixDimension."Dimension 4" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension4Code, RLUMatrixDimension."Dimension 4") then begin
                        TempDimensionSetEntry.Init();
                        TempDimensionSetEntry."Dimension Set ID" := -1;
                        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension4Code;
                        TempDimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 4";
                        TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        TempDimensionSetEntry."Dimension Name" := Dimension.Name;
                        TempDimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 4 Name";
                        TempDimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension5Code) then
                if RLUMatrixDimension."Dimension 5" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension5Code, RLUMatrixDimension."Dimension 5") then begin
                        TempDimensionSetEntry.Init();
                        TempDimensionSetEntry."Dimension Set ID" := -1;
                        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension5Code;
                        TempDimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 5";
                        TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        TempDimensionSetEntry."Dimension Name" := Dimension.Name;
                        TempDimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 5 Name";
                        TempDimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension6Code) then
                if RLUMatrixDimension."Dimension 6" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension6Code, RLUMatrixDimension."Dimension 6") then begin
                        TempDimensionSetEntry.Init();
                        TempDimensionSetEntry."Dimension Set ID" := -1;
                        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension6Code;
                        TempDimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 6";
                        TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        TempDimensionSetEntry."Dimension Name" := Dimension.Name;
                        TempDimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 6 Name";
                        TempDimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension7Code) then
                if RLUMatrixDimension."Dimension 7" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension7Code, RLUMatrixDimension."Dimension 7") then begin
                        TempDimensionSetEntry.Init();
                        TempDimensionSetEntry."Dimension Set ID" := -1;
                        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension7Code;
                        TempDimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 7";
                        TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        TempDimensionSetEntry."Dimension Name" := Dimension.Name;
                        TempDimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 7 Name";
                        TempDimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension8Code) then
                if RLUMatrixDimension."Dimension 8" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension8Code, RLUMatrixDimension."Dimension 8") then begin
                        TempDimensionSetEntry.Init();
                        TempDimensionSetEntry."Dimension Set ID" := -1;
                        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension8Code;
                        TempDimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 8";
                        TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        TempDimensionSetEntry."Dimension Name" := Dimension.Name;
                        TempDimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 8 Name";
                        TempDimensionSetEntry.Insert();
                    end;
        end;

        SetID := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        exit(SetID);
    end;

    procedure InsertDimensionSetID(BlockCode: Code[20]; SetID: Integer)
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        RLUMatrixDimension: Record "RLU Matrix Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        Dimension: Record Dimension;
    begin
        GeneralLedgerSetup.FindFirst();
        if RLUMatrixDimension.Get(BlockCode) then begin
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension1Code) then
                if RLUMatrixDimension."Dimension 1" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension1Code, RLUMatrixDimension."Dimension 1") then begin
                        DimensionSetEntry.Init();
                        DimensionSetEntry."Dimension Set ID" := -1;
                        DimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension1Code;
                        DimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 1";
                        DimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        DimensionSetEntry."Dimension Name" := Dimension.Name;
                        DimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 1 Name";
                        DimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension2Code) then
                if RLUMatrixDimension."Dimension 2" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension2Code, RLUMatrixDimension."Dimension 2") then begin
                        DimensionSetEntry.Init();
                        DimensionSetEntry."Dimension Set ID" := SetID;
                        DimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension2Code;
                        DimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 2";
                        DimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        DimensionSetEntry."Dimension Name" := Dimension.Name;
                        DimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 2 Name";
                        DimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension3Code) then
                if RLUMatrixDimension."Dimension 3" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension3Code, RLUMatrixDimension."Dimension 3") then begin
                        DimensionSetEntry.Init();
                        DimensionSetEntry."Dimension Set ID" := SetID;
                        DimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension3Code;
                        DimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 3";
                        DimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        DimensionSetEntry."Dimension Name" := Dimension.Name;
                        DimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 3 Name";
                        DimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension4Code) then
                if RLUMatrixDimension."Dimension 4" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension4Code, RLUMatrixDimension."Dimension 4") then begin
                        DimensionSetEntry.Init();
                        DimensionSetEntry."Dimension Set ID" := SetID;
                        DimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension4Code;
                        DimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 4";
                        DimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        DimensionSetEntry."Dimension Name" := Dimension.Name;
                        DimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 4 Name";
                        DimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension5Code) then
                if RLUMatrixDimension."Dimension 5" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension5Code, RLUMatrixDimension."Dimension 5") then begin
                        DimensionSetEntry.Init();
                        DimensionSetEntry."Dimension Set ID" := SetID;
                        DimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension5Code;
                        DimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 5";
                        DimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        DimensionSetEntry."Dimension Name" := Dimension.Name;
                        DimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 5 Name";
                        DimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension6Code) then
                if RLUMatrixDimension."Dimension 6" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension6Code, RLUMatrixDimension."Dimension 6") then begin
                        DimensionSetEntry.Init();
                        DimensionSetEntry."Dimension Set ID" := SetID;
                        DimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension6Code;
                        DimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 6";
                        DimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        DimensionSetEntry."Dimension Name" := Dimension.Name;
                        DimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 6 Name";
                        DimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension7Code) then
                if RLUMatrixDimension."Dimension 7" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension7Code, RLUMatrixDimension."Dimension 7") then begin
                        DimensionSetEntry.Init();
                        DimensionSetEntry."Dimension Set ID" := SetID;
                        DimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension7Code;
                        DimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 7";
                        DimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        DimensionSetEntry."Dimension Name" := Dimension.Name;
                        DimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 7 Name";
                        DimensionSetEntry.Insert();
                    end;

            Dimension.Reset();
            DimensionValue.Reset();
            if Dimension.Get(GeneralLedgerSetup.MatrixDimension8Code) then
                if RLUMatrixDimension."Dimension 8" <> '' then
                    if DimensionValue.Get(GeneralLedgerSetup.MatrixDimension8Code, RLUMatrixDimension."Dimension 8") then begin
                        DimensionSetEntry.Init();
                        DimensionSetEntry."Dimension Set ID" := SetID;
                        DimensionSetEntry."Dimension Code" := GeneralLedgerSetup.MatrixDimension8Code;
                        DimensionSetEntry."Dimension Value Code" := RLUMatrixDimension."Dimension 8";
                        DimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                        DimensionSetEntry."Dimension Name" := Dimension.Name;
                        DimensionSetEntry."Dimension Value Name" := RLUMatrixDimension."Dimension 8 Name";
                        DimensionSetEntry.Insert();
                    end;
        end;
    end;
}