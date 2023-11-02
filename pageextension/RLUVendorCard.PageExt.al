pageextension 50127 RLUVendorCard extends "Vendor Card"
{
    layout
    {
        addafter("Company Size Code")
        {
            field("CF Code Inflow"; Rec."CF Code Inflow")
            {
                ApplicationArea = All;
                Caption = 'CF Code Inflow';
                ToolTip = 'CF Code Inflow';
            }
            field("CF Code Outflow"; Rec."CF Code Outflow")
            {
                ApplicationArea = All;
                Caption = 'CF Code Outflow';
                ToolTip = 'CF Code Outflow';
            }
        }
    }
}