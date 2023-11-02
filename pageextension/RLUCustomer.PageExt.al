pageextension 50126 "RLU Customer" extends "Customer Card"
{
    layout
    {
        addafter("Salesperson Code")
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