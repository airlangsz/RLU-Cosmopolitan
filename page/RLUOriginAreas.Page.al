page 50110 "RLU Origin Areas"
{
    ApplicationArea = All;
    Caption = 'Origin Areas';
    PageType = List;
    SourceTable = "RLU Origin Area";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Origin Area Code"; Rec."Origin Area Code")
                {
                    ToolTip = 'Specifies the value of the Origin Area Code field.';
                }
                field("Province Code"; Rec."Province Code")
                {
                    ToolTip = 'Specifies the value of the Province Code field.';
                }
                field("Province Name"; Rec."Province Name")
                {
                    ToolTip = 'Specifies the value of the Province Name field.';
                }
                field("City Code"; Rec."City Code")
                {
                    ToolTip = 'Specifies the value of the City Code field.';
                }
                field("City Name"; Rec."City Name")
                {
                    ToolTip = 'Specifies the value of the City Name field.';
                }
                field("Supplier Category Code"; Rec."Supplier Category Code")
                {
                    ToolTip = 'Specifies the value of the Supplier Category Code field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send API")
            {
                Caption = 'Post API';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = SendTo;
                ToolTip = 'API';
                trigger OnAction()
                var
                    PostAdj: Codeunit RLUOriginAreaAPI;
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            // if Rec.Post = true then
                            //     Message('ude di post')
                            // else
                            PostAdj.PostingArea(Rec);
                        until Rec.Next() = 0
                end;
            }
        }
    }
}
