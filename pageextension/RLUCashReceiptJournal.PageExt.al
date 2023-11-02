pageextension 50106 "RLU Cash Receipt Journal" extends "Cash Receipt Journal"
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
                ToolTip = 'CF Code';
                Caption = 'CF Code';
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
                Caption = 'Receive Voucher';
                ToolTip = 'Receive Voucher';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Image = Report;
                trigger OnAction()
                var
                    GenJournalLine: Record "Gen. Journal Line";
                    RLUReceiveVoucher: Report "RLU Receive Voucher";
                begin
                    GenJournalLine := Rec;
                    CurrPage.SetSelectionFilter(GenJournalLine);
                    RLUReceiveVoucher.setparm(GenJournalLine."Document No.");
                    RLUReceiveVoucher.Run();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Account Type" = Rec."Account Type"::Customer then
            if CustomerRec.Get(Rec."Account No.") then
                if Rec.Amount >= 0 then
                    Rec."CF Code" := CustomerRec."CF Code Inflow"
                else
                    if Rec.Amount < 0 then
                        Rec."CF Code" := CustomerRec."CF Code Outflow";

        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then
            if GLAccountRec.Get(Rec."Account No.") then
                if Rec.Amount >= 0 then
                    Rec."CF Code" := GLAccountRec."CF Code Inflow"
                else
                    if Rec.Amount < 0 then
                        Rec."CF Code" := GLAccountRec."CF Code Outflow";
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec."Account Type" = Rec."Account Type"::Customer then
            if CustomerRec.Get(Rec."Account No.") then
                if Rec.Amount >= 0 then
                    Rec."CF Code" := CustomerRec."CF Code Inflow"
                else
                    if Rec.Amount < 0 then
                        Rec."CF Code" := CustomerRec."CF Code Outflow";

        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then
            if GLAccountRec.Get(Rec."Account No.") then
                if Rec.Amount >= 0 then
                    Rec."CF Code" := GLAccountRec."CF Code Inflow"
                else
                    if Rec.Amount < 0 then
                        Rec."CF Code" := GLAccountRec."CF Code Outflow";
    end;

    var
        CustomerRec: Record Customer;
        GLAccountRec: Record "G/L Account";
}