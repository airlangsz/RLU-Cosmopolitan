pageextension 50135 RLUItem extends "Item List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(CopyItem)
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
                    PostAdj: Codeunit RLUItemAPI;
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            if Rec.Post = true then
                                Message('ude di post')
                            else
                                PostAdj.PostingItem(Rec);
                        until Rec.Next() = 0
                end;
            }
        }
    }
    var
}