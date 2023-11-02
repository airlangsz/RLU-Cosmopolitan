page 50104 "RLU Allocation Basis"
{
    Caption = 'Allocation Basis';
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "RLU Allocation Basis";

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

                field("GL Account No"; Rec."GL Account No")
                {
                    ApplicationArea = All;
                }
                field("GL Description"; Rec."GL Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Allo Basis Balance"; Rec."Allo Basis Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}