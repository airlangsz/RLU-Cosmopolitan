pageextension 50124 "RLU Sales Order Archive" extends "Sales Order Archive"
{
    layout
    {
        addafter("Package Tracking No.")
        {
            field("RLU Place of Delivery"; Rec."RLU Place of Delivery")
            {
                ApplicationArea = All;
                ToolTip = 'Place of Delivery';
            }
            field("RLU Via"; Rec."RLU Via")
            {
                ApplicationArea = All;
                ToolTip = 'Via';
            }
            field("RLU Port of Discharge"; Rec."RLU Port of Discharge")
            {
                ApplicationArea = All;
                ToolTip = 'Port of Discharge';
            }
            field("RLU Vessel/Voyage"; Rec."RLU Vessel/Voyage")
            {
                ApplicationArea = All;
                ToolTip = 'Vessel/Voyage';
            }
            field("RLU BKG Ref"; Rec."RLU BKG Ref")
            {
                ApplicationArea = All;
                ToolTip = 'BKG Ref';
            }
            field("RLU Notify"; Rec."RLU Notify")
            {
                ApplicationArea = All;
                ToolTip = 'Notify to';
            }
            field("RLU Service Contract"; Rec."RLU Service Contract")
            {
                ApplicationArea = All;
                ToolTip = 'Service Contract';
            }
            field("RLU Stuffing Plan"; Rec."RLU Stuffing Plan")
            {
                ApplicationArea = All;
                ToolTip = 'Stuffing Plan';
            }
            field("RLU Feeder"; Rec."RLU Feeder")
            {
                ApplicationArea = All;
                ToolTip = 'Feeder';
            }
            field("RLU Country of Origin"; Rec."RLU Country of Origin")
            {
                ApplicationArea = All;
                ToolTip = 'Country of Origin';
            }
        }
    }
}
