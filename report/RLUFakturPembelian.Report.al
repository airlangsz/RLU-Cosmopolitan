report 50101 "RLU Faktur Pembelian"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Faktur Pembelian';
    UseRequestPage = true;
    RDLCLayout = './app/src/rdl/RLUFakturPembelian.rdl';

    dataset
    {
        dataitem(Header2; "Purchase Header")
        {
            column(No; "No.") { }
            column(logo; CompanyInformation.Picture) { }
            column(Company_Name; CompanyInformation.Name) { }
            column(Company_Address; CompanyInformation.Address) { }
            column(Company_Address_2; CompanyInformation."Address 2") { }
            column(Company_City; CompanyInformation.City) { }
            column(Company_Post_Code; CompanyInformation."Post Code") { }
            column(Company_Country; CompanyInformation."Country/Region Code") { }
            column(Company_Bank_No; CompanyInformation."Bank Account No.") { }
            column(Company_Bank_Name; CompanyInformation."Bank Name") { }
            column(Company_Bank_Branch; CompanyInformation."Bank Branch No.") { }
            column(Company_phone; CompanyInformation."Phone No.") { }
            column(Pay_to_Name; "Pay-to Name") { }
            column(Posting_Date; "Posting Date") { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(AmountInWords; AmountInWords) { }
            column(NPWP; NPWP) { }
            column(Mengetahui; Mengetahui) { }
            column(Diperiksa; Diperiksa) { }
            column(Disetujui; Disetujui) { }
            dataitem(Line; "Purchase Line")
            {
                DataItemLinkReference = Header2;
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                column(Quantity; Quantity) { }
                column(Ongkos_Bongkar; Ongkos_Bongkar) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Unit_Cost; "Unit Cost") { }
                column(Amount; "Amount") { }
                column(Description; Description) { }
                column(WHTPercentage; WHTPercentage) { }
                column(WHTProductPostingGroup; WHTProductPostingGroup) { }
                column(Variant_Code; "Variant Code") { }
                column(Receipt_No_; "Receipt No.") { }
                column(Unit_Price__LCY_; "Unit Price (LCY)") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(PPN; PPN) { }
                column(WHT; WHT) { }
                column(GWKGS; "Gross Weight") { }
                column(DRC; RLUDRCPercentage) { }
                column(Total; Total) { }
                column(Uang_sejumlah; Uang_sejumlah) { }
                column(Jumlah_potongan; Jumlah_potongan) { }

                trigger OnPreDataItem()
                begin
                    Line.SetRange(Type, Line.Type::Item);
                end;

                trigger OnAfterGetRecord()
                var
                    PurchLineOrder: Record "Purchase Line";
                    "Purch. Rcpt. Line": Record "Purch. Rcpt. Line";
                begin
                    "Purch. Rcpt. Line".SetRange("Document No.", "Receipt No.");
                    IF "Purch. Rcpt. Line".FindFirst() then begin
                        PurchLineOrder.SetRange("Document No.", "Purch. Rcpt. Line"."Order No.");
                        IF PurchLineOrder.FindFirst() then
                            RLUDRCPercentage := PurchLineOrder."RLU DRC Percentage";
                    end;
                end;
            }
            trigger OnPreDataItem()

            begin
                Header2.SetRange("No.", _No);
            end;

            trigger OnAfterGetRecord()
            var
                PurchLine: Record "Purchase Line";
                WHTLine: Record "Purchase Line";
                Vendor: Record Vendor;
                NoText: Array[3] of Text[100];
            begin
                //Untuk total 
                PurchLine.SetRange("Document No.", _No);
                PurchLine.SetRange(Type, PurchLine.Type::Item);
                PurchLine.CalcSums(Amount, "VAT Base Amount", "Gross Weight", "Amount Including VAT");
                Total := PurchLine.Amount;
                GW := PurchLine."Gross Weight";
                AmountIncVAT := PurchLine."Amount Including VAT";
                VATBaseAmount := PurchLine."VAT Base Amount";

                Ongkos_Bongkar := GW * 53;
                PPN := (AmountIncVAT - VATBaseAmount);

                //WHTLine
                WHTLine.SetRange("Document No.", _No);
                WHTLine.SetRange(IsWHTCalc, true);
                WHTLine.CalcSums(WHTAmount);
                WHT := WHTLine.WHTAmount;

                Vendor.SetRange("No.", Header2."Buy-from Vendor No.");
                if Vendor.FindFirst() then
                    NPWP := Vendor.NPWP;

                Jumlah_potongan := Ongkos_Bongkar + WHT;
                Uang_sejumlah := (Total + PPN) - (Ongkos_Bongkar + WHT);

                // Number to Words
                Uang_sejumlah := ABS(ROUND(Uang_sejumlah, 1));
                RLUKreatifGlobalCode.InitTextVariable();
                RLUKreatifGlobalCode.FormatNoText(NoText, Uang_sejumlah, '');
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
                    field(Disetujui; Disetujui)
                    {
                        ApplicationArea = All;
                        Caption = 'Disetujui';
                        ToolTip = 'Disetujui';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(Disetujui) then
                                Disetujui := RLUEmployee.FullName();
                        end;
                    }
                    field(Diperiksa; Diperiksa)
                    {
                        ApplicationArea = All;
                        Caption = 'Diperiksa';
                        ToolTip = 'Diperiksa';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(Diperiksa) then
                                Diperiksa := RLUEmployee.FullName();
                        end;
                    }
                    field(Mengetahui; Mengetahui)
                    {
                        ApplicationArea = All;
                        Caption = 'Mengetahui';
                        ToolTip = 'Mengetahui';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(Mengetahui) then
                                Mengetahui := RLUEmployee.FullName();
                        end;
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        RLUEmployee: Record Employee;
        RLUKreatifGlobalCode: Codeunit "RLU Kreatif Global Code";
        Disetujui: Text[100];
        Diperiksa: Text[100];
        Mengetahui: Text[100];
        _No: Code[20];
        AmountInWords: Text;
        Uang_sejumlah: Decimal;
        WHT: Decimal;
        Total: Decimal;
        RLUDRCPercentage: Decimal;
        DRC: Decimal;
        GWKGS: Decimal;
        PPN: Decimal;
        Ongkos_Bongkar: Decimal;
        NPWP: Code[20];
        Jumlah_potongan: Decimal;
        GW: Decimal;
        AmountIncVAT: Decimal;
        VATBaseAmount: Decimal;

    procedure SetParm(No_: Code[20])
    begin
        _No := No_;
    end;

}