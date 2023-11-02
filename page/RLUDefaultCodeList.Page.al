page 50109 "RLU Default Code List"
{
    ApplicationArea = All;
    Caption = 'Default Code List';
    PageType = List;
    SourceTable = "RLU Default Code";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Table ID';
                    ApplicationArea = All;
                    LookupPageId = Objects;
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ToolTip = 'Table Caption';
                    ApplicationArea = All;
                }
                field("Field ID"; Rec."Field ID")
                {
                    ToolTip = 'Field ID';
                    ApplicationArea = All;
                    LookupPageId = "Fields Lookup";
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Field Caption';
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Code';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
            }
        }
    }
}
