pageextension 50101 "RLU Posted Sales Inv. Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("RLU DRC Percentage"; Rec."RLU DRC Percentage")
            {
                ApplicationArea = All;
                ToolTip = 'DRC %-tage';
            }
            field("RLU Dry Quantity"; Rec."RLU Dry Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Dry Based Quantity Amount';
            }
        }
        addafter("Unit Price")
        {
            field("RLU Dry Unit Price"; Rec."RLU Dry Unit Price")
            {
                ApplicationArea = All;
                ToolTip = 'Dry Based Price Amount';
            }
        }
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
