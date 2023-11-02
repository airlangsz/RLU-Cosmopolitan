report 50110 "RLU Shipping Instruction"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Shipping Instruction';
    RDLCLayout = './app/src/rdl/RLUShippingInstruction.rdl';

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            column(logo; CompanyInformation.Picture) { }
            column(Company_Name; CompanyInformation.Name) { }
            column(Company_Address; CompanyInformation.Address) { }
            column(Company_Address_2; CompanyInformation."Address 2") { }
            column(Company_City; CompanyInformation.City) { }
            column(Company_Post_Code; CompanyInformation."Post Code") { }
            column(Company_Country; CompanyInformation."Country/Region Code") { }
            column(Company_Phone; CompanyInformation."Phone No.") { }
            column(Company_fax; CompanyInformation."Fax No.") { }
            column(No_; "No.") { }
            column(Order_Date; "Order Date") { }
            column(Customer_No_; "Sell-to Customer No.") { }
            column(Customer_Address; "Sell-to Address") { }
            column(Customer_Address_2; "Sell-to Address 2") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Payment_Method_Code; "Payment Method Code") { }
            column(Currency_Code; "Currency Code") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Shipping_Agent_Code; "Shipping Agent Code") { }
            column(RLU_BKG_Ref; "RLU BKG Ref") { }
            column(RLU_Country_of_Origin; GetNameCountry()) { }
            column(RLU_Feeder; "RLU Feeder") { }
            column(RLU_Notify; "RLU Notify") { }
            column(RLU_Place_of_Delivery; "RLU Place of Delivery") { }
            column(RLU_Port_of_Discharge; "RLU Port of Discharge") { }
            column(RLU_Service_Contract; "RLU Service Contract") { }
            column(RLU_Stuffing_Plan; "RLU Stuffing Plan") { }
            column(RLU_Vessel_Voyage; "RLU Vessel/Voyage") { }
            column(RLU_Via; "RLU Via") { }
            column(getaddresship; getaddresship()) { }
            column(getdesc; getdesc()) { }

            column(GetdescBKG; GetdescBKG()) { }
            column(Getdescvia; Getdescvia()) { }
            column(Work_Description; GetWorkDescription()) { }


            column(emplyee; emplyee)
            {

            }


            column(jobbtitle; jobbtitle)
            {

            }

            column(fullname; fullname)
            {

            }
            column(getaddresshipHP; getaddresshipHP())
            {

            }
            column(getaddresshipFax; getaddresshipFax())
            {

            }

            column(getaddresshipNotify; getaddresshipNotify())
            {

            }
            column(getaddresshipNotifyTelp; getaddresshipNotifyTelp())
            {

            }
            column(getaddresshipNotifyfax; getaddresshipNotifyfax())
            {

            }

            column(getaddresshipEmail; getaddresshipEmail())
            {

            }


            column(getaddresshipNotifyEmail; getaddresshipNotifyEmail())
            {

            }
            column(GetWorkDescription; GetWorkDescription())
            {

            }


            dataitem(Line; "Sales Line")
            {
                DataItemLinkReference = Header;
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                column(Quantity; Quantity) { }
                column(Qty__Shipped__Base_; "Qty. Shipped (Base)") { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Amount; "Line Amount") { }
                column(Document_Type; "Document Type") { }
                column(Description; Description) { }
                column(VAT_Base_Amount; "VAT Base Amount") { }
                column(VAT__; "VAT %") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(Blanket_Order_No_; "Blanket Order No.") { }

                column(RLU_SMPT_Lot_No; "RLU SMPT Lot No") { }
                column(RLU_MKC_Lot_No; "RLU MKC Lot No") { }

                column(RLU_Package_Type; "RLU Package Type") { }

                column(RLU_Dry_Unit_Price; "RLU Dry Unit Price") { }

                column(Gross_Weight; "Gross Weight") { }
                column(Net_Weight; "Net Weight") { }

                column(GetdescWeightPacking; GetdescWeightPacking()) { }
                column(GetPackingType; GetPackingType()) { }

                column(getDescComment; getDescComment()) { }


                column(blanketorderno; blanketorderno()) { }
                column(Variant_Code; "Variant Code") { }
                column(Type; Type) { }

                column(Pallet_Quantity; "Pallet Quantity") { }
                column(Item_Reference_No_; "Item Reference No.") { }
                column(ItemOnly; ItemOnly()) { }
                column(countitem; countitem) { }
                column(NW; "Net Weight") { }
                column(GW; "Gross Weight") { }
                column(palletitem; palletitem()) { }
                column(grosstitem; grosstitem()) { }
                column(smptlotno; smptlotno()) { }
                column(mkclotno; mkclotno()) { }

                column(palletlop; palletlop()) { }
                column(mkclotnodanpallet; mkclotnodanpallet()) { }
                column(Container_No; "Container No") { }
                column(RLU_Seal_No; "RLU Seal No") { }

                column(Getdescvariant; Getdescvariant()) { }

                trigger OnPreDataItem()
                var
                begin
                    Line.SetFilter(Type, '%1', Type::Item);
                end;
            }
            column(Customer_Sell_NPWP; Customer_Sell_NPWP) { }
            column(Customer_Sell_Name; Customer_Sell_Name) { }
            column(CCustomer_Sell_contact; Customer_Sell_contact) { }
            column(Customer_Sell_Phone_No_; Customer_Sell_Phone_No_) { }
            column(Customer_Sell_Fax_No_; Customer_Sell_Fax_No_) { }
            column(Customer_Sell_Country_Region_Code; Customer_Sell_Country_Region_Code) { }
            column(Customer_Bill_NPWP; Customer_Bill_NPWP) { }
            column(Customer_Bill_Name; Customer_Bill_Name) { }
            column(Customer_Bill_contact; Customer_Bill_contact) { }
            column(Customer_Bill_Phone_No_; Customer_Bill_Phone_No_) { }
            column(Customer_Bill_Fax_No_; Customer_Bill_Phone_No_) { }
            column(Customer_Bill_Country_Region_Code; Customer_Bill_Country_Region_Code) { }
            column(Purchaser_Name; Purchaser_Name) { }
            column(Purchaser_E_Mail; Purchaser_E_Mail) { }
            column(Purchaser_Phone_No_; Purchaser_Phone_No) { }
            column(Packing_Boxes; Packing_Boxes) { }
            column(Max_Payload; Max_Payload) { }
            trigger OnPreDataItem()
            var
            begin
                Header.SetRange("No.", _No);
            end;

            trigger OnAfterGetRecord()
            var
                Customer_Bill: Record Customer;
                Customer_Sell: Record Customer;
            begin

                if Customer_Bill.Get(Header."Bill-to Customer No.") then begin
                    Customer_Bill_NPWP := Customer_Bill.NPWP;
                    Customer_Bill_Name := Customer_Bill.Name;
                    Customer_Bill_contact := Customer_Bill.Contact;
                    Customer_Bill_Phone_No_ := Customer_Bill."Phone No.";
                    Customer_Bill_Fax_No_ := Customer_Bill."Fax No.";
                    Customer_Bill_Country_Region_Code := Customer_Bill."Country/Region Code";
                end;

                if Customer_Sell.Get(Header."Sell-to Customer No.") then begin
                    Customer_Sell_NPWP := Customer_Sell.NPWP;
                    Customer_Sell_Name := Customer_Sell.Name;
                    Customer_Sell_contact := Customer_Sell.Contact;
                    Customer_Sell_Phone_No_ := Customer_Sell."Phone No.";
                    Customer_Sell_Fax_No_ := Customer_Sell."Fax No.";
                    Customer_Sell_Country_Region_Code := Customer_Sell."Country/Region Code";
                end;

                if SalespersonPurchaser.Get(Header."Salesperson Code") then begin
                    Purchaser_Name := SalespersonPurchaser.Name;
                    Purchaser_E_Mail := SalespersonPurchaser."E-Mail";
                    Purchaser_Phone_No := SalespersonPurchaser."Phone No.";
                end
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
                        ToolTip = 'Nama Karyawan';
                        Caption = 'Employee';
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

    procedure SetParm(No_: Code[20])
    begin
        _No := No_;
    end;

    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        _No: Code[20];
        Customer_Bill_NPWP: Code[15];
        Customer_Bill_Name: Text[100];
        Customer_Bill_contact: Text[100];
        Customer_Bill_Phone_No_: Text[30];
        Customer_Bill_Fax_No_: Text[30];
        Customer_Bill_Country_Region_Code: Text[30];
        Customer_Sell_NPWP: code[15];
        Customer_Sell_Name: Text[100];
        Customer_Sell_contact: Text[100];
        Customer_Sell_Phone_No_: Text[30];
        Customer_Sell_Fax_No_: Text[30];
        Customer_Sell_Country_Region_Code: text[30];
        Purchaser_Name: Text[50];
        Purchaser_E_Mail: Text[80];
        Purchaser_Phone_No: Text[30];
        Packing_Boxes: Decimal;

        Max_Payload: Decimal;
        emplyee: Text[100];
        fullname: text[100];
        jobbtitle: text[50];
        countitem: Integer;




    local procedure getaddresshipHP(): Text[80]
    var
        ShipToAddress_: Record "Ship-to Address";
    begin
        ShipToAddress_.SetRange(Code, Header."Ship-to Code");
        if ShipToAddress_.FindFirst() then
            exit(ShipToAddress_."Phone No.")
    end;

    local procedure getaddresshipFax(): Text[80]
    var
        ShipToAddress_: Record "Ship-to Address";
    begin
        ShipToAddress_.SetRange(Code, Header."Ship-to Code");
        if ShipToAddress_.FindFirst() then
            exit(ShipToAddress_."Fax No.")
    end;

    local procedure getaddresship(): Text[100]
    var
        ShipToAddress_: Record "Ship-to Address";
    begin
        ShipToAddress_.SetRange(Code, Header."RLU Notify");
        if ShipToAddress_.FindFirst() then
            exit(ShipToAddress_.Address)
    end;

    local procedure getaddresshipNotify(): Text[80]
    var
        ShipToAddress_: Record "Ship-to Address";
    begin
        ShipToAddress_.SetRange(Code, Header."RLU Notify");
        if ShipToAddress_.FindFirst() then
            exit(ShipToAddress_."Address 2")
    end;

    local procedure getaddresshipNotifyTelp(): Text[30]
    var
        ShipToAddress_: Record "Ship-to Address";
    begin
        ShipToAddress_.SetRange(Code, Header."RLU Notify");
        if ShipToAddress_.FindFirst() then
            exit(ShipToAddress_."Phone No.")
    end;

    local procedure getaddresshipNotifyfax(): Text[30]
    var
        ShipToAddress_: Record "Ship-to Address";
    begin
        ShipToAddress_.SetRange(Code, Header."RLU Notify");
        if ShipToAddress_.FindFirst() then
            exit(ShipToAddress_."Fax No.")
    end;

    local procedure getaddresshipEmail(): Text[80]
    var
        ShipToAddress_: Record "Ship-to Address";
    begin
        ShipToAddress_.SetRange(Code, Header."Ship-to Code");
        if ShipToAddress_.FindFirst() then
            exit(ShipToAddress_."E-Mail")
    end;

    local procedure getaddresshipNotifyEmail(): Text[80]
    var
        ShipToAddress_: Record "Ship-to Address";
    begin
        ShiptoAddress_.SetRange(Code, Header."RLU Notify");
        if ShipToAddress_.FindFirst() then
            exit(ShipToAddress_."E-Mail")
    end;


    local procedure GetdescBKG(): Text[50]
    var
        RLUdefaultcode: Record "RLU Default Code";
    begin
        RLUdefaultcode.SetRange(Code, Header."RLU BKG Ref");
        if RLUdefaultcode.FindSet() then
            repeat
            until RLUdefaultcode.Next() = 0;
        exit(RLUdefaultcode.Description)
    end;

    local procedure GetPackingType(): Text[50]
    var
        RLUdefaultcode: Record "RLU Default Code";
    begin
        RLUdefaultcode.SetRange(Code, Line."RLU Package Type");
        if RLUdefaultcode.FindSet() then
            repeat
            until RLUdefaultcode.Next() = 0;
        exit(RLUdefaultcode.Description)
    end;

    local procedure Getdescvia(): Text[50]
    var
        RLUdefaultcode: Record "RLU Default Code";
    begin
        RLUdefaultcode.SetRange(Code, Header."RLU Via");
        if RLUdefaultcode.FindSet() then
            repeat
            until RLUdefaultcode.Next() = 0;
        exit(RLUdefaultcode.Description)
    end;





    local procedure GetdescWeightPacking(): Text[50]
    var
        RLUdefaultcode: Record "RLU Default Code";
    begin
        RLUdefaultcode.SetRange(Code, Line."RLU Weight Packing");
        if RLUdefaultcode.FindSet() then
            repeat
            until RLUdefaultcode.Next() = 0;
        exit(RLUdefaultcode.Description)
    end;


    // local procedure Getdescvariant(): Text[50]
    // var
    //     RLUdefaultcode: Record "RLU Default Code";
    // begin
    //     RLUdefaultcode.SetRange(Code, Line."Variant Code");
    //     if RLUdefaultcode.FindFirst() then
    //         // repeat
    //         // until RLUdefaultcode.Next() = 0;
    //     exit(RLUdefaultcode.Description)
    // end;

    local procedure Getdescvariant(): Text[100]
    var
        ItemVariant: Record "Item Variant";
    begin
        ItemVariant.SetRange(Code, line."Variant Code");
        ItemVariant.FindSet();
        repeat
        until ItemVariant.Next() = 0;
        exit(ItemVariant.Description)
    end;


    local procedure getdesc(): Text[100]
    var
        ShipmentMethod: Record "Shipment Method";

    begin
        ShipmentMethod.SetRange(Code, Header."Shipment Method Code");
        if ShipmentMethod.FindSet() then
            repeat
            until ShipmentMethod.Next() = 0;
        exit(ShipmentMethod.Description);
    end;

    local procedure GetNameCountry(): Text[50]
    var
        RLUdefaultcode: Record "RLU Default Code";

    begin
        RLUdefaultcode.SetRange(Code, Header."RLU Country of Origin");
        if RLUdefaultcode.FindSet() then
            repeat
            until RLUdefaultcode.Next() = 0;
        exit(RLUdefaultcode.Description);
    end;

    local procedure getDescComment(): Text[100]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", _No);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetFilter(Type, '%1', Line.Type::" ");
            repeat
            until SalesHeader.Next() = 0;
            if SalesLine.FindSet() then
                repeat
                until SalesLine.Next() = 0;
            exit(SalesLine.Description);
        end;
    end;

    local procedure ItemOnly(): Enum "Sales Line Type";
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", _No);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
            repeat
            until SalesHeader.Next() = 0;
            if SalesLine.FindSet() then
                countitem := SalesLine.Count;
        end;
    end;

    local procedure palletitem(): Integer;
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", _No);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
            repeat
            until SalesHeader.Next() = 0;
            if SalesLine.FindSet() then
                repeat
                    exit(SalesLine."Pallet Quantity");
                until SalesLine.Next() = 0;
        end;
    end;

    local procedure grosstitem(): Decimal;
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", _No);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
            repeat
            until SalesHeader.Next() = 0;
            if SalesLine.FindSet() then
                repeat
                    exit(SalesLine."Gross Weight");
                until SalesLine.Next() = 0;
        end;
    end;



    local procedure blanketorderno(): Code[1000]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RLUSalesLine: Query "RLU SalesLine";
        textloop: Text[1000];
        string: Text;
        where: Text;
        which: Text;
    begin
        SalesHeader.SetRange("No.", _No);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            repeat
            until SalesHeader.Next() = 0;
            if SalesLine.FindSet() then begin
                RLUSalesLine.SetRange(RLUSalesLine.Document_No_, SalesLine."Document No.");
                repeat
                until SalesLine.Next() = 0;
                RLUSalesLine.Open();
                while RLUSalesLine.Read() do
                    textloop += RLUSalesLine.Blanket_Order_No_ + ',';
                RLUSalesLine.Close();
                where := '>';
                which := ',';
                string := DelChr(textloop, where, which);
                exit(string);
            end;
        end;
    end;

    local procedure smptlotno(): Text
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RLUBlanketorder: Query "RLU Blanket Order";
        textloop: Text[1000];
        string: Text;
        where: Text;
        which: Text;
    begin
        SalesHeader.SetRange("No.", _No);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            repeat
            until SalesHeader.Next() = 0;
            if SalesLine.FindSet() then begin
                repeat
                until SalesLine.Next() = 0;
                RLUBlanketorder.SetRange(RLUBlanketorder.Document_No_, SalesLine."Document No.");
                RLUBlanketorder.SetFilter(RLUBlanketorder.Type, '%1', SalesLine.Type::Item);
                RLUBlanketorder.Open();
                while RLUBlanketorder.Read() do
                    textloop += RLUBlanketorder.RLU_SMPT_Lot_No + ',';
                RLUBlanketorder.Close();
                where := '>';
                which := ',';
                string := DelChr(textloop, where, which);
                exit(string);
            end;
        end;
    end;

    local procedure palletlop(): Code[1000]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RLUBlanketorder: Query "RLU Blanket Order";
        textloop: Text[1000];
    begin
        SalesHeader.SetRange("No.", _No);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            repeat
            until SalesHeader.Next() = 0;
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            if SalesLine.FindSet() then begin
                repeat
                until SalesLine.Next() = 0;
                RLUBlanketorder.SetRange(RLUBlanketorder.Document_No_, SalesLine."Document No.");
                RLUBlanketorder.SetFilter(RLUBlanketorder.Type, '%1', SalesLine.Type::Item);
                RLUBlanketorder.Open();
                while RLUBlanketorder.Read() do
                    textloop += Format(RLUBlanketorder.Pallet_Quantity);
                RLUBlanketorder.Close();
                exit(textloop);
            end;
        end;
    end;

    local procedure mkclotno(): Code[1000]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RLUBlanketorder: Query "RLU Blanket Order";
        textloop: Text[1000];
    begin
        SalesHeader.SetRange("No.", _No);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            repeat
            until SalesHeader.Next() = 0;
            if SalesLine.FindSet() then begin
                repeat
                until SalesLine.Next() = 0;
                RLUBlanketorder.SetRange(RLUBlanketorder.Document_No_, SalesLine."Document No.");
                RLUBlanketorder.SetFilter(RLUBlanketorder.Type, '%1', SalesLine.Type::Item);
                RLUBlanketorder.Open();
                while RLUBlanketorder.Read() do
                    textloop += RLUBlanketorder.RLU_MKC_Lot_No + Format(RLUBlanketorder.Pallet_Quantity) + '   ,    ';
                RLUBlanketorder.Close();
                exit(textloop);
            end;
        end;
    end;

    local procedure mkclotnodanpallet(): Text
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RLUBlanketorder: Query "RLU Blanket Order";
        textloop: Text[1000];
        string: Text;
        where: Text;
        which: Text;
    begin
        SalesHeader.SetRange("No.", _No);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            repeat
            until SalesHeader.Next() = 0;

            SalesLine.SetRange("Document No.", SalesHeader."No.");
            if SalesLine.FindSet() then begin
                repeat
                until SalesLine.Next() = 0;
                RLUBlanketorder.SetRange(RLUBlanketorder.Document_No_, SalesLine."Document No.");
                RLUBlanketorder.SetFilter(RLUBlanketorder.Type, '%1', SalesLine.Type::Item);
                RLUBlanketorder.Open();
                while RLUBlanketorder.Read() do
                    textloop += RLUBlanketorder.RLU_MKC_Lot_No + '(' + Format(RLUBlanketorder.Pallet_Quantity) + ')' + ',';
                RLUBlanketorder.Close();
                where := '>';
                which := ',';
                string := DelChr(textloop, where, which);
                exit(string);
            end;
        end;
    end;
}