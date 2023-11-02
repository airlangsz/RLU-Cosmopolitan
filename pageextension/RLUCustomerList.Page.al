pageextension 50133 RLUCustomerList extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(ApplyTemplate)
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
                    PostAdj: Codeunit RLUCustomerAPI;
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            if Rec.Post = true then
                                Message('ude di post')
                            else
                                PostAdj.PostingCust(Rec);
                        until Rec.Next() = 0
                end;
            }
        }
    }
    var
}