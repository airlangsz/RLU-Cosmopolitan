page 50100 "RLU Matrix Dimension"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RLU Matrix Dimension";
    Permissions = tabledata "Dimension Set Entry" = rimd,
                    tabledata "Dimension Set ID Filter Line" = rimd,
                    tabledata "Dimension Set Tree Node" = rimd;
    Caption = 'Matrix Dimension';

    layout
    {
        area(Content)
        {
            repeater("Dimension Values")
            {
                field("Block Code"; Rec."Block Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Block code';
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Type';
                }

                field("Hectare Area"; Rec."Hectare Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hectare Area';
                }
                field("Stand per Hectare"; Rec."Stand per Hectare")
                {
                    ApplicationArea = All;
                    ToolTip = 'Stand per Hectare';
                }
                field("Dimension 1"; Rec."Dimension 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 1';
                    TableRelation = "Dimension Value".Code;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if GLSetRec.Get() then
                            if StrLen(GLSetRec.MatrixDimension1Code) > 0 then begin
                                DimValRec.Reset();
                                DimValRec.SetRange(DimValRec."Dimension Code", GLSetRec.MatrixDimension1Code);
                                DimValRec.SetRange(DimValRec."Dimension Value Type", DimValRec."Dimension Value Type"::Standard);
                                DimValRec.SetRange(DimValRec.Blocked, false);
                                if Page.RunModal(Page::"Dimension Values", DimValRec) = Action::LookupOK then
                                    Rec."Dimension 1" := DimValRec.Code;
                                Rec."Dimension 1 Name" := DimValRec.Name;
                                // Rec.Modify();
                            end else
                                Error('Matrix Dimension 1 Code is empty! Please set it up in General Ledger Setup.');
                    end;

                    trigger OnValidate()
                    begin
                        GLSetRec.Get();
                        if DimValRec.Get(GLSetRec.MatrixDimension1Code, Rec."Dimension 1") then
                            Rec."Dimension 1 Name" := DimValRec.Name;
                    end;
                }
                field("Dimension 1 Name"; Rec."Dimension 1 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 1 Name';
                    Editable = false;
                }
                field("Dimension 2"; Rec."Dimension 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 2';

                    trigger OnLookup(var Text: Text): Boolean


                    begin
                        if GLSetRec.Get() then
                            if StrLen(GLSetRec.MatrixDimension2Code) > 0 then begin
                                DimValRec.Reset();
                                DimValRec.SetRange(DimValRec."Dimension Code", GLSetRec.MatrixDimension2Code);
                                DimValRec.SetRange(DimValRec."Dimension Value Type", DimValRec."Dimension Value Type"::Standard);
                                DimValRec.SetRange(DimValRec.Blocked, false);
                                if Page.RunModal(Page::"Dimension Values", DimValRec) = Action::LookupOK then
                                    Rec."Dimension 2" := DimValRec.Code;
                                Rec."Dimension 2 Name" := DimValRec.Name;
                                // Rec.Modify();
                            end else
                                Error('Matrix Dimension 2 Code is empty! Please set it up in General Ledger Setup.');
                    end;

                    trigger OnValidate()
                    begin
                        GLSetRec.Get();
                        if DimValRec.Get(GLSetRec.MatrixDimension2Code, Rec."Dimension 2") then
                            Rec."Dimension 2 Name" := DimValRec.Name;
                    end;
                }
                field("Dimension 2 Name"; Rec."Dimension 2 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 2 Name';
                    Editable = false;
                }
                field("Dimension 3"; Rec."Dimension 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 3';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if GLSetRec.Get() then
                            if StrLen(GLSetRec.MatrixDimension3Code) > 0 then begin
                                DimValRec.Reset();
                                DimValRec.SetRange(DimValRec."Dimension Code", GLSetRec.MatrixDimension3Code);
                                DimValRec.SetRange(DimValRec."Dimension Value Type", DimValRec."Dimension Value Type"::Standard);
                                DimValRec.SetRange(DimValRec.Blocked, false);
                                if Page.RunModal(Page::"Dimension Values", DimValRec) = Action::LookupOK then
                                    Rec."Dimension 3" := DimValRec.Code;
                                Rec."Dimension 3 Name" := DimValRec.Name;
                                // Rec.Modify();
                            end else
                                Error('Matrix Dimension 3 Code is empty! Please set it up in General Ledger Setup.');
                    end;

                    trigger OnValidate()
                    begin
                        GLSetRec.Get();
                        if DimValRec.Get(GLSetRec.MatrixDimension3Code, Rec."Dimension 3") then
                            Rec."Dimension 3 Name" := DimValRec.Name;
                    end;
                }
                field("Dimension 3 Name"; Rec."Dimension 3 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 3 Name';
                    Editable = false;
                }
                field("Dimension 4"; Rec."Dimension 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 4';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if GLSetRec.Get() then
                            if StrLen(GLSetRec.MatrixDimension4Code) > 0 then begin
                                DimValRec.Reset();
                                DimValRec.SetRange(DimValRec."Dimension Code", GLSetRec.MatrixDimension4Code);
                                DimValRec.SetRange(DimValRec."Dimension Value Type", DimValRec."Dimension Value Type"::Standard);
                                DimValRec.SetRange(DimValRec.Blocked, false);
                                if Page.RunModal(Page::"Dimension Values", DimValRec) = Action::LookupOK then
                                    Rec."Dimension 4" := DimValRec.Code;
                                Rec."Dimension 4 Name" := DimValRec.Name;
                                // Rec.Modify();
                            end else
                                Error('Matrix Dimension 4 Code is empty! Please set it up in General Ledger Setup.');
                    end;

                    trigger OnValidate()
                    begin
                        GLSetRec.Get();
                        if DimValRec.Get(GLSetRec.MatrixDimension4Code, Rec."Dimension 4") then
                            Rec."Dimension 4 Name" := DimValRec.Name;
                    end;
                }
                field("Dimension 4 Name"; Rec."Dimension 4 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 4 Name';
                    Editable = false;
                }
                field("Dimension 5"; Rec."Dimension 5")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 5';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if GLSetRec.Get() then
                            if StrLen(GLSetRec.MatrixDimension5Code) > 0 then begin
                                DimValRec.Reset();
                                DimValRec.SetRange(DimValRec."Dimension Code", GLSetRec.MatrixDimension5Code);
                                DimValRec.SetRange(DimValRec."Dimension Value Type", DimValRec."Dimension Value Type"::Standard);
                                DimValRec.SetRange(DimValRec.Blocked, false);
                                if Page.RunModal(Page::"Dimension Values", DimValRec) = Action::LookupOK then
                                    Rec."Dimension 5" := DimValRec.Code;
                                Rec."Dimension 5 Name" := DimValRec.Name;
                                // Rec.Modify();
                            end else
                                Error('Matrix Dimension 5 Code is empty! Please set it up in General Ledger Setup.');
                    end;

                    trigger OnValidate()
                    begin
                        GLSetRec.Get();
                        if DimValRec.Get(GLSetRec.MatrixDimension5Code, Rec."Dimension 5") then
                            Rec."Dimension 5 Name" := DimValRec.Name;
                    end;
                }
                field("Dimension 5 Name"; Rec."Dimension 5 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 5 Name';
                    Editable = false;
                }
                field("Dimension 6"; Rec."Dimension 6")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 6';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if GLSetRec.Get() then
                            if StrLen(GLSetRec.MatrixDimension6Code) > 0 then begin
                                DimValRec.Reset();
                                DimValRec.SetRange(DimValRec."Dimension Code", GLSetRec.MatrixDimension6Code);
                                DimValRec.SetRange(DimValRec."Dimension Value Type", DimValRec."Dimension Value Type"::Standard);
                                DimValRec.SetRange(DimValRec.Blocked, false);
                                if Page.RunModal(Page::"Dimension Values", DimValRec) = Action::LookupOK then
                                    Rec."Dimension 6" := DimValRec.Code;
                                Rec."Dimension 6 Name" := DimValRec.Name;
                                // Rec.Modify();
                            end else
                                Error('Matrix Dimension 6 Code is empty! Please set it up in General Ledger Setup.');
                    end;

                    trigger OnValidate()
                    begin
                        GLSetRec.Get();
                        if DimValRec.Get(GLSetRec.MatrixDimension6Code, Rec."Dimension 6") then
                            Rec."Dimension 6 Name" := DimValRec.Name;
                    end;
                }
                field("Dimension 6 Name"; Rec."Dimension 6 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 6 Name';
                    Editable = false;
                }
                field("Dimension 7"; Rec."Dimension 7")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 7';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if GLSetRec.Get() then
                            if StrLen(GLSetRec.MatrixDimension7Code) > 0 then begin
                                DimValRec.Reset();
                                DimValRec.SetRange(DimValRec."Dimension Code", GLSetRec.MatrixDimension7Code);
                                DimValRec.SetRange(DimValRec."Dimension Value Type", DimValRec."Dimension Value Type"::Standard);
                                DimValRec.SetRange(DimValRec.Blocked, false);
                                if Page.RunModal(Page::"Dimension Values", DimValRec) = Action::LookupOK then
                                    Rec."Dimension 7" := DimValRec.Code;
                                Rec."Dimension 7 Name" := DimValRec.Name;
                                // Rec.Modify();
                            end else
                                Error('Matrix Dimension 7 Code is empty! Please set it up in General Ledger Setup.');
                    end;

                    trigger OnValidate()
                    begin
                        GLSetRec.Get();
                        if DimValRec.Get(GLSetRec.MatrixDimension7Code, Rec."Dimension 7") then
                            Rec."Dimension 7 Name" := DimValRec.Name;
                    end;
                }
                field("Dimension 7 Name"; Rec."Dimension 7 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 7 Name';
                    Editable = false;
                }
                field("Dimension 8"; Rec."Dimension 8")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 8';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if GLSetRec.Get() then
                            if StrLen(GLSetRec.MatrixDimension8Code) > 0 then begin
                                DimValRec.Reset();
                                DimValRec.SetRange(DimValRec."Dimension Code", GLSetRec.MatrixDimension8Code);
                                DimValRec.SetRange(DimValRec."Dimension Value Type", DimValRec."Dimension Value Type"::Standard);
                                DimValRec.SetRange(DimValRec.Blocked, false);
                                if Page.RunModal(Page::"Dimension Values", DimValRec) = Action::LookupOK then
                                    Rec."Dimension 8" := DimValRec.Code;
                                Rec."Dimension 8 Name" := DimValRec.Name;
                                // Rec.Modify();
                            end else
                                Error('Matrix Dimension 8 Code is empty! Please set it up in General Ledger Setup.');
                    end;

                    trigger OnValidate()
                    begin
                        GLSetRec.Get();
                        if DimValRec.Get(GLSetRec.MatrixDimension8Code, Rec."Dimension 8") then
                            Rec."Dimension 8 Name" := DimValRec.Name;
                    end;
                }
                field("Dimension 8 Name"; Rec."Dimension 8 Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension 8 Name';
                    Editable = false;
                }
                field(Include; Rec.Include)
                {
                    ApplicationArea = All;
                    ToolTip = 'Include for Allocation';
                }
                field(CreatedDimSet; Rec.CreatedDimSet)
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension Set Entry already created or not';
                }
                field(DimSetId; Rec.DimSetId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension Set ID';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Dim Set")
            {
                ApplicationArea = All;
                Image = CreateInteraction;
                ToolTip = 'Create new dimension set entry';

                trigger OnAction();
                var
                    RLUMatrixDimension: Record "RLU Matrix Dimension";
                    DimensionSetEntry: Record "Dimension Set Entry";
                    RLUDimension: Codeunit "RLU Dimension";
                    RecRef: RecordRef;
                    DimSetID: Integer;
                begin
                    RLUMatrixDimension.Reset();
                    CurrPage.SetSelectionFilter(RLUMatrixDimension);
                    RecRef.GetTable(RLUMatrixDimension);
                    SelectionFilterManagement.GetSelectionFilter(RecRef, RLUMatrixDimension.FieldNo("Block Code"));
                    if RLUMatrixDimension.FindSet() then
                        repeat
                            // if RLUMatrixDimension.CreatedDimSet then
                            //     Error('Matrix Dimension Combination with Block Code %1 already Created', RLUMatrixDimension."Block Code")
                            // else 
                            // begin
                            DimSetID := RLUDimension.GetDimSetID(RLUMatrixDimension."Block Code");

                            DimensionSetEntry.SetRange("Dimension Set ID", DimSetID);
                            if DimensionSetEntry.IsEmpty() then
                                RLUDimension.InsertDimensionSetID(RLUMatrixDimension."Block Code", DimSetID);

                            RLUMatrixDimension.CreatedDimSet := true;
                            RLUMatrixDimension.DimSetId := DimSetID;
                            RLUMatrixDimension.Modify();
                            Message('Success');
                        // end;
                        until RLUMatrixDimension.Next() = 0;

                end;
            }
            action("Delete Matrix")
            {
                ApplicationArea = All;
                Image = Delete;
                ToolTip = 'Delete selected matrix record and the dimension set entry';

                trigger OnAction();
                var
                    MatrixDimRec: Record "RLU Matrix Dimension";
                    DimSetEntryRec: Record "Dimension Set Entry";
                    RecRef: RecordRef;
                    ConfirmMsg: Boolean;
                begin
                    MatrixDimRec.Reset();
                    CurrPage.SetSelectionFilter(MatrixDimRec);
                    RecRef.GetTable(MatrixDimRec);
                    SelectionFilterManagement.GetSelectionFilter(RecRef, MatrixDimRec.FieldNo("Block Code"));
                    if MatrixDimRec.FindSet() then
                        repeat
                        until MatrixDimRec.Next() = 0;
                    ConfirmMsg := Confirm('Are you sure want to delete the selected Matrix Dimension?');

                    if ConfirmMsg then
                        DimSetEntryRec.SetRange("Dimension Set ID", MatrixDimRec.DimSetId);
                    if DimSetEntryRec.FindSet() then
                        repeat
                        until DimSetEntryRec.Next() = 0;
                    DimSetEntryRec.DeleteAll();
                    MatrixDimRec.Delete();
                end;
            }
        }
    }

    var
        GLSetRec: Record "General Ledger Setup";
        DimValRec: Record "Dimension Value";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
}