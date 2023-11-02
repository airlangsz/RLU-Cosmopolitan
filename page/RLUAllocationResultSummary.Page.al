page 50106 "RLU Allocation Result Summary"
{
    Caption = 'Allocation Result Summary';
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "RLU Allocation Result Summary";

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