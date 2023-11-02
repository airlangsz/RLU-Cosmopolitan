report 50106 "RLU Proforma Invoice"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultRenderingLayout = layoutName;
    Caption = 'Pro Forma Invoice';

    dataset
    {
        dataitem("Header"; "Sales Header")
        {
            column(Picture; CompanyInformation.Picture) { }
            column(Company_Name; CompanyInformation.Name) { }
            column(Company_Address; CompanyInformation.Address) { }
            column(Company_Address_2; CompanyInformation."Address 2") { }
            column(Company_City; CompanyInformation.City) { }
            column(Company_Post_Code; CompanyInformation."Post Code") { }
            column(Company_Country; CompanyInformation."Country/Region Code") { }
            column(Company_phone; CompanyInformation."Phone No.") { }
            column(Company_Bank_No; CompanyInformation."Bank Account No.") { }
            column(Company_Bank_Name; CompanyInformation."Bank Name") { }
            column(Company_Bank_Branch; CompanyInformation."Bank Branch No.") { }
            column(No_; "No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Direktur; Direktur) { }
            dataitem(Line; "Sales Line")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Document No." = field("No.");
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Amount; "Line Amount") { }
                column(Description; Description) { }
                column(VAT_Base_Amount; "VAT Base Amount") { }
                column(VAT__; "VAT %") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(totalvat; totalvat) { }
                column(amount; _amount) { }
                column(getwhtamount; getwhtamount()) { }
                column(getlineamount; getlineamount()) { }
                column(getvat; _totalvat) { }
                column(total; _total) { }
                column(RLU_DRC_Percentage; "RLU DRC Percentage") { }
                column(RLU_Dry_Unit_Price; "RLU Dry Unit Price") { }
                column(RLU_Dry_Quantity; "RLU Dry Quantity") { }
                trigger OnPreDataItem()
                begin
                    Line.SetRange(IsWHTCalc, false);
                    Line.SetRange(Type, Line.Type::Item);
                end;

            }

            trigger OnAfterGetRecord()
            var
            begin
                _totalvat := getvat() - getlineamount();
                _total := (getlineamount() + _totalvat) - getwhtamount();
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
                    field(Direktur; Direktur)
                    {
                        ApplicationArea = All;
                        Caption = 'Direktur';
                        ToolTip = 'Direktur';
                        TableRelation = Employee;
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                            if RLUEmployee.Get(Direktur) then
                                Direktur := RLUEmployee.FullName();
                        end;
                    }
                }
            }
        }
    }
    rendering
    {
        layout(layoutName)
        {
            Type = RDLC;
            LayoutFile = './app/src/rdl/RLUProformaInvoice.rdl';
        }
    }

    trigger OnInitReport()
    begin
        CompanyInformation.get();
        CompanyInformation.CalcFields(Picture);

    end;

    var
        CompanyInformation: Record "Company Information";
        RLUEmployee: Record Employee;
        Direktur: Text[100];
        totalvat: Decimal;
        _amount: Decimal;
        _totalvat: decimal;
        _total: decimal;

    local procedure getwhtamount(): decimal
    var
        SalesLine: Record "Sales Line";


    begin
        SalesLine.SetRange("Document No.", Header."No.");
        SalesLine.SetFilter(Type, '%1', SalesLine.Type::"G/L Account");
        SalesLine.SetFilter(IsWHTCalc, '%1', true);
        if SalesLine.FindSet() then begin
            SalesLine.CalcSums(WHTAmount);
            exit(SalesLine.WHTAmount);
        end;
    end;

    local procedure getlineamount(): decimal
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", Header."No.");
        SalesLine.SetFilter(Type, '%1', SalesLine.Type::"G/L Account");
        SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
        if SalesLine.FindSet() then begin
            SalesLine.CalcSums("Line Amount");
            exit(SalesLine."Line Amount");
        end;
    end;

    local procedure getvat(): decimal
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", Header."No.");
        SalesLine.SetFilter(Type, '%1', SalesLine.Type::"G/L Account");
        SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
        if SalesLine.FindSet() then begin
            SalesLine.CalcSums("Amount Including VAT");
            exit(SalesLine."Amount Including VAT");
        end;
    end;

}