report 50105 "RLU Payment Voucher"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Payment Voucher';
    RDLCLayout = './app/src/rdl/RLUPaymentVoucher.rdl';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            column(Picture; CompanyInformation.Picture) { }
            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyAddres; CompanyInformation.Address) { }
            column(CompanyCity; CompanyInformation.City) { }
            column(Posting_Date; "Posting Date") { }
            column(Journal_Template_Name; "Journal Template Name") { }
            column(Document_No_; "Document No.") { }
            column(Amount; Amount * -1) { }
            column(VAT_Amount; "VAT Amount") { }
            column(WHTAmount; WHTAmount) { }
            column("BankNom"; BankNo()) { }
            column(Bal__Account_No_; "Bal. Account No.") { }
            column(BankName; BankName()) { }
            column(BankBranchNo; BankBranchNo()) { }
            column(Description; Description) { }
            column(SumVatBaseAmount; SumVatBaseAmount()) { }
            column(SumWHTAmount; SumWHTAmount()) { }
            column(OthersLoadingCost; '-') { }
            column(AmountInWords; AmountInWords) { }
            column(vatgabungan; vatgabungan) { }
            column(amount_; amount_) { }
            column(SwiftCode; SwiftCode()) { }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.") { }
            column(TotalAmount; TotalAmount) { }
            column(No_; No_) { }
            column(Location; '-') { }
            column(Directorate; '-') { }
            column(CostCentre; '-') { }
            column(BudgetCode; '-') { }
            column(BeneficiaryName; BeneficiaryName()) { }
            column(BAPWorkReportNo; '-') { }
            column(PoAgreementNo; PoAgreementNo()) { }
            column(DueDate; DueDate()) { }


            trigger OnPreDataItem()
            var
            begin
                "Gen. Journal Line".SetRange("Journal Template Name", 'PAYMENT');
                "Gen. Journal Line".SetRange("Document No.", No_);
                "Gen. Journal Line".SetRange("Journal Batch Name", Batch_);
            end;

            trigger OnAfterGetRecord()
            var
                PIH: Record "Purch. Inv. Header";
                totaltagihan: Decimal;
            begin
                PIH.SetRange("No.", "Gen. Journal Line"."Applies-to Doc. No.");
                if PIH.FindSet() then begin
                    PIH.CalcFields(PIH."Amount Including VAT", PIH.Amount);
                    vatgabungan := PIH."Amount Including VAT" - PIH.Amount;
                    amount_ := PIH.Amount + SumWHTAmount();
                    TotalAmount := (amount_ + vatgabungan) - SumWHTAmount();
                end;

                totaltagihan := Abs(Round(TotalAmount, 1, '>'));
                InitTextVariable();
                FormatNoText(NoText, totaltagihan, '');
                AmountInWords := NoText[1];
                AmountInWords := ReplaceString(AmountInWords, 'Satu Ratus', 'Seratus');
                AmountInWords := ReplaceString(AmountInWords, 'Satu Ribu', 'Seribu');
            end;
        }
    }

    trigger OnInitReport()
    begin
        CompanyInformation.get();
        CompanyInformation.CalcFields(Picture);

    end;

    var
        CompanyInformation: Record "Company Information";
        amount_: Decimal;
        No_: Code[20];
        Batch_: Code[20];
        vatgabungan: decimal;
        TotalAmount: Decimal;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[4] of Text[30];
        NoText: Array[3] of Text[100];
        AmountInWords: Text;

    procedure setparm(_No: code[20]; _Batch: code[20])
    var
    begin
        No_ := _No;
        Batch_ := _Batch;
    end;

    local procedure DueDate(): Date
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.SetRange("Document No.", "Gen. Journal Line"."Applies-to Doc. No.");
        if VendorLedgerEntry.FindSet() then
            repeat
            until VendorLedgerEntry.Next() = 0;
        exit(VendorLedgerEntry."Due Date");
    end;

    local procedure PoAgreementNo(): Code[50]
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        PurchInvLine.SetFilter(IsWHTCalc, '%1', false);
        PurchInvLine.SetRange("Document No.", "Gen. Journal Line"."Applies-to Doc. No.");
        if PurchInvLine.FindSet() then
            repeat
            until PurchInvLine.Next() = 0;
        exit(PurchInvLine."Blanket Order No.")
    end;

    local procedure BeneficiaryName(): Text[100]
    var
        Vendor: Record Vendor;

    begin
        Vendor.SetRange("No.", "Gen. Journal Line"."Account No.");
        if Vendor.FindSet() then begin
            repeat
            until Vendor.Next() = 0;
            exit(Vendor.Name);
        end;
    end;

    local procedure BankNo(): text[30]
    var
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        GenJournalLine: Record "Gen. Journal Line";

    begin
        GenJournalLine.SetFilter("Account Type", '%1', GenJournalLine."Account Type"::Vendor);
        GenJournalLine.SetFilter("Document No.", '%1', "Gen. Journal Line"."Document No.");
        if GenJournalLine.FindSet() then begin
            repeat
            until GenJournalLine.Next() = 0;
            Vendor.SetRange("No.", GenJournalLine."Account No.");
            if Vendor.FindSet() then begin
                repeat
                until
            Vendor.Next() = 0;
                VendorBankAccount.SetRange(Code, Vendor."Preferred Bank Account Code");
                if VendorBankAccount.FindSet() then begin
                    repeat
                    until VendorBankAccount.Next() = 0;
                    exit(VendorBankAccount."Bank Account No.");
                end;
            end;
        end;
    end;


    local procedure BankName(): Text[100]
    var
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        GenJournalLine: Record "Gen. Journal Line";

    begin
        GenJournalLine.SetFilter("Account Type", '%1', GenJournalLine."Account Type"::Vendor);
        GenJournalLine.SetFilter("Document No.", '%1', "Gen. Journal Line"."Document No.");
        if GenJournalLine.FindSet() then begin
            repeat
            until GenJournalLine.Next() = 0;
            Vendor.SetRange("No.", GenJournalLine."Account No.");
            if Vendor.FindSet() then begin
                repeat
                until
            Vendor.Next() = 0;
                VendorBankAccount.SetRange(Code, Vendor."Preferred Bank Account Code");
                if VendorBankAccount.FindSet() then begin
                    repeat
                    until VendorBankAccount.Next() = 0;
                    exit(VendorBankAccount.Name);
                end;
            end;
        end;
    end;

    local procedure BankBranchNo(): Text[50]
    var
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        GenJournalLine: Record "Gen. Journal Line";

    begin
        GenJournalLine.SetFilter("Account Type", '%1', GenJournalLine."Account Type"::Vendor);
        GenJournalLine.SetFilter("Document No.", '%1', "Gen. Journal Line"."Document No.");
        if GenJournalLine.FindSet() then begin
            repeat
            until GenJournalLine.Next() = 0;
            Vendor.SetRange("No.", GenJournalLine."Account No.");
            if Vendor.FindSet() then begin
                repeat
                until
            Vendor.Next() = 0;
                VendorBankAccount.SetRange(Code, Vendor."Preferred Bank Account Code");
                if VendorBankAccount.FindSet() then begin
                    repeat
                    until VendorBankAccount.Next() = 0;
                    exit(VendorBankAccount."Bank Branch No.");
                end;
            end;
        end;
    end;

    local procedure SwiftCode(): Text[50]
    var
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        GenJournalLine: Record "Gen. Journal Line";

    begin
        GenJournalLine.SetFilter("Account Type", '%1', GenJournalLine."Account Type"::Vendor);
        GenJournalLine.SetFilter("Document No.", '%1', "Gen. Journal Line"."Document No.");
        if GenJournalLine.FindSet() then begin
            repeat
            until GenJournalLine.Next() = 0;
            Vendor.SetRange("No.", GenJournalLine."Account No.");
            if Vendor.FindSet() then begin
                repeat
                until
            Vendor.Next() = 0;
                VendorBankAccount.SetRange(Code, Vendor."Preferred Bank Account Code");
                if VendorBankAccount.FindSet() then begin
                    repeat
                    until VendorBankAccount.Next() = 0;
                    exit(VendorBankAccount."SWIFT Code");
                end;
            end;
        end;
    end;


    local procedure SumWHTAmount(): Decimal
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        PurchInvLine.SetRange("Document No.", "Gen. Journal Line"."Applies-to Doc. No.");
        if PurchInvLine.FindSet() then
            repeat
            until
                PurchInvLine.Next() = 0;
        exit(PurchInvLine.WHTAmount);
    end;

    local procedure SumVatBaseAmount(): Decimal
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        PurchInvLine.SetRange("No.", "Gen. Journal Line"."Applies-to Doc. No.");
        if PurchInvLine.FindSet() then
            repeat
            until
                    PurchInvLine.Next() = 0;
        exit(PurchInvLine."VAT Base Amount");
    end;

    procedure FormatNoText(var NooText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NooText[1] := '';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, '')
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NooText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NooText, NoTextIndex, PrintExponent, 'Hundred');
                end;
                if ((Tens > 0) or (Ones > 0)) and (Hundreds > 0) then
                    AddToNoText(NooText, NoTextIndex, PrintExponent, '');
                if Tens >= 2 then begin
                    AddToNoText(NooText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NooText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NooText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NooText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

            AddToNoText(NooText, NoTextIndex, PrintExponent, '');
        end;

        if No > 0 then
            AddToNoText(NooText, NoTextIndex, PrintExponent, Format(No * 100))
        else
            AddToNoText(NooText, NoTextIndex, PrintExponent, ' ');
        if CurrencyCode <> '' then
            AddToNoText(NooText, NoTextIndex, PrintExponent, CurrencyCode);

    end;


    procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    var
        FindPos: Integer;
    begin
        FindPos := STRPOS(String, FindWhat);
        WHILE FindPos > 0 DO BEGIN
            NewString += DELSTR(String, FindPos) + ReplaceWith;
            String := COPYSTR(String, FindPos + STRLEN(FindWhat));
            FindPos := STRPOS(String, FindWhat);
        END;
        NewString += String;
    end;

    procedure AddToNoText(VAR NooText: ARRAY[2] OF Text; VAR NoTextIndex: Integer; VAR PrintExponent: Boolean; AddText: Text)
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NooText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NooText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NooText) THEN
                ERROR('', AddText);
        END;

        NooText[NoTextIndex] := DELCHR(NooText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := 'One';
        OnesText[2] := 'Two';
        OnesText[3] := 'Three';
        OnesText[4] := 'Four';
        OnesText[5] := 'Five';
        OnesText[6] := 'Six';
        OnesText[7] := 'Seven';
        OnesText[8] := 'Eight';
        OnesText[9] := 'Nine';
        OnesText[10] := 'Ten';
        OnesText[11] := 'Eleven';
        OnesText[12] := 'Twelve';
        OnesText[13] := 'Thirteen';
        OnesText[14] := 'Fourteen';
        OnesText[15] := 'Fifteen';
        OnesText[16] := 'Sixteen';
        OnesText[17] := 'Seventeen';
        OnesText[18] := 'Eighteen';
        OnesText[19] := 'Nineteen';

        TensText[1] := 'Not used';
        TensText[2] := 'Twenty';
        TensText[3] := 'Thirty';
        TensText[4] := 'Fourty';
        TensText[5] := 'Fifty';
        TensText[6] := 'Sixty';
        TensText[7] := 'Seventy';
        TensText[8] := 'Eighty';
        TensText[9] := 'Ninety';
        TensText[10] := 'One Hundred';

        ExponentText[1] := 'Hundred';
        ExponentText[2] := 'Thousand';
        ExponentText[3] := 'Million';
        ExponentText[4] := 'Billion';
    end;
}