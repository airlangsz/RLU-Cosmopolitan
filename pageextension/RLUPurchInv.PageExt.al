pageextension 50111 "RLU Purch Inv" extends "Purchase Invoice"
{
    actions
    {
        addlast(Reporting)
        {
            action("Faktur Pembelian")
            {
                Promoted = true;
                PromotedCategory = Report;
                Image = PrintReport;
                ApplicationArea = all;
                Caption = 'Faktur Pembelian';
                ToolTip = 'Faktur Pembelian';
                trigger OnAction()
                begin
                    RLUFakturPembelian.SetParm(Rec."No.");
                    RLUFakturPembelian.run();
                end;
            }
        }
    }
    var
        RLUFakturPembelian: Report "RLU Faktur Pembelian";
}