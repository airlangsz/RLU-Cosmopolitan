pageextension 50114 "RLU Warehouse Picks" extends "Warehouse Pick"
{
    layout
    {
        addafter("Sorting Method")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                Caption = 'Posting Date';
                ToolTip = 'Posting Date';
                ApplicationArea = all;
                Editable = true;
                trigger OnValidate()
                // var
                // WarehouseActivityLine: Record "Warehouse Activity Line";
                // RLUPaymentVoucher: Report "RLU Payment Voucher";
                begin
                    // CurrPage.SetSelectionFilter(WarehouseActivityLine);
                    // RLUPaymentVoucher.setparm(WarehouseActivityLine."No.");
                    // RLUPaymentVoucher.Run();
                end;
            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action("FinishProductLoadingInstruction")
            {
                ApplicationArea = All;
                Image = PrintChecklistReport;
                Caption = 'Finish Product Loading Instruction';
                ToolTip = 'Finish Product Loading Instruction';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    RecIns: Report "RLU Instruksi Penurunan Produk";
                begin
                    RecIns.setparm(Rec."No.");
                    RecIns.Run();
                end;
            }
        }
    }
}