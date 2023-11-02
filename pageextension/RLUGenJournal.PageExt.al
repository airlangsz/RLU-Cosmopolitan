pageextension 50104 "RLU Gen. Journal" extends "General Journal"
{
    layout
    {
        addafter("External Document No.")
        {
            field(TypeAudit; Rec.TypeAudit)
            {
                Caption = 'Audit Type';
                ToolTip = 'Audit Type';
                ApplicationArea = all;
                ShowMandatory = true;
            }
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Posting Date" <> 0D then
                    Rec.TypeAudit := Rec.TypeAudit::Unaudited;
            end;
        }
        addafter("Bal. Account No.")
        {
            field(BlockCode; Rec.BlockCode)
            {
                Caption = 'Block Code';
                ToolTip = 'Block Code';
                ApplicationArea = All;
                TableRelation = "RLU Matrix Dimension"."Block Code";

                trigger OnValidate()
                var
                    MatDim: Record "RLU Matrix Dimension";
                begin
                    if Rec.BlockCode <> '' then begin
                        MatDim.Reset();
                        MatDim.SetRange("Block Code", Rec.BlockCode);
                        if MatDim.FindLast() then
                            Rec.Validate("Dimension Set ID", MatDim.DimSetId);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec."Account No." <> '' then
            Rec.TypeAudit := Rec.TypeAudit::Unaudited;
    end;
}