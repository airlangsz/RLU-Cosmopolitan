pageextension 50129 "RLU GL Account Card" extends "G/L Account Card"
{
    layout
    {
        addafter("New Page")
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