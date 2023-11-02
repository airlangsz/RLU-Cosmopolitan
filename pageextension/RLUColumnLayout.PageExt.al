pageextension 50105 "RLU Column Layout" extends "Column Layout"
{
    layout
    {
        addafter("Amount Type")
        {
            field(TypeAudit; Rec.TypeAudit)
            {
                ToolTip = 'Type Audit';
                Caption = 'Type Audit';
                ApplicationArea = all;
            }
        }
    }
    
}