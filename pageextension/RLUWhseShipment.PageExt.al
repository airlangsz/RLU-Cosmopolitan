pageextension 50115 "RLU Whse Shipment" extends "Warehouse Shipment"
{
    actions
    {
        addafter("&Print")
        {
            action("DeliverySlip")
            {
                ApplicationArea = All;
                Image = PrintReport;
                Caption = 'Delivery Slip';
                ToolTip = 'Delivery Slip';
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    RLUSuratJalan.SetParm(Rec."No.");
                    RLUSuratJalan.run();
                end;
            }

            action("Report")
            {
                Caption = 'Laboratory Certificate Of Quality';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Image = Report;
                ToolTip = 'Report';
                trigger OnAction()
                var
                    // GenJournalLine: Record "Gen. Journal Line";
                    labor: Report "RLU Laboratory Of Quality";
                begin
                    labor.SetParm(Rec."No.");
                    labor.Run();
                end;
            }
        }
    }
    var
        RLUSuratJalan: report "RLU Surat Jalan";
}