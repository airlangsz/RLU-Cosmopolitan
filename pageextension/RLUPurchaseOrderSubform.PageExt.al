pageextension 50120 "RLU Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("RLU Origin Area Code"; Rec."RLU Origin Area Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the valu7e of the RLU Origin Area Code field.';
            }
            field("RLU Supplier Category Code"; Rec."RLU Supplier Category Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RLU Supplier Category Code field.';
            }
            field("RLU DRC Percentage"; Rec."RLU DRC Percentage")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the DRC %-tage field.';
            }
        }
    }
}
