pageextension 50117 "RLU Sales Invoice" extends "Sales Invoice"
{
    actions
    {
        // addafter(ProformaInvoice_Promoted)
        // {
        //     actionref(CommercialInvoice_; CommercialInvoice)
        //     {
        //     }
        // }

        // addafter(ProformaInvoice)
        // {
        //     action(CommercialInvoice)
        //     {
        //         ToolTip = 'Commercial Invoice';
        //         Caption = 'Commercial Invoice';
        //         ApplicationArea = All;
        //         Image = Print;

        //         trigger OnAction()
        //         var
        //             CommercialInvoice: Report "RLU Commercial Invoice";
        //         begin
        //             CommercialInvoice.setparm(Rec."No.");
        //             CommercialInvoice.Run();
        //         end;
        //     }
        // }
    }
}