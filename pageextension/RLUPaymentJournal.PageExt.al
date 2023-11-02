pageextension 50102 "RLU Payment Journal" extends "Payment Journal"
{
    layout
    {
        addafter("External Document No.")
        {
            field(TypeAudit; Rec.TypeAudit)
            {
                Caption = 'Audit Type';
                ToolTip = 'Audit Type';
                ApplicationArea = all;
                ShowMandatory = true;
            }
            field("CF Code"; Rec."CF Code")
            {
                ApplicationArea = All;
                Caption = 'CF Code';
                ToolTip = 'CF Code';
            }

        }

        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Posting Date" <> 0D then
                    Rec.TypeAudit := Rec.TypeAudit::Unaudited;
            end;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Account No." <> '' then
                    Rec.TypeAudit := Rec.TypeAudit::Unaudited;
            end;
        }
    }
    actions
    {
        addafter("A&ccount")
        {
            action("Report")
            {
                Caption = 'Payment Voucher';
                ToolTip = 'Payment Voucher';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Image = Report;
                trigger OnAction()
                var
                    general: Report "RLU Payment Voucher";
                begin
                    // GenJournalLine := Rec;
                    CurrPage.SetSelectionFilter(Rec);
                    general.setparm(Rec."Document No.", Rec."Journal Batch Name");
                    general.Run();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Account Type" = Rec."Account Type"::Vendor then
            if VendorRec.Get(Rec."Account No.") then
                if Rec.Amount >= 0 then
                    Rec."CF Code" := VendorRec."CF Code Outflow"
                else
                    if Rec.Amount < 0 then
                        Rec."CF Code" := VendorRec."CF Code Inflow";
        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then
            if GLAccountRec.Get(Rec."Account No.") then
                if Rec.Amount >= 0 then
                    Rec."CF Code" := GLAccountRec."CF Code Outflow"
                else
                    if Rec.Amount < 0 then
                        Rec."CF Code" := GLAccountRec."CF Code Inflow";
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec."Account Type" = Rec."Account Type"::Vendor then
            if VendorRec.Get(Rec."Account No.") then
                if Rec.Amount >= 0 then
                    Rec."CF Code" := VendorRec."CF Code Outflow"
                else
                    if Rec.Amount < 0 then
                        Rec."CF Code" := VendorRec."CF Code Inflow";

        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then
            if GLAccountRec.Get(Rec."Account No.") then
                if Rec.Amount >= 0 then
                    Rec."CF Code" := GLAccountRec."CF Code Outflow"
                else
                    if Rec.Amount < 0 then
                        Rec."CF Code" := GLAccountRec."CF Code Inflow";
    end;


    var
        VendorRec: Record Vendor;
        GLAccountRec: Record "G/L Account";

}