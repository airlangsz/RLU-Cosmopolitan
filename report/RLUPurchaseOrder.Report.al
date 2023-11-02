report 50107 "RLU Purchase Order"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Purchase Order';
    RDLCLayout = './app/src/rdl/RLUPurchaseOrder.rdl';

    dataset
    {
        dataitem(Header; "Purchase Header")
        {
            column(logo; CompanyInformation.Picture) { }
            column(Company_Name; CompanyInformation.Name) { }
            column(Company_Address; CompanyInformation.Address) { }
            column(Company_Address_2; CompanyInformation."Address 2") { }
            column(Company_City; CompanyInformation.City) { }
            column(Company_Post_Code; CompanyInformation."Post Code") { }
            column(Company_Country; CompanyInformation."Country/Region Code") { }
            column(Company_VAT_Regis; CompanyInformation."VAT Registration No.") { }
            column(Company_Phone; CompanyInformation."Phone No.") { }
            column(Company_Fax; CompanyInformation."Fax No.") { }
            column(No_; "No.") { }
            column(Order_Date; "Order Date") { }
            column(Vendor_No; "Buy-from Vendor No.") { }
            column(Vendor_Address; "Buy-from Address") { }
            column(Vendor_Address_2; "Buy-from Address 2") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Pay_to_Name; "Pay-to Name") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Payment_Method_Code; "Payment Method Code") { }
            column(Currency_Code; "Currency Code") { }
            column(Pay_to_Address; "Pay-to Address") { }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.") { }
            column(DocumentType; "Document Type") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Location_Code; "Location Code") { }

            column(getcountryname; getcountryname()) { }

            column(getcountrynameship; getcountrynameship()) { }

            column(countrynameship; countrynameship) { }

            column(getdesc; getdesc) { }

            column(getloc; getloc) { }

            column(getnamepurchaser; getnamepurchaser) { }
            column(getemailpurchaser; getemailpurchaser) { }
            column(emplyee; emplyee)
            {

            }


            column(jobbtitle; jobbtitle)
            {

            }

            column(fullname; fullname)
            {

            }


            column(Promised_Receipt_Date; "Promised Receipt Date") { }
            dataitem(Line; "Purchase Line")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Document No." = field("No.");

                column(Quantity; Quantity) { }
                column(Qty__to_Receive; "Qty. to Receive") { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Line_Amount; "Line Amount") { }
                column(Document_Type; "Document Type") { }
                column(Description; Description) { }
                column(VAT_Base_Amount; "VAT Base Amount") { }
                column(VAT__; "VAT %") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(totalvat; totalvat) { }
                column(amount; _amount) { }

                column(getphono; getphono()) { }
                column(getfax; getfax()) { }

                trigger OnPreDataItem()
                begin
                    Line.SetRange(Type, Line.Type::Item);
                    Line.SetRange(IsWHTCalc, false);
                end;
            }
            column(NPWP; Buy_NPWP) { }
            column(Vendor_Name; Buy_Vendor_Name) { }
            column(Vendor_contact; Buy_Vendor_Contact) { }
            column(Vendor_Phone_No_; Buy_Vendor_Phone_No) { }
            column(Vendor_Fax_No_; Buy_Vendor_Fax_No) { }
            column(Pay_NPWP; Pay_NPWP) { }
            column(Pay_Vendor_Name; Pay_Vendor_Name) { }
            column(Pay_Vendor_contact; Pay_Vendor_contact) { }
            column(Pay_Vendor_Phone_No_; Pay_Vendor_Phone_No) { }
            column(Pay_Vendor_Fax_No_; Pay_Vendor_Fax_No) { }
            column(Pay_Country_Region_Code; Pay_Country_Region_Code) { }
            column(Purchaser_Name; Purchaser_Name) { }
            column(Purchaser_E_Mail; Purchaser_E_Mail) { }
            column(Purchaser_Phone_No_; Purchaser_Phone_No) { }

            trigger OnAfterGetRecord()
            var
                Vendor_Pay: Record Vendor;
                Vendor_Buy: Record Vendor;
                "SalespersonPurchaser": Record "Salesperson/Purchaser";
            begin
                if Vendor_Buy.Get(Header."Buy-from Vendor No.") then begin
                    Buy_NPWP := Vendor_Buy.NPWP;
                    Buy_Vendor_Name := Vendor_Buy.Name;
                    Buy_Vendor_contact := Vendor_Buy.Contact;
                    Buy_Vendor_Phone_No := Vendor_Buy."Phone No.";
                    Buy_Vendor_Fax_No := Vendor_Buy."Fax No.";
                    Buy_Country_Region_Code := Vendor_Buy."Country/Region Code";
                end;

                if Vendor_Pay.Get(Header."Pay-to Vendor No.") then begin
                    Pay_NPWP := Vendor_Pay.NPWP;
                    Pay_Vendor_Name := Vendor_Pay.Name;
                    Pay_Vendor_contact := Vendor_Pay.Contact;
                    Pay_Vendor_Phone_No := Vendor_Pay."Phone No.";
                    Pay_Vendor_Fax_No := Vendor_Pay."Fax No.";
                    Pay_Country_Region_Code := Vendor_Pay."Country/Region Code";
                end;

                if SalespersonPurchaser.Get(Header."Purchaser Code") then begin
                    Purchaser_Name := SalespersonPurchaser.Name;
                    Purchaser_E_Mail := SalespersonPurchaser."E-Mail";
                    Purchaser_Phone_No := SalespersonPurchaser."Phone No.";
                end;
                Line.SetRange("Document Type", Header."Document Type"::Order);
                Line.SetRange(IsWHTCalc, false);
                CalcFields("Amount Including VAT", Amount);
                totalvat := "Amount Including VAT" - Amount;
                _amount := "Amount Including VAT";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Employee; emplyee)
                    {
                        ApplicationArea = All;
                        TableRelation = Employee;
                        trigger OnValidate()
                        var

                            employe: Record Employee;
                        begin
                            if employe.Get(emplyee) then begin
                                emplyee := employe.FullName();
                                fullname := employe.FullName();
                                jobbtitle := employe."Job Title";
                            end
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
        country: Record "Country/Region";
        totalvat: Decimal;
        _amount: Decimal;
        Pay_NPWP: Code[15];
        Pay_Vendor_Name: Text[100];
        Pay_Vendor_contact: Text[100];
        Pay_Vendor_Phone_No: Text[100];
        Pay_Vendor_Fax_No: Text[100];
        Pay_Country_Region_Code: Text[100];
        Buy_NPWP: Code[15];
        Buy_Vendor_Name: Text[100];
        Buy_Vendor_contact: Text[100];
        Buy_Vendor_Phone_No: Text[100];
        Buy_Vendor_Fax_No: Text[100];
        Buy_Country_Region_Code: Text[100];
        Purchaser_Name: Text[100];
        Purchaser_E_Mail: Text[100];
        Purchaser_Phone_No: Text[100];

        countryname: Text[50];
        countrynameship: Text[50];
        emplyee: Text[100];
        fullname: text[100];
        text100: Text;
        jobbtitle: text[50];

    local procedure getcountryname(): Text[100]
    var
        country: Record "Country/Region";

    begin
        country.SetRange(Code, CompanyInformation."Country/Region Code");
        if country.FindSet() then
            exit(country.Name);
    end;

    local procedure getdesc(): Text[100]
    var
        shipment: Record "Shipment Method";

    begin
        shipment.SetRange(Code, Header."Shipment Method Code");
        if shipment.FindSet() then
            exit(shipment.Description);
    end;

    local procedure getloc(): Text[100]
    var
        Location: Record Location;

    begin
        Location.SetRange(Code, Header."Location Code");
        if Location.FindSet() then
            exit(Location.Name);
    end;

    local procedure getcountrynameship(): Text[100]
    var
        country: Record "Country/Region";

    begin
        country.SetRange(Code, Header."Ship-to Country/Region Code");
        if country.FindSet() then
            exit(country.Name);
    end;

    local procedure getnamepurchaser(): Text[50]
    var
        myInt: Integer;
        purchaser: Record "Salesperson/Purchaser";
    begin
        purchaser.SetRange(Code, Header."Purchaser Code");
        if purchaser.FindSet() then
            exit(purchaser.Name)
    end;

    local procedure getemailpurchaser(): Text[80]
    var
        myInt: Integer;
        purchaser: Record "Salesperson/Purchaser";
    begin
        purchaser.SetRange(Code, Header."Purchaser Code");
        if purchaser.FindSet() then
            exit(purchaser."E-Mail")
    end;


    local procedure getphono(): Text[30]
    var
        location: Record "location";

    begin
        location.SetRange(Code, Header."Location Code");
        if location.FindSet() then
            exit(location."Phone No.");
    end;

    local procedure getfax(): Text[30]
    var
        location: Record "location";

    begin
        location.SetRange(Code, Header."Location Code");
        if location.FindSet() then
            exit(location."Fax No.");
    end;
}