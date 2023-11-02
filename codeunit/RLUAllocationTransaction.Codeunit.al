codeunit 50103 "RLU Allocation Transaction"
{
    procedure ProcessAllocationTransaction(RLUAllocationHeader: Record "RLU Allocation Header")
    var
        GLEntry: Record "G/L Entry";
        RLUAllocationMapping: Record "RLU Allocation Mapping";
        RLUMatrixDimension: Record "RLU Matrix Dimension";
        LineNoBasis: Integer;
        LineNoHectare: Integer;
        HectarePecentage: Decimal;
        "TotalHectareArea": Decimal;
    begin
        LineNoBasis := 10000;
        LineNoHectare := 10000;
        if RLUAllocationMapping.Get(RLUAllocationHeader."Allo Code") then begin

            //Allocation basis
            GLEntry.SetRange("Posting Date", RLUAllocationHeader."Date From", RLUAllocationHeader."Date To");
            GLEntry.SetRange("G/L Account No.", RLUAllocationMapping."Basis From", RLUAllocationMapping."Basis To");
            if GLEntry.FindSet() then
                repeat
                    InsertIntoAllocationBasis(RLUAllocationHeader."Allo Trans No", LineNoBasis, GLEntry."G/L Account No.", GLEntry.Description, GLEntry.Amount);
                    LineNoBasis := LineNoBasis + 10000;
                until GLEntry.Next() = 0;

            //Allocation hectare area
            RLUMatrixDimension.SetRange(CreatedDimSet, true);
            RLUMatrixDimension.SetRange(Include, true);
            RLUMatrixDimension.CalcSums("Hectare Area");
            TotalHectareArea := RLUMatrixDimension."Hectare Area";

            RLUMatrixDimension.Reset();
            RLUMatrixDimension.SetRange(CreatedDimSet, true);
            RLUMatrixDimension.SetRange(Include, true);
            if RLUMatrixDimension.FindSet() then
                repeat
                    HectarePecentage := RLUMatrixDimension."Hectare Area" / TotalHectareArea;
                    InsertIntoAllocationHectareArea(RLUAllocationHeader."Allo Trans No", LineNoHectare, RLUMatrixDimension."Block Code", RLUMatrixDimension.Description, RLUMatrixDimension.Type, RLUMatrixDimension."Hectare Area", HectarePecentage);
                    LineNoHectare := LineNoHectare + 10000;
                until RLUMatrixDimension.Next() = 0
            else
                Error('Created dimension set ID not found');

        end else
            Error('Allocation Mapping Code not found');
    end;

    procedure ProcessAllocationSummaryDetail(RLUAllocationHeader: Record "RLU Allocation Header")
    var
        RLUAllocationHectareArea: Record "RLU Allocation Hectare Area";
        RLUAllocationMapping: Record "RLU Allocation Mapping";
        LineNoDetail: Integer;
        LineNoSummary: Integer;
        Percent: Decimal;
        Basis: Decimal;
    begin
        LineNoDetail := 10000;
        LineNoSummary := 10000;
        if RLUAllocationMapping.Get(RLUAllocationHeader."Allo Code") then begin

            //Allocation basis
            RLUAllocationHectareArea.SetRange("Allo Trans No", RLUAllocationHeader."Allo Trans No");
            if RLUAllocationHectareArea.FindSet() then
                repeat
                    Basis := GetAlloBasisOffset(RLUAllocationHeader."Allo Trans No");
                    Percent := GetAlloPercent(RLUAllocationHeader."Allo Trans No");
                    InsertIntoAllocationResultDetail(RLUAllocationHeader."Allo Trans No", LineNoDetail, RLUAllocationHectareArea."Hectare Percentage", RLUAllocationHeader."Allo Code", RLUAllocationHectareArea."Block Code", RLUAllocationMapping."Target Immature", RLUAllocationMapping."Target Mature", RLUAllocationHectareArea.Type, Basis);
                    LineNoDetail := LineNoDetail + 30000;
                until RLUAllocationHectareArea.Next() = 0;

            InsertIntoAllocationResultDetailNon(RLUAllocationHeader."Allo Trans No", LineNoDetail, RLUAllocationHectareArea."Hectare Percentage", RLUAllocationHeader."Allo Code", RLUAllocationHectareArea."Block Code", RLUAllocationMapping.Offset, RLUAllocationMapping."COGS Mature", RLUAllocationMapping."COGS Mature Offset", RLUAllocationHectareArea.Type, Basis, RLUAllocationMapping."Block Code Other", Percent);

            InsertIntoAllocationResultSummary(RLUAllocationHeader."Allo Trans No", LineNoSummary, RLUAllocationHeader."Allo Code", RLUAllocationMapping."Target Immature", RLUAllocationMapping.Offset, RLUAllocationMapping."Target Mature", RLUAllocationMapping."COGS Mature", RLUAllocationMapping."COGS Mature Offset", Basis, Percent);

            RLUAllocationHeader.Status := RLUAllocationHeader.Status::"In Process";
            RLUAllocationHeader.Modify();
            Message('Success');
        end else
            Error('Allocation Mapping Code not found');
    end;

    local procedure GetAlloBasisOffset(AlloTransNo: Integer): Decimal
    var
        RLUAllocationBasis: Record "RLU Allocation Basis";
    begin
        RLUAllocationBasis.SetRange("Allo Trans No", AlloTransNo);
        RLUAllocationBasis.CalcSums("Allo Basis Balance");
        exit(RLUAllocationBasis."Allo Basis Balance");
    end;

    local procedure GetAlloPercent(AlloTransNo: Integer): Decimal
    var
        RLUAllocationHectareArea: Record "RLU Allocation Hectare Area";
    begin
        RLUAllocationHectareArea.SetRange("Allo Trans No", AlloTransNo);
        RLUAllocationHectareArea.SetRange(Type, RLUAllocationHectareArea.Type::Mature);
        RLUAllocationHectareArea.CalcSums("Hectare Percentage");
        exit(RLUAllocationHectareArea."Hectare Percentage");
    end;

    procedure DeleteAllocationTransaction(RLUAllocationHeader: Record "RLU Allocation Header")
    var
        RLUAllocationBasis: Record "RLU Allocation Basis";
        RLUAllocationHectareArea: Record "RLU Allocation Hectare Area";
        RLUAllocationResultDetail: Record "RLU Allocation Result Detail";
        RLUAllocationResultSummary: Record "RLU Allocation Result Summary";
        AlloTransNo: Integer;
    begin
        AlloTransNo := RLUAllocationHeader."Allo Trans No";
        RLUAllocationBasis.SetRange("Allo Trans No", AlloTransNo);
        RLUAllocationBasis.DeleteAll();

        RLUAllocationHectareArea.SetRange("Allo Trans No", AlloTransNo);
        RLUAllocationHectareArea.DeleteAll();

        RLUAllocationResultDetail.SetRange("Allo Trans No", AlloTransNo);
        RLUAllocationResultDetail.DeleteAll();

        RLUAllocationResultSummary.SetRange("Allo Trans No", AlloTransNo);
        RLUAllocationResultSummary.DeleteAll();

        RLUAllocationHeader.Status := RLUAllocationHeader.Status::Open;
        RLUAllocationHeader.Modify();
        Message('Success');
    end;

    procedure PostAllocationTransaction(RLUAllocationHeader: Record "RLU Allocation Header")
    var
        RLUAllocationResultDetail: Record "RLU Allocation Result Detail";
        RLUAllocationMapping: Record "RLU Allocation Mapping";
        GenJournalBatch: Record "Gen. Journal Batch";
        GeneralLedgerSetup: Record "General Ledger Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LineNo: Integer;
        DocNo: Code[20];
    begin
        LineNo := 10000;
        if RLUAllocationMapping.Get(RLUAllocationHeader."Allo Code") then begin

            GeneralLedgerSetup.FindFirst();
            GenJournalBatch.SetRange("Journal Template Name", 'GENERAL');
            GenJournalBatch.SetRange("No. Series", GeneralLedgerSetup."Allo Journal");
            if GenJournalBatch.FindFirst() then
                DocNo := NoSeriesManagement.GetNextNo(GenJournalBatch."Posting No. Series", 0D, true);

            //Allocation basis
            RLUAllocationResultDetail.SetRange("Allo Trans No", RLUAllocationHeader."Allo Trans No");
            if RLUAllocationResultDetail.FindSet() then
                repeat
                    InsertAllocationToGenJournalLine(RLUAllocationHeader."Posting Date", RLUAllocationResultDetail."Block Code", RLUAllocationResultDetail."GL Account No", RLUAllocationResultDetail."GL Description", RLUAllocationResultDetail."Allo Result Balance", LineNo, DocNo);
                    LineNo := LineNo + 10000;
                until RLUAllocationResultDetail.Next() = 0;

            RLUAllocationHeader.Status := RLUAllocationHeader.Status::Posted;
            RLUAllocationHeader.Modify();
            Message('Success');
        end else
            Error('Allocation Mapping Code not found');
    end;

    procedure InsertAllocationToGenJournalLine(PostingDate: Date; BlockCode: Code[20]; AccountNo: Code[20]; Description: Text[100]; AlloResultBalance: Decimal; LineNo: Integer; DocNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        RLUMatrixDimension: record "RLU Matrix Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimSetID: Integer;
    begin
        GeneralLedgerSetup.FindFirst();
        if RLUMatrixDimension.Get(BlockCode) then
            DimSetID := RLUMatrixDimension.DimSetId;

        GenJournalLine.Init();
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := GeneralLedgerSetup."Allo Journal";
        GenJournalLine."Document No." := FORMAT(DocNo);
        GenJournalLine."Posting Date" := PostingDate;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Description := Description;
        GenJournalLine."Currency Code" := GeneralLedgerSetup."LCY Code";
        GenJournalLine.BlockCode := BlockCode;
        GenJournalLine.Amount := AlloResultBalance;
        GenJournalLine."Amount (LCY)" := AlloResultBalance;
        GenJournalLine."Dimension Set ID" := DimSetID;
        GenJournalLine."Shortcut Dimension 1 Code" := RLUMatrixDimension."Dimension 1";
        GenJournalLine."Shortcut Dimension 2 Code" := RLUMatrixDimension."Dimension 2";
        if AlloResultBalance < 0 then
            GenJournalLine."Credit Amount" := AlloResultBalance
        else
            GenJournalLine."Debit Amount" := AlloResultBalance;

        GenJournalLine.Insert();
    end;


    procedure InsertIntoAllocationBasis(TransNo: Integer; LineNo: Integer; AccountNo: Code[20]; Description: Text[100]; Amount: Decimal)
    var
        RLUAllocationBasis: Record "RLU Allocation Basis";
    begin
        RLUAllocationBasis.Init();
        RLUAllocationBasis."Allo Trans No" := TransNo;
        RLUAllocationBasis."Line No" := LineNo;
        RLUAllocationBasis."GL Account No" := AccountNo;
        RLUAllocationBasis."GL Description" := Description;
        RLUAllocationBasis."Allo Basis Balance" := Amount;
        RLUAllocationBasis.Insert();
    end;

    procedure InsertIntoAllocationHectareArea(TransNo: Integer; LineNo: Integer; BlockCode: Code[20]; Desc: Text[250]; Type: Option; HectareArea: Integer; HectarePercentage: Decimal)
    var
        RLUAllocationHectareArea: Record "RLU Allocation Hectare Area";
    begin
        RLUAllocationHectareArea.Init();
        RLUAllocationHectareArea."Allo Trans No" := TransNo;
        RLUAllocationHectareArea."Line No" := LineNo;
        RLUAllocationHectareArea."Block Code" := BlockCode;
        RLUAllocationHectareArea.Description := Desc;
        RLUAllocationHectareArea.Type := Type;
        RLUAllocationHectareArea."Hectare Area" := HectareArea;
        RLUAllocationHectareArea."Hectare Percentage" := HectarePercentage * 100;
        RLUAllocationHectareArea.Insert();
    end;

    procedure InsertIntoAllocationResultDetail(AlloTransNo: Integer; LineNo: Integer; HectarePercentage: Decimal; AlloCode: Code[20]; BlockCode: Code[20]; TargetImmature: Code[20]; "TargetMature": Code[20]; "Type": Option "",Mature,Immature; Basis: Decimal)
    var
        RLUAllocationResultDetail: Record "RLU Allocation Result Detail";
        GLAccount: Record "G/L Account";
    begin
        if Type = Type::Immature then begin
            RLUAllocationResultDetail.Init();
            RLUAllocationResultDetail."Allo Trans No" := AlloTransNo;
            RLUAllocationResultDetail."Line No" := LineNo;
            RLUAllocationResultDetail."Allo Code" := AlloCode;
            RLUAllocationResultDetail."Block Code" := BlockCode;
            RLUAllocationResultDetail."GL Account No" := TargetImmature;
            if GLAccount.Get(TargetImmature) then
                RLUAllocationResultDetail."GL Description" := GLAccount."Name";
            RLUAllocationResultDetail."Allo Result Balance" := Basis * (HectarePercentage / 100);
            RLUAllocationResultDetail.Insert();
        end;

        if Type = Type::Mature then begin
            LineNo := LineNo + 10000;
            RLUAllocationResultDetail.Init();
            RLUAllocationResultDetail."Allo Trans No" := AlloTransNo;
            RLUAllocationResultDetail."Line No" := LineNo;
            RLUAllocationResultDetail."Allo Code" := AlloCode;
            RLUAllocationResultDetail."Block Code" := BlockCode;
            RLUAllocationResultDetail."GL Account No" := TargetMature;
            GLAccount.Reset();
            if GLAccount.Get(TargetMature) then
                RLUAllocationResultDetail."GL Description" := GLAccount."Name";
            RLUAllocationResultDetail."Allo Result Balance" := Basis * (HectarePercentage / 100);
            RLUAllocationResultDetail.Insert();
        end;
    end;

    procedure InsertIntoAllocationResultDetailNon(AlloTransNo: Integer; LineNo: Integer; HectarePercentage: Decimal; AlloCode: Code[20]; BlockCode: Code[20]; Offset: Code[20]; "COGSMature": Code[20]; "COGSMatureOffset": Code[20]; "Type": Option "",Mature,Immature; Basis: Decimal; "Block Code Other": Code[20]; Percent: Decimal)
    var
        RLUAllocationResultDetail: Record "RLU Allocation Result Detail";
        GLAccount: Record "G/L Account";
    begin
        RLUAllocationResultDetail.Init();
        RLUAllocationResultDetail."Allo Trans No" := AlloTransNo;
        RLUAllocationResultDetail."Line No" := LineNo;
        RLUAllocationResultDetail."Allo Code" := AlloCode;
        RLUAllocationResultDetail."Block Code" := "Block Code Other";
        RLUAllocationResultDetail."GL Account No" := Offset;
        GLAccount.Reset();
        if GLAccount.Get(Offset) then
            RLUAllocationResultDetail."GL Description" := GLAccount."Name";
        RLUAllocationResultDetail."Allo Result Balance" := Basis * -1;
        RLUAllocationResultDetail.Insert();

        LineNo := LineNo + 10000;
        RLUAllocationResultDetail.Init();
        RLUAllocationResultDetail."Allo Trans No" := AlloTransNo;
        RLUAllocationResultDetail."Line No" := LineNo;
        RLUAllocationResultDetail."Allo Code" := AlloCode;
        RLUAllocationResultDetail."Block Code" := "Block Code Other";
        RLUAllocationResultDetail."GL Account No" := COGSMature;
        GLAccount.Reset();
        if GLAccount.Get(COGSMature) then
            RLUAllocationResultDetail."GL Description" := GLAccount."Name";
        RLUAllocationResultDetail."Allo Result Balance" := (Percent / 100) * Basis;
        RLUAllocationResultDetail.Insert();

        LineNo := LineNo + 10000;
        RLUAllocationResultDetail.Init();
        RLUAllocationResultDetail."Allo Trans No" := AlloTransNo;
        RLUAllocationResultDetail."Line No" := LineNo;
        RLUAllocationResultDetail."Allo Code" := AlloCode;
        RLUAllocationResultDetail."Block Code" := "Block Code Other";
        RLUAllocationResultDetail."GL Account No" := COGSMatureOffset;
        GLAccount.Reset();
        if GLAccount.Get(COGSMatureOffset) then
            RLUAllocationResultDetail."GL Description" := GLAccount."Name";
        RLUAllocationResultDetail."Allo Result Balance" := (Percent / 100) * Basis * -1;
        RLUAllocationResultDetail.Insert();
    end;

    procedure InsertIntoAllocationResultSummary(AlloTransNo: Integer; LineNo: Integer; AlloCode: Code[20]; TargetImmature: Code[20]; Offset: Code[20]; "TargetMature": Code[20]; "COGSMature": Code[20]; "COGSMatureOffset": Code[20]; Basis: Decimal; Percent: Decimal)
    var
        RLUAllocationResultSummary: Record "RLU Allocation Result Summary";
        GLAccount: Record "G/L Account";
        RLUAllocationResultDetail: Record "RLU Allocation Result Detail";
    begin
        RLUAllocationResultSummary.Init();
        RLUAllocationResultSummary."Allo Trans No" := AlloTransNo;
        RLUAllocationResultSummary."Line No" := LineNo;
        RLUAllocationResultSummary."Allo Code" := AlloCode;
        RLUAllocationResultSummary."GL Account No" := TargetMature;
        if GLAccount.Get(TargetMature) then
            RLUAllocationResultSummary."GL Description" := GLAccount."Name";
        RLUAllocationResultDetail.SetRange("Allo Trans No", AlloTransNo);
        RLUAllocationResultDetail.SetRange("GL Account No", TargetMature);
        RLUAllocationResultDetail.CalcSums("Allo Result Balance");
        RLUAllocationResultSummary."Allo Result Balance" := RLUAllocationResultDetail."Allo Result Balance";
        RLUAllocationResultSummary.Insert();

        LineNo := LineNo + 10000;
        RLUAllocationResultSummary.Init();
        RLUAllocationResultSummary."Allo Trans No" := AlloTransNo;
        RLUAllocationResultSummary."Line No" := LineNo;
        RLUAllocationResultSummary."Allo Code" := AlloCode;
        RLUAllocationResultSummary."GL Account No" := TargetImmature;
        GLAccount.Reset();
        if GLAccount.Get(TargetImmature) then
            RLUAllocationResultSummary."GL Description" := GLAccount."Name";
        RLUAllocationResultDetail.Reset();
        RLUAllocationResultDetail.SetRange("Allo Trans No", AlloTransNo);
        RLUAllocationResultDetail.SetRange("GL Account No", TargetImmature);
        RLUAllocationResultDetail.CalcSums("Allo Result Balance");
        RLUAllocationResultSummary."Allo Result Balance" := RLUAllocationResultDetail."Allo Result Balance";
        RLUAllocationResultSummary.Insert();

        LineNo := LineNo + 10000;
        RLUAllocationResultSummary.Init();
        RLUAllocationResultSummary."Allo Trans No" := AlloTransNo;
        RLUAllocationResultSummary."Line No" := LineNo;
        RLUAllocationResultSummary."Allo Code" := AlloCode;
        RLUAllocationResultSummary."GL Account No" := Offset;
        GLAccount.Reset();
        if GLAccount.Get(Offset) then
            RLUAllocationResultSummary."GL Description" := GLAccount."Name";
        RLUAllocationResultSummary."Allo Result Balance" := Basis * -1;
        RLUAllocationResultSummary.Insert();

        LineNo := LineNo + 10000;
        RLUAllocationResultSummary.Init();
        RLUAllocationResultSummary."Allo Trans No" := AlloTransNo;
        RLUAllocationResultSummary."Line No" := LineNo;
        RLUAllocationResultSummary."Allo Code" := AlloCode;
        RLUAllocationResultSummary."GL Account No" := COGSMature;
        GLAccount.Reset();
        if GLAccount.Get(COGSMature) then
            RLUAllocationResultSummary."GL Description" := GLAccount."Name";
        RLUAllocationResultSummary."Allo Result Balance" := (Percent / 100) * Basis;
        RLUAllocationResultSummary.Insert();

        LineNo := LineNo + 10000;
        RLUAllocationResultSummary.Init();
        RLUAllocationResultSummary."Allo Trans No" := AlloTransNo;
        RLUAllocationResultSummary."Line No" := LineNo;
        RLUAllocationResultSummary."Allo Code" := AlloCode;
        RLUAllocationResultSummary."GL Account No" := COGSMatureOffset;
        GLAccount.Reset();
        if GLAccount.Get(COGSMatureOffset) then
            RLUAllocationResultSummary."GL Description" := GLAccount."Name";
        RLUAllocationResultSummary."Allo Result Balance" := (Percent / 100) * Basis * -1;
        RLUAllocationResultSummary.Insert();
    end;



}