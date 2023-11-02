pageextension 50119 "RLU Price List Lines" extends "Price List Lines"
{
    layout
    {
        addafter("Variant Code Lookup")
        {
            field("RLU Supplier Category"; Rec."RLU Supplier Category Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier Category field.';
            }
            field("RLU DRC Percentage"; Rec."RLU DRC Percentage")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the DRC Percentage field.';
            }
        }
    }
}
