page 50105 "RLU Allocation Hectare Area"
{
    Caption = 'Allocation Hectare Area';
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "RLU Allocation Hectare Area";

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
                field("Block Code"; Rec."Block Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hectare Area"; Rec."Hectare Area")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hectare Percentage"; Rec."Hectare Percentage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}