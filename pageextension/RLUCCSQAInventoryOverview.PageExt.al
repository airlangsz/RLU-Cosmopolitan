pageextension 50118 "RLU CCS QA Inventory Overview" extends "CCS QA Inventory Overview"
{
    actions
    {
        addlast(Processing)
        {
            action("Change Finished Goods Type")
            {
                Caption = 'Change Finished Goods Type';
                ToolTip = 'Change Finished Goods Type';
                ApplicationArea = All;
                Image = Change;

                trigger OnAction()
                begin
                    Rec.InitFinishedGoodType(Rec);
                end;
            }
        }
    }
}
