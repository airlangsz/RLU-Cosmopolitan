report 50109 "RLU Surat Jalan"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Surat Jalan';
    RDLCLayout = './app/src/rdl/RLUSuratJalan.rdl';

    dataset
    {
        dataitem(Header; "Warehouse Shipment Header")
        {
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
            column(No_; "No.") { }
            column(Pick_Qty_; Pick_Qty_) { }
            column(Source_No_; Source_No_) { }
            column(item_Description; Description) { }
            column(Registered_No_; Registered_No_) { }
            column(Lot_No_; Lot_No_) { }
            column(Blanket_Order_No_; Blanket_Order_No_) { }
            column(Quantity; Quantity) { }
            column(Unit_of_Measure; Unit_of_Measure) { }
            column(Unit_Cost; Unit_Cost) { }
            column(Line_Amount; Line_Amount) { }
            column(Description; Description) { }
            column(VAT_Base_Amount; VAT_Base_Amount) { }
            column(VAT__; VAT__) { }
            column(Amount_Including_VAT; Amount_Including_VAT) { }
            column(Seal_No; Seal_No) { }
            column(Container_No; Container_No) { }
            column(Truck_No; Truck_No_) { }
            column(Cuaca; Cuaca_) { }
            column(Start_Time; Start_Time_) { }
            column(End_Time; End_Time_) { }
            column(Ship_to_Code; Ship_to_Code) { }
            column(Vessel; Vessel) { }

            trigger OnPreDataItem()
            begin
                Header.SetRange("No.", _No);
            end;

            trigger OnAfterGetRecord()
            var
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
                "Reg_Whse_Activity_Line": Record "Registered Whse. Activity Line";
                WSLine: Record "Warehouse Shipment Line";
                Item_Variant: Record "Item Variant";
            begin
                //Warehouse Shipment Line
                WSLine.SetRange("No.", _No);
                if WSLine.FindFirst() then begin
                    Pick_Qty_ := WSLine."Pick Qty.";
                    Source_No_ := WSLine."Source No.";
                end;

                Item_Variant.SetRange("Item No.", _No);
                if Item_Variant.FindFirst() then
                    item_Description := Item_Variant.Description;

                //Warehouse Activity Line
                Reg_Whse_Activity_Line.SetRange("Action Type", Reg_Whse_Activity_Line."Activity Type"::Pick);
                Reg_Whse_Activity_Line.SetRange("Whse. Document No.", _No);
                if Reg_Whse_Activity_Line.FindFirst() then begin
                    Registered_No_ := Reg_Whse_Activity_Line."No.";
                    Lot_No_ := Reg_Whse_Activity_Line."Lot No.";
                end;

                //Sales Line
                SalesLine.SetRange("Document No.", WSLine."Source No.");
                if SalesLine.FindFirst() then begin
                    Blanket_Order_No_ := SalesLine."Blanket Order No.";
                    Quantity := SalesLine.Quantity;
                    Unit_of_Measure := SalesLine."Unit of Measure";
                    Unit_Cost := SalesLine."Unit Cost";
                    Line_Amount := SalesLine."Line Amount";
                    Description := SalesLine.Description;
                    VAT_Base_Amount := SalesLine."VAT Base Amount";
                    VAT__ := SalesLine."VAT %";
                    Amount_Including_VAT := SalesLine."Amount Including VAT";
                    Seal_No := SalesLine."RLU Seal No";
                    Vessel := SalesHeader."RLU Vessel/Voyage";
                end;

                //Sales Header
                SalesHeader.SetRange("No.", SalesLine."Document No.");
                if SalesHeader.FindFirst() then
                    Ship_to_Code := SalesHeader."Ship-to Code";
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
                    field(Truck_No; Truck_No_)
                    {
                        ApplicationArea = All;
                        Caption = 'Truck No';
                        ToolTip = 'Truck No';
                    }
                    field(Cuaca; Cuaca_)
                    {
                        ApplicationArea = All;
                        Caption = 'Weather';
                        ToolTip = 'Weather';
                    }
                    field(Start_Time; Start_Time_)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Time';
                        ToolTip = 'Start Time';
                    }
                    field(End_Time; End_Time_)
                    {
                        ApplicationArea = All;
                        Caption = 'End Time';
                        ToolTip = 'End Time';
                    }
                }
            }
        }
    }

    procedure SetParm(No_: Code[20])
    begin
        _No := No_;
    end;

    trigger OnInitReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Truck_No_: text[50];
        _No: Code[20];
        Cuaca_: Text[50];
        Ship_to_Code: Code[20];
        Blanket_Order_No_: Code[20];
        Quantity: Decimal;
        Unit_of_Measure: Text[50];
        Unit_Cost: Decimal;
        Line_Amount: Decimal;
        Description: Text[100];
        VAT_Base_Amount: Decimal;
        VAT__: Decimal;
        Amount_Including_VAT: Decimal;
        Start_Time_: Time;
        End_Time_: Time;
        Vessel: Text[50];
        Container_No: Text[50];
        Seal_No: Text[50];
        Registered_No_: Code[20];
        Lot_No_: Code[50];
        Pick_Qty_: Decimal;
        Source_No_: Code[50];
        item_Description: Text[100];
}