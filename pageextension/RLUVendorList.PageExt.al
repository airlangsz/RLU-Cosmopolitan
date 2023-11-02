pageextension 50134 RLUVendorList extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Sent Emails")
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
                    PostAdj: Codeunit RLUVendorAPI;
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            if Rec.Post = true then
                                Message('ude di post')
                            else
                                PostAdj.PostingVendor(Rec);
                        until Rec.Next() = 0
                end;
            }
        }
    }
    var
}