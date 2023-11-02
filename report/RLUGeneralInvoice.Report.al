report 50102 "RLU General Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'RLU General Invoice';
    RDLCLayout = './app/src/rdl/RLUGeneralInvoice.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(Picture; CompanyInformationRLU.Picture) { }
            column(CompanyName; CompanyInformationRLU.Name) { }
            column(CompanyAddres; CompanyInformationRLU.Address) { }
            column(CompanyCity; CompanyInformationRLU.City) { }
            column(CompanyPhone; CompanyInformationRLU."Phone No.") { }
            column(CompanyFax; CompanyInformationRLU."Fax No.") { }
            column(CompanyPostCode; CompanyInformationRLU."Post Code") { }
            column(No_; "No.") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Posting_Date; "Posting Date") { }
            column(AmountInWords; AmountInWords) { }
            column(PayForDesc; PayForDesc) { }
            column(Amount_Including_VAT; "Amount Including VAT")
            {
                AutoCalcField = true;
            }
            column(getbankCode; getbankCode()) { }
            column(getbankbranch; getbankbranch()) { }
            column(getbankname; getbankname()) { }
            column(CFO; CFO) { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Document_No_; "Document No.") { }
                column(Description; Description) { }
                column(Amount; Amount) { }
                column(VAT_Base_Amount; "VAT Base Amount") { }
                column(WHTAmount; WHTAmount) { }
                column(totalvat; totalvat) { }
                column(amounttotal; _amount) { }

                trigger OnPreDataItem()
                begin
                    "Sales Line".SetRange(Type, "Sales Line".Type::Item);
                end;

            }
            trigger OnPreDataItem()
            begin
                "Sales Header".SetRange("No.", No_);
            end;

            trigger OnAfterGetRecord()
            var
                totaltagihan: Decimal;
            begin
                "Sales Line".SetRange("Document Type", "Sales Header"."Document Type"::Order);
                CalcFields("Amount Including VAT", Amount);
                totalvat := "Amount Including VAT" - Amount;
                _amount := "Amount Including VAT";

                totaltagihan := Abs(Round("Amount Including VAT", 0.1, '>'));
                RLUKreatifGlobalCode.InitTextVariable();
                RLUKreatifGlobalCode.FormatNoText(NoText, totaltagihan, '');
                AmountInWords := NoText[1];
                AmountInWords := RLUKreatifGlobalCode.ReplaceString(AmountInWords, 'Satu Ribu', 'Seribu');
                AmountInWords := RLUKreatifGlobalCode.ReplaceString(AmountInWords, 'Satu Ratus', 'Seratus');
            end;
        }
    }
    requestpage
    {
        // SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Parameter)
                {
                    field(CFO; CFO)
                    {
                        ApplicationArea = All;
                        Caption = 'CFO';
                        ToolTip = 'CFO';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(CFO) then
                                CFO := RLUEmployee.FullName();
                        end;
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        CompanyInformationRLU.get();
        CompanyInformationRLU.CalcFields(Picture);
    end;

    var
        CompanyInformationRLU: Record "Company Information";
        RLUEmployee: Record Employee;
        RLUKreatifGlobalCode: Codeunit "RLU Kreatif Global Code";
        No_: Code[20];
        PayForDesc: Text[255];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[4] of Text[30];
        NoText: Array[3] of Text[100];
        AmountInWords: Text;
        totalvat: Decimal;
        _amount: Decimal;
        CFO: Text[100];

    procedure setparm(_No: code[20])
    var
    begin
        No_ := _No;
    end;

    local procedure getbankCode(): text[30]
    var
        BankAccountRLU: Record "Bank Account";


    begin
        "Sales Header".SetRange("Bill-to Customer No.", BankAccountRLU."No.");
        if BankAccountRLU.FindSet() then
            repeat
            until
            BankAccountRLU.Next() = 0;
        exit(BankAccountRLU."Bank Account No.");
    end;

    local procedure getbankbranch(): Text[20]
    var
        BankAccountRLU: Record "Bank Account";


    begin
        "Sales Header".SetRange("Bill-to Customer No.", BankAccountRLU."No.");
        if BankAccountRLU.FindSet() then
            repeat
            until
    BankAccountRLU.Next() = 0;
        exit(BankAccountRLU."Bank Branch No.");
    end;

    local procedure getbankname(): Text[100]
    var
        BankAccountRLU: Record "Bank Account";

    begin
        "Sales Header".SetRange("Bill-to Customer No.", BankAccountRLU."No.");
        if BankAccountRLU.FindSet() then
            repeat
            until
       BankAccountRLU.Next() = 0;
        exit(BankAccountRLU.Name);
    end;
}