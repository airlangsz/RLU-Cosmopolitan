report 50103 "RLU Instruksi Penurunan Produk"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Instruksi Penurunan Produk Akhir';
    DefaultLayout = RDLC;
    RDLCLayout = './app/src/rdl/RLUInstruksiPenurunanProdukAkhir.rdl';

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            column(Picture; CompanyInformation.Picture) { }
            column(Name; CompanyInformation.Name) { }
            column(No_; "No.") { }
            column(PostingDate; "Posting Date") { }
            column(Location_Code; "Location Code") { }
            column(DocNo; "No.") { }
            column(S_I_NO; SINO()) { }
            column(ContractNo; ContractNo()) { }
            column(Condition; Condition_) { }
            column(Truck_No_; "TruckNo_") { }
            column(Driver; Driver_) { }
            column(Weather; Weather_) { }
            column(Start_Time; "StartTime_") { }
            column(End_Time; "EndTime_") { }
            column(PackageNo; PackageNo()) { }


            dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
            {
                DataItemLink = "No." = field("No."), "Activity Type" = field(Type);
                column(PalletCode; "Bin Code") { }
                column(ProductType; "Variant Code") { }
                column(ProductWeight; Quantity) { }
                column(PalletType; PalletType()) { }
                column(PalletWeight; PalletWeight()) { }
                column(Destination; Destination()) { }
                column(Vessel; Vessel()) { }
                column(ContainerNo; '-') { }
                column(Seal; Seal()) { }
                trigger OnAfterGetRecord()
                begin
                    "Warehouse Activity Line".SetFilter("Action Type", '%1', "Warehouse Activity Line"."Action Type"::Take);
                    // "Warehouse Activity Line".SetRange("No.", No_);
                end;
            }
            trigger OnPreDataItem()
            begin
                "Warehouse Activity Header".SetRange("No.", No_);
            end;

            trigger OnAfterGetRecord()
            var
            begin
                // "Warehouse Activity Line".CalcSums(Quantity);
                // Total := PalletWeight() + "Warehouse Activity Line".Quantity;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Product Loading Instruction")
                {
                    Caption = 'Product Loading Instruction';
                    field("Truck No."; "TruckNo_")
                    {
                        Caption = 'Truck No.';
                        Editable = true;
                        ApplicationArea = all;
                        ToolTip = 'Truck No.';
                    }
                    field(Driver; Driver_)
                    {
                        Caption = 'Driver';
                        Editable = true;
                        ApplicationArea = all;
                        ToolTip = 'Driver';
                    }
                    field(Condition; Condition_)
                    {
                        Caption = 'Condition';
                        Editable = true;
                        ApplicationArea = all;
                        ToolTip = 'Condition';
                    }
                    field(Weather; Weather_)
                    {
                        Caption = 'Weather';
                        ApplicationArea = all;
                        Editable = true;
                        ToolTip = 'Weather';
                    }
                    field("Start Time"; "StartTime_")
                    {
                        ApplicationArea = all;
                        Caption = 'Starting Time';
                        Editable = true;
                        ToolTip = 'Starting Time';
                    }
                    field("End Time"; "EndTime_")
                    {
                        ApplicationArea = all;
                        Caption = 'Ending Time';
                        Editable = true;
                        ToolTip = 'Ending Time';
                    }
                }
            }
        }
    }
    trigger OnInitReport()
    var
    begin
        CompanyInformation.get();
        CompanyInformation.CalcFields(Picture);
    end;

    local procedure PackageNo(): Code[1000]
    var
        RLUPackageNo: Query "RLU Package No";
        textloop: Text[1000];
    begin
        RLUPackageNo.SetFilter(RLUPackageNo.No_, "Warehouse Activity Line"."No.");
        RLUPackageNo.SetRange(RLUPackageNo.Action_Type, "Warehouse Activity Line"."Action Type"::Take);
        RLUPackageNo.Open();
        while RLUPackageNo.Read() do
            textloop += RLUPackageNo.Package_No_ + '    ';
        RLUPackageNo.Close();
        exit(textloop);

    end;

    local procedure "ContractNo"(): Code[20]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", "Warehouse Activity Line"."Source No.");
        if SalesHeader.FindFirst() then
            SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindFirst() then
            exit(SalesLine."Blanket Order No.");
    end;

    local procedure "SINO"(): Code[50]
    var
        WarehouseActivityLine: Record "Warehouse Activity Line";
    begin
        WarehouseActivityLine.SetRange("No.", "Warehouse Activity Header"."No.");
        WarehouseActivityLine.SetFilter("Action Type", '%1', "Warehouse Activity Line"."Action Type"::Take);
        if WarehouseActivityLine.FindFirst() then
            exit(WarehouseActivityLine."Source No.");
    end;

    local procedure Destination(): Code[50]
    var
        SalesHeader: Record "Sales Header";
        WarehouseActivityLine: Record "Warehouse Activity Line";

    begin
        WarehouseActivityLine.SetRange("No.", "Warehouse Activity Header"."No.");
        WarehouseActivityLine.SetFilter("Action Type", '%1', WarehouseActivityLine."Action Type"::Take);
        if WarehouseActivityLine.FindFirst() then begin
            SalesHeader.SetRange("No.", WarehouseActivityLine."Source No.");
            if SalesHeader.FindFirst() then
                exit(SalesHeader."Ship-to Code");
        end
    end;

    procedure Vessel(): Code[50]
    var
        SalesHeader: Record "Sales Header";
        WarehouseActivityLine: Record "Warehouse Activity Line";
    // SalesLine: Record "Sales Line";

    begin
        WarehouseActivityLine.SetRange("No.", "Warehouse Activity Header"."No.");
        WarehouseActivityLine.SetFilter("Action Type", '%1', WarehouseActivityLine."Action Type"::Take);
        if WarehouseActivityLine.FindFirst() then begin
            SalesHeader.SetRange("No.", WarehouseActivityLine."Source No.");
            if SalesHeader.FindFirst() then
                exit(SalesHeader."RLU Vessel/Voyage");
        end
    end;

    procedure ContainerNo(): Code[50]
    var

    // TBC

    // SalesHeader: Record "Sales Header";
    // SalesLine: Record "Sales Line";
    begin
    end;

    procedure Seal(): Code[50]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", "Warehouse Activity Line"."Source No.");
        if SalesHeader.FindFirst() then
            SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindFirst() then
            exit(SalesLine."RLU Seal No")
    end;

    local procedure PalletType(): Code[50]
    var
        SalesLine: Record "Sales Line";
    // WarehouseActivityLine: Record "Warehouse Activity Line";
    begin
        // SalesLine.Get("Warehouse Activity Line"."Source No.");
        "Warehouse Activity Line".SetFilter("Action Type", '%1', "Warehouse Activity Line"."Action Type"::Take);
        SalesLine.SetRange("Document No.", "Warehouse Activity Line"."Source No.");
        SalesLine.SetRange("Line No.", "Warehouse Activity Line"."Source Line No.");
        if not SalesLine.IsEmpty() then
            exit(SalesLine."RLU Package Type");
    end;


    local procedure PalletWeight(): Code[50]
    var
        SalesLine: Record "Sales Line";
    // WarehouseActivityLine: Record "Warehouse Activity Line";
    begin
        // "Warehouse Activity Line".SetFilter("Action Type", '%1', "Warehouse Activity Line"."Action Type"::Take);
        SalesLine.SetRange("Document No.", "Warehouse Activity Line"."Source No.");
        SalesLine.SetRange("Line No.", "Warehouse Activity Line"."Source Line No.");
        if not SalesLine.IsEmpty() then
            exit(SalesLine."RLU Weight Packing");
        // Evaluate(SalesLine."RLU Weight Packing", test);
        // SalesLine.CalcSums("RLU Weight Packing");
        // repeat
        // until SalesLine.Next() = 0;
    end;

    procedure setparm(_No: code[20])
    var
    begin
        No_ := _No;
    end;

    var
        CompanyInformation: Record "Company Information";
        No_: Code[20];
        TruckNo_: Text[12];
        Driver_: Text[150];
        Condition_: Text[50];
        Weather_: Text[50];
        "StartTime_": Time;
        "EndTime_": Time;
    // Total: Decimal;
    // test: Integer;

}