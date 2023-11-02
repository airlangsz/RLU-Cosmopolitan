pageextension 50131 "RLU Gen. Journal Batches" extends "General Journal Batches"
{
    layout
    {
        addafter("No. Series")
        {
            field(TypeAudit; Rec.TypeAudit)
            {
                ApplicationArea = all;
                Caption = 'Type Audit';
                ToolTip = 'Type Audit';
                trigger OnValidate()
                var

                begin

                end;
            }
        }
    }
    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     if Rec.TypeAudit <> not then
    //         Rec.TypeAudit := Rec.TypeAudit::Unaudited;
    // end;
}