pageextension 50125 "RLU Released Prod. Order Lines" extends "Released Prod. Order Lines"
{
    actions
    {
        addlast("F&unctions")
        {
            action("Change Finished Goods Type")
            {
                Caption = 'Change Finished Goods Type';
                ToolTip = 'Change Finished Goods Type';
                ApplicationArea = All;
                Image = Change;

                trigger OnAction()
                begin
                    // Rec.InitFinishedGoodType(Rec);
                end;
            }
        }
    }
}