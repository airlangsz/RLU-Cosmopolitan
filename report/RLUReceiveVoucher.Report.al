report 50112 "RLU Receive Voucher"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'RLU Receive Voucher';
    RDLCLayout = './app/src/rdl/RLUReceiveVoucher.rdl';

    dataset
    {
        dataitem(Genline; "Gen. Journal Line")
        {
            column(Journal_Template_Name; "Journal Template Name") { }
            column(Document_No_; "Document No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Amount; Amount * -1) { }
            column(VAT_Amount; "VAT Amount") { }
            column(WHTAmount; WHTAmount) { }
            column(getbankCode; getbankCode()) { }
            column(Bal__Account_No_; "Bal. Account No.") { }
            column(getbankname; getbankname()) { }
            column(getbankbranch; getbankbranch()) { }
            column(Description; Description) { }
            column(getvat; getvat()) { }
            column(getwht; getwht() * -1) { }
            column(AmountInWords; AmountInWords) { }
            column(vatgabungan; vatgabungan) { }
            column(getamount; getamount()) { }
            column(getvatpersen; getvatpersen()) { }
            column(amount_; amount_) { }
            column(Picture; CompanyInformation.Picture) { }
            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyAddres; CompanyInformation.Address) { }
            column(CompanyCity; CompanyInformation.City) { }
            column(No_; No_) { }

            column(totaltagihan; totaltagihan) { }


            column(Director1; Director1) { }
            column(Director2; Director2) { }
            column(Finance1; Finance1) { }
            column(Finance2; Finance2) { }
            column(Finance3; Finance3) { }
            column(Account_No_; "Account No.") { }
            trigger OnPreDataItem()
            begin
                // Genline.SetRange("Journal Template Name", 'CASHRCPT');
                Genline.SetRange("Document No.", No_);
            end;

            trigger OnAfterGetRecord()
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
                SalesInvoiceLine: Record "Sales Invoice Line";
            begin
                SalesInvoiceHeader.SetRange("No.", Genline."Applies-to Doc. No.");
                SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine.SetFilter(Type, '%1', SalesInvoiceLine.Type::Item);
                if SalesInvoiceHeader.FindSet() then begin
                    SalesInvoiceHeader.CalcFields(SalesInvoiceHeader."Amount Including VAT", SalesInvoiceHeader.Amount);
                    vatgabungan := getamountsmwht() - getamount();
                    amount_ := SalesInvoiceHeader.Amount;
                    TotalAmount := getamountsmwht() - getwht();
                end;
                PayFor(Genline."Document No.");

                totaltagihan := Abs(Round(TotalAmount, 1, '>'));
                InitTextVariable();
                FormatNoText(NoText3, totaltagihan, '');
                AmountInWords := NoText3[1];
                AmountInWords := ReplaceString(AmountInWords, 'Satu Ratus', 'Seratus');
                AmountInWords := ReplaceString(AmountInWords, 'Satu Ribu', 'Seribu');
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
                    field(Director1; Director1)
                    {
                        ApplicationArea = All;
                        Caption = 'Director';
                        ToolTip = 'Director1';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(Director1) then
                                Director1 := RLUEmployee.FullName();
                        end;
                    }
                    field(Director2; Director2)
                    {
                        ApplicationArea = All;
                        Caption = 'Director';
                        ToolTip = 'Director2';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(Director2) then
                                Director2 := RLUEmployee.FullName();
                        end;
                    }
                    field(Finance1; Finance1)
                    {
                        ApplicationArea = All;
                        Caption = 'Finance';
                        ToolTip = 'Finance1';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(Finance1) then
                                Finance1 := RLUEmployee.FullName();
                        end;
                    }

                    field(Finance2; Finance2)
                    {
                        ApplicationArea = All;
                        Caption = 'Finance';
                        ToolTip = 'Finance2';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(Finance2) then
                                Finance2 := RLUEmployee.FullName();
                        end;
                    }

                    field(Finance3; Finance3)
                    {
                        ApplicationArea = All;
                        Caption = 'Finance';
                        ToolTip = 'Finance3';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(Finance3) then
                                Finance3 := RLUEmployee.FullName();
                        end;
                    }
                }
            }
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
        vatgabungan: decimal;
        PayForDesc: Text[255];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[4] of Text[30];
        NoText3: Array[3] of Text[100];
        AmountInWords: Text;
        TotalAmount: decimal;
        totaltagihan: Decimal;
        Director1: Text[100];
        Director2: Text[100];
        Finance1: Text[100];
        Finance2: Text[100];
        Finance3: Text[100];
        RLUEmployee: Record Employee;

    procedure setparm(_No: code[20])
    var
    begin
        No_ := _No;
    end;


    local procedure getbankCode(): text[30]
    var
        BankAccount: Record "Bank Account";
        journal: Record "Gen. Journal Line";
    begin
        // BankAccount.Get(Genline."Bal. Account No.");
        BankAccount.SetRange("No.", Genline."Bal. Account No.");
        // journal.SetRange("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
        // journal.SetFilter("Account Type", '%1', journal."Account Type"::"Bank Account");
        if BankAccount.FindSet() then
            exit(BankAccount."Bank Account No.");
    end;


    local procedure getbankname(): Text[30]
    var
        BankAccount: Record "Bank Account";
        journal: Record "Gen. Journal Line";
    begin
        // BankAccount.Get(Genline."Bal. Account No.");
        BankAccount.SetRange("No.", Genline."Bal. Account No.");
        // BankAccount.SetRange("No.", "Gen. Journal Line"."Account No.");
        // BankAccount.SetRange("No.", Genline."Bal. Account No.");
        // journal.SetRange("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
        // journal.SetFilter("Account Type", '%1', journal."Account Type"::"Bank Account");
        if BankAccount.FindSet() then
            exit(BankAccount.Name);
    end;


    local procedure getbankbranch(): Text[50]
    var
        journal: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
    begin
        // BankAccount.Get(Genline."Bal. Account No.");
        // journal.SetRange("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
        // journal.SetFilter("Account Type", '%1', journal."Account Type"::"Bank Account");
        // if journal.FindSet() then begin
        BankAccount.SetRange("No.", Genline."Bal. Account No.");
        if BankAccount.FindSet() then
            exit(BankAccount."Bank Branch No.");
    end;

    local procedure getvat(): decimal
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetRange("Document No.", Genline."Applies-to Doc. No.");
        if SalesInvoiceLine.FindFirst() then
            exit(SalesInvoiceLine."VAT Base Amount");
    end;

    local procedure getvatpersen(): decimal
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetRange("Document No.", Genline."Applies-to Doc. No.");
        if SalesInvoiceLine.FindFirst() then
            exit(SalesInvoiceLine."VAT %");
    end;

    local procedure getwht(): decimal
    var
        SL: Record "Sales Invoice Line";
    begin

        SL.SetRange("Document No.", Genline."Applies-to Doc. No.");
        SL.SetFilter(Type, '%1', SL.Type::"G/L Account");
        if SL.FindSet() then
            repeat
                SL.CalcSums(SL.WHTAmount);
                exit(SL.WHTAmount);
            until SL.Next() = 0;
    end;

    local procedure getamount(): decimal
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetRange("Document No.", Genline."Applies-to Doc. No.");
        SalesInvoiceLine.SetFilter(Type, '%1', SalesInvoiceLine.Type::Item);
        if SalesInvoiceLine.FindSet() then
            repeat
                SalesInvoiceLine.CalcSums(SalesInvoiceLine.Amount);
                exit(SalesInvoiceLine.Amount);
            until SalesInvoiceLine.Next() = 0;
    end;

    local procedure getamountsmwht(): decimal
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetRange("Document No.", Genline."Applies-to Doc. No.");
        SalesInvoiceLine.SetFilter(Type, '%1', SalesInvoiceLine.Type::Item);
        if SalesInvoiceLine.FindSet() then
            repeat
                SalesInvoiceLine.CalcSums(SalesInvoiceLine."Amount Including VAT");
                exit(SalesInvoiceLine."Amount Including VAT");
            until SalesInvoiceLine.Next() = 0;
    end;



    local procedure PayFor(PSINo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        Clear(PayForDesc);
        GenJournalLine.SetRange("Document No.", PSINo);
        if GenJournalLine.FindFirst() then
            PayForDesc := GenJournalLine.Description + ', Part No. ' + GenJournalLine."Document No." + ', ';
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
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
        NoText[1] := '';

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
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, 'Hundred');
                end;
                if ((Tens > 0) or (Ones > 0)) and (Hundreds > 0) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, '');
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

            AddToNoText(NoText, NoTextIndex, PrintExponent, '');
        end;

        if No > 0 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Format(No * 100))
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ');
        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);

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

    procedure AddToNoText(VAR NoText: ARRAY[2] OF Text; VAR NoTextIndex: Integer; VAR PrintExponent: Boolean; AddText: Text)
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR('', AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
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
        OnesText[15] := 'Fiveteen';
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