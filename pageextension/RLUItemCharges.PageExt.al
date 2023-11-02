pageextension 50130 RLUItemCharges extends "Item Charges"
{
    layout
    {
        addafter("Search Description")
        {
            field("Discount Package";Rec."Discount Package")
            {
                ApplicationArea = All;
                Caption = 'Discount Package';
                ToolTip = 'Discount Package';
            }
        }

    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        // myInt: Integer;
}