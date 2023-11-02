page 50112 "RLU Cash Flow"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'RLU Cash Flow';
    SourceTable = "RLU Cash Flow";

    layout
    {
        area(Content)
        {
            repeater("RLU Cash Flow")
            {
                field("CF Code"; Rec."CF Code")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Flow Code';
                    ToolTip = 'Cash Flow Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Description';
                }
                field("CF Type"; Rec."CF Type")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Flow Type';
                    ToolTip = 'Cash Flow Type';
                }
            }
        }
    }
}