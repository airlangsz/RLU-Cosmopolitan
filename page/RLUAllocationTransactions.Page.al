page 50103 "RLU Allocation Transactions"
{
    Caption = 'Allocation Transactions';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "RLU Allocation Header";
    CardPageId = "RLU Allocation Transaction";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Allo Trans No"; Rec."Allo Trans No")
                {
                    ApplicationArea = All;
                }
                field("Date From"; Rec."Date From")
                {
                    ApplicationArea = All;
                }
                field("Date To"; Rec."Date To")
                {
                    ApplicationArea = All;
                }
                field("Allo Code"; Rec."Allo Code")
                {
                    ApplicationArea = All;
                }
                field("Allo Description"; Rec."Allo Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Total Basis Balance"; Rec."Total Basis Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Hectare Area"; Rec."Total Hectare Area")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Process)
            {
                Caption = 'Allocation Mapping';
                ApplicationArea = All;
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Allocation Mapping';
                RunObject = Page "RLU Allocation Mapping";
            }

        }
    }
}