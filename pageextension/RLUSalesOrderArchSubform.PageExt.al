pageextension 50122 "RLU Sales Order Arch Subform" extends "Sales Order Archive Subform"
{
    layout
    {
        addafter("No.")
        {
            field("RLU SMPT Lot No"; Rec."RLU SMPT Lot No")
            {
                ApplicationArea = All;
                ToolTip = 'SMPT Lot No';
            }
            field("RLU MKC Lot No"; Rec."RLU MKC Lot No")
            {
                ApplicationArea = All;
                ToolTip = 'MKC Lot No';
            }
            field("RLU Package Type"; Rec."RLU Package Type")
            {
                ApplicationArea = All;
                ToolTip = 'Package Type';
            }
            field("RLU Weight Packing"; Rec."RLU Weight Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Weight Packing (kgs)';
            }
            field("RLU Seal No"; Rec."RLU Seal No")
            {
                ApplicationArea = All;
                ToolTip = 'Seal No';
            }
        }
    }
}
