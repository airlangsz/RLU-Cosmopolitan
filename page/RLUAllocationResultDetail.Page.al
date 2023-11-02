page 50107 "RLU Allocation Result Detail"
{
    Caption = 'Allocation Result Detail';
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "RLU Allocation Result Detail";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Allo Trans No"; Rec."Allo Trans No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Allo Code"; Rec."Allo Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Block Code"; Rec."Block Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("GL Account No"; Rec."GL Account No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("GL Description"; Rec."GL Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Allo Result Balance"; Rec."Allo Result Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}