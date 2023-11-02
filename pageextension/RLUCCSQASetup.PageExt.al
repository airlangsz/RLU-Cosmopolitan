pageextension 50123 "RLU CCS QA Setup" extends "CCS QA Setup"
{
    layout
    {
        addlast(General)
        {
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                ToolTip = 'Specifies the name of the journal template you are creating.';
                ApplicationArea = All;
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ToolTip = 'Specifies the name of the journal that you are creating.';
                ApplicationArea = All;
            }
        }
    }
}
