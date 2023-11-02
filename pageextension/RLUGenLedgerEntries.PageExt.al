pageextension 50103 "RLU Gen. Ledger Entries" extends "General Ledger Entries"
{
    Editable = true;

    layout
    {
        addafter("External Document No.")
        {
            field(TypeAudit; Rec.TypeAudit)
            {
                Caption = 'Audit Type';
                ToolTip = 'Audit Type';
                ApplicationArea = all;
            }
        }

        addafter("Additional-Currency Amount")
        {
            field("Exchange Rate"; Rec."Exchange Rate")
            {
                Caption = 'Exchange Rate';
                ToolTip = 'Exchange Rate';
                ApplicationArea = all;
                Editable = false;
                TableRelation = "G/L Entry";
            }
        }
    }
}