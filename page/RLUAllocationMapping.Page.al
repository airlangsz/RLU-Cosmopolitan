page 50102 "RLU Allocation Mapping"
{
    Caption = 'Setup Mapping Allocation';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "RLU Allocation Mapping";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Allo Code"; Rec."Allo Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Basis From"; Rec."Basis From")
                {
                    ApplicationArea = All;
                }
                field("Basis To"; Rec."Basis To")
                {
                    ApplicationArea = All;
                }
                field("Target Immature"; Rec."Target Immature")
                {
                    ApplicationArea = All;
                }
                field(Offset; Rec.Offset)
                {
                    ApplicationArea = All;
                }
                field("Target Mature"; Rec."Target Mature")
                {
                    ApplicationArea = All;
                }
                field("COGS Mature"; Rec."COGS Mature")
                {
                    ApplicationArea = All;
                }
                field("COGS Mature Offset"; Rec."COGS Mature Offset")
                {
                    ApplicationArea = All;
                }
                field("Block Code Other"; Rec."Block Code Other")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}