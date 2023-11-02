pageextension 50113 "RLU Whse Pick Subform" extends "Whse. Pick Subform"
{
    layout
    {
        addafter("Lot No.")
        {
            field("PackageNo."; Rec."Package No.")
            {
                Caption = 'Package No.';
                ToolTip = 'Package No.';
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
        }
    }
}