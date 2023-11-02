report 50113 "RLU Commercial Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Commercial Invoice';
    RDLCLayout = './app/src/rdl/RLUCommercialInvoice.rdl';

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            column(Picture; CompanyInformation.Picture) { }
            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyAddres; CompanyInformation.Address) { }
            column(CompanyAddres2; CompanyInformation."Address 2") { }
            column(CompanyPhoneNo; CompanyInformation."Phone No.") { }
            column(CompanyFaxNo; CompanyInformation."Fax No.") { }
            column(CompanyVATRegNo; CompanyInformation."VAT Registration No.") { }
            column(AmountInWords; AmountInWords) { }
            column(No_; "No.") { }
            column(Document_Date; "Document Date") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Sell_to_Address; "Sell-to Address") { }
            column(Sell_to_Address_2; "Sell-to Address 2") { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.") { }
            column(GetSellToCustomerFaxNo; GetSellToCustomerFaxNo()) { }
            column(RLU_BKG_Ref; "RLU BKG Ref") { }
            column(RLU_Country_of_Origin; "RLU Country of Origin") { }
            column(RLU_Feeder; "RLU Feeder") { }
            column(RLU_Notify; "RLU Notify") { }
            column(RLU_Place_of_Delivery; "RLU Place of Delivery") { }
            column(RLU_Port_of_Discharge; "RLU Port of Discharge") { }
            column(RLU_Service_Contract; "RLU Service Contract") { }
            column(RLU_Stuffing_Plan; "RLU Stuffing Plan") { }
            column(RLU_Vessel_Voyage; "RLU Vessel/Voyage") { }
            column(RLU_Via; "RLU Via") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Phone_No_Cust; Phone_No_Cust) { }
            column(Email_Cust; Email_Cust) { }
            column(Fax_Cust; Fax_Cust) { }
            column(Address_Notify; Address_Notify) { }
            column(PhoneNo_Notify; PhoneNo_Notify) { }
            column(Fax_Notify; Fax_Notify) { }
            column(Email_Notify; Email_Notify) { }
            column(BankAccountNo_; BankAccountNo_) { }
            column(BankAccountName_; BankAccountName_) { }
            dataitem(Line; "Sales Line")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Document No." = field("No.");

                column(GetLineDesc; Description) { }
                column(Blanket; PQCOntractNo_Loop()) { }
                column(getDocDate; getDocDate()) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure Code") { }
                column(Unit_Price; "Unit Price") { }
                column(Amount; Amount) { }
                column(RLU_MKC_Lot_No; LotNo()) { }
                column(Currency_Code; "Currency Code") { }
                column(DiscountMB; _DiscountMB_) { }
                column(TotalLine; _Amount_) { }
                column(Type; Type) { }
                column(ItemVariantDesc; VariantDesc()) { }
                column(RLU_SMPT_Lot_No; LotNo()) { }
                column(TotalAll; TotalAll) { }
                column(SMPTLotNoSum; SMPTLotNoSum()) { }
                column(Pallet_Quantity; "Pallet Quantity") { }
                column(UnitPriceCharge; UnitPriceCharge) { }

                trigger OnPreDataItem()
                begin
                    Line.SetRange(Type, Line.Type::Item);
                end;

                trigger OnAfterGetRecord()
                var
                    SalesLine: Record "Sales Line";
                    SalesLineRec: Record "Sales Line";
                    totaltagihan: Decimal;
                begin
                    // get amount item charge value
                    SalesLineRec.SetRange("Document No.", No_);
                    SalesLineRec.SetRange(Type, Line.Type::"Charge (Item)");
                    SalesLineRec.SetRange("Discount Package", true);
                    SalesLineRec.CalcSums(Amount, "Unit Price");
                    _DiscountMB_ := Abs(SalesLineRec.Amount);
                    UnitPriceCharge := Abs(SalesLineRec."Unit Price");

                    // Get Total Discount Amount
                    SalesLine.SetRange("Document No.", No_);
                    SalesLine.SetRange(Type, Line.Type::Item);
                    SalesLine.CalcSums(Amount, Quantity, "Unit Price");
                    UnitPrice_ := SalesLine."Unit Price";
                    Quantity_ := SalesLine.Quantity;
                    _Amount_ := SalesLine.Amount;


                    TotalLine := UnitPrice_ * Quantity_;
                    TotalAll := _Amount_ - _DiscountMB_;

                    totaltagihan := Abs(Round(TotalAll, 1, '>'));
                    InitTextVariable();
                    FormatNoText(NoText, totaltagihan, '');
                    AmountInWords := NoText[1];
                    AmountInWords := ReplaceString(AmountInWords, 'Satu Ratus', 'Seratus');
                    AmountInWords := ReplaceString(AmountInWords, 'Satu Ribu', 'Seribu');
                end;
            }
            trigger OnPreDataItem()
            begin
                Header.SetRange("No.", No_);

                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            var
                // CustomerRec: Record Customer;
                ShipToAddress: Record "Ship-to Address";
                ShipToAddress2: Record "Ship-to Address";
                BankAccount: Record "Bank Account";
            begin
                Header.SetRange("Document Type", Header."Document Type"::Invoice);
                CalcFields("Amount Including VAT", Amount);

                // Notify
                if ShipToAddress.Get(Header."Sell-to Customer No.", Header."RLU Notify") then
                    ShipToAddress.SetRange(Code, Header."RLU Notify");
                if not ShipToAddress.IsEmpty then begin
                    Address_Notify := ShipToAddress.Address;
                    PhoneNo_Notify := ShipToAddress."Phone No.";
                    Fax_Notify := ShipToAddress."Fax No.";
                    Email_Notify := ShipToAddress."E-Mail";
                end;

                // Consignee
                if ShipToAddress2.Get(Header."Sell-to Customer No.", Header."Ship-to Code") then
                    ShipToAddress2.SetRange(Code, Header."Ship-to Code");
                if not ShipToAddress2.IsEmpty then
                    Phone_No_Cust := ShipToAddress2."Phone No.";
                Email_Cust := ShipToAddress2."E-Mail";
                Fax_Cust := ShipToAddress2."Fax No.";

                // Bank Account
                if BankAccount.Get(Header."Company Bank Account Code") then
                    BankAccountNo_ := BankAccount."Bank Account No.";
                BankAccountName_ := BankAccount.Name;
            end;
        }
    }

    requestpage
    {
        layout
        {
            // area(Content)
            // {
            //     group(GroupName)
            //     {
            //         field(Name; SourceExpression)
            //         {
            //             ApplicationArea = All;

            //         }
            //     }
            // }
        }

        actions
        {
            area(processing)
            {
                // action(ActionName)
                // {
                //     ApplicationArea = All;

                // }
            }
        }
    }

    var
        CompanyInformation: Record "Company Information";
        No_: Code[20];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[4] of Text[30];
        NoText: Array[3] of Text;
        AmountInWords: Text;
        Phone_No_Cust: Text[30];
        Email_Cust: Text[80];
        Fax_Cust: Text[30];
        Address_Notify: Text;
        PhoneNo_Notify: Text[30];
        Fax_Notify: Text[30];
        Email_Notify: Text[80];
        TotalLine: Decimal;
        Quantity_: Decimal;
        TotalAll: Decimal;
        UnitPrice_: Decimal;
        _Amount_: Decimal;
        _DiscountMB_: Decimal;
        UnitPriceCharge: Decimal;
        BankAccountNo_: Text[30];
        BankAccountName_: Text[100];

    procedure setparm(_No: code[20])
    var
    begin
        No_ := _No;
    end;

    local procedure getDocDate(): Date
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";

    begin
        SalesHeader.Reset();
        SalesHeader.SetFilter("Document Type", '%1', Header."Document Type"::"Blanket Order");
        SalesHeader.SetRange("No.", Line."Document No.");
        if not SalesHeader.IsEmpty then
            SalesLine.SetRange("Blanket Order No.", SalesHeader."No.");
        if not SalesLine.IsEmpty then
            exit(SalesHeader."Document Date");
    end;

    local procedure VariantDesc(): Text[100]
    var
        ItemVariant: Record "Item Variant";
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", Line."Document No.");
        SalesLine.SetRange("Line No.", Line."Line No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then begin
            repeat
            until SalesLine.Next() = 0;
            ItemVariant.SetRange(Code, SalesLine."Variant Code");
            if ItemVariant.FindSet() then
                repeat
                until ItemVariant.Next() = 0;
            exit(ItemVariant.Description);
        end;
    end;

    local procedure SMPTLotNoSum(): Text[250]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RLUCommercialInvoice: Query "RLU Commercial Invoice";
        TextLoop: Text[250];
    begin
        SalesHeader.SetRange("No.", Line."Document No.");
        if not SalesHeader.IsEmpty then begin
            SalesLine.SetRange("Document No.", Line."Document No.");
            SalesLine.SetRange("Line No.", Line."Line No.");
            if not SalesLine.IsEmpty then begin
                RLUCommercialInvoice.SetRange(RLUCommercialInvoice.Document_No_, Line."Document No.");
                RLUCommercialInvoice.SetFilter(RLUCommercialInvoice.Type, '%1', Line.Type::Item);
                RLUCommercialInvoice.Open();
                while RLUCommercialInvoice.Read() do
                    TextLoop += RLUCommercialInvoice.RLU_SMPT_Lot_No + ', ';
                RLUCommercialInvoice.Close();
                if TextLoop <> '' then
                    TextLoop := DelStr(TextLoop, StrLen(TextLoop) - 1, 2);
                exit(TextLoop);
            end;
        end;
    end;

    local procedure LotNo(): Text[250]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RLUCommercialInvoice: Query "RLU Commercial Invoice";
        TextLoop: Text[250];
    begin
        SalesHeader.SetRange("No.", Line."Document No.");
        if not SalesHeader.IsEmpty then begin
            SalesLine.SetRange("Document No.", Line."Document No.");
            SalesLine.SetRange("Line No.", Line."Line No.");
            if not SalesLine.IsEmpty then begin
                RLUCommercialInvoice.SetRange(RLUCommercialInvoice.Document_No_, Line."Document No.");
                RLUCommercialInvoice.SetFilter(RLUCommercialInvoice.Type, '%1', Line.Type::Item);
                RLUCommercialInvoice.Open();
                while RLUCommercialInvoice.Read() do
                    TextLoop += RLUCommercialInvoice.RLU_MKC_Lot_No + ', ';
                RLUCommercialInvoice.Close();
                if TextLoop <> '' then
                    TextLoop := DelStr(TextLoop, StrLen(TextLoop) - 1, 2);
                exit(TextLoop);
            end;
        end;
    end;

    local procedure PQCOntractNo_Loop(): Text[100]
    var
        SalesHeader: Record "Sales Header";
        // SalesLine: Record "Sales Line";
        RLUCommercialInvoice: Query "RLU Commercial Invoice";
        TextLoop: Text[100];
    begin
        SalesHeader.SetRange("No.", Line."Document No.");
        if not SalesHeader.IsEmpty then begin
            RLUCommercialInvoice.SetRange(RLUCommercialInvoice.Document_No_, Line."Document No.");
            RLUCommercialInvoice.Open();
            while RLUCommercialInvoice.Read() do
                TextLoop += RLUCommercialInvoice.Blanket_Order_No_ + ', ';
            RLUCommercialInvoice.Close();
            if TextLoop <> '' then
                TextLoop := DelStr(TextLoop, StrLen(TextLoop) - 1, 2);
            exit(TextLoop);
        end;
    end;

    procedure FormatNoText(var NoText1: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
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
        while FindPos > 0 do begin
            NewString += DELSTR(String, FindPos) + ReplaceWith;
            String := COPYSTR(String, FindPos + STRLEN(FindWhat));
            FindPos := STRPOS(String, FindWhat);
        end;
        NewString += String;
    end;

    procedure AddToNoText(var NoText1: array[2] of Text[100]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text)
    begin
        PrintExponent := TRUE;

        while STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ARRAYLEN(NoText) then
                ERROR('', AddText);
        end;

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
        OnesText[13] := 'Thirdteen';
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
        TensText[5] := 'Fivety';
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