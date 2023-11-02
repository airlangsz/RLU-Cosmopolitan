report 50114 "RLU Laboratory Of Quality"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './app/src/rdl/RLULaboratoryCertificate.rdl';

    dataset
    {
        dataitem(Header; "Warehouse Shipment Header")
        {
            column(No_; "No.")
            {

            }

            column(Newno; Newno)
            {

            }


            column(ShipingMark; ShipingMark)
            {

            }

            column(text100; text100)
            {

            }

            column(emplyee; emplyee)
            {

            }


            column(jobbtitle; jobbtitle)
            {

            }

            column(fullname; fullname)
            {

            }

            column(noseries; Numberseries)
            {

            }

            dataitem(line; "Warehouse Shipment Line")
            {

                DataItemLinkReference = Header;
                DataItemLink = "No." = field("No.");


                column(Variant_Code; "Variant Code")
                {

                }

                column(Lot_No; Lot_No())
                {

                }


                column(tanggalttd; tanggalttd)
                {

                }

                column(ItemDesc; ItemDesc())
                {

                }

                column(Customercode; Customercode())
                {

                }

                column(Viadesc; Viadesc())
                {

                }

                column(ContainerNo; ContainerNo())
                {

                }


                column(smptlotno; smptlotno())
                {

                }

                column(ItemReference; ItemReference())
                {

                }

                column(PackageType; PackageType())
                {

                }

                column(GrossWeight; GrossWeight())
                {

                }
                column(NetWeight; NetWeight())
                {

                }


                column(PackageTypeDesc; PackageTypeDesc())
                {

                }

                column(Picture; CompanyInformationRLU.Picture) { }
                column(CompanyName; CompanyInformationRLU.Name) { }
                column(CompanyAddres; CompanyInformationRLU.Address) { }
                column(CompanyCity; CompanyInformationRLU.City) { }

                column(CompanyPhone; CompanyInformationRLU."Phone No.") { }

                column(Companyfax; CompanyInformationRLU."Fax No.") { }

            }
            trigger OnPreDataItem()
            var
            begin
                Header.SetRange("No.", _No);
                tanggalttd := Today;
                if Running = true then
                    Newno := NoseriesManagement.GetNextNo(Numberseries, 0D, true)
            end;


            trigger OnAfterGetRecord()
            var
            // NoseriesHeader: Record "No. Series";
            // Newno: Code[10];
            begin
                //     Noseries.reset();
                //     Noseries.setrange("Series Code", 'TEMPNO');
                //     IF Noseries.find('-') then begin
                //         Newno := IncStr(noseries."Last No. Used");
                //         Noseries."Last No. Used" := Newno;
                //         noseries.modify();
                //     end;
            end;

        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Option)
                {
                    field(Check; Running)
                    {
                        ApplicationArea = All;
                        ToolTip = 'RunningNumber';
                        Caption = 'Preview';
                    }

                    field(noseries; Numberseries)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Fornumberseries';
                        TableRelation = "No. Series";
                        Caption = 'No Series';

                    }

                    field(Employee; emplyee)
                    {
                        ApplicationArea = All;
                        TableRelation = Employee;
                        ToolTip = 'Employee';
                        Caption = 'Employee';
                        trigger OnValidate()
                        var
                            // text100: Text;
                            employe: Record Employee;
                        begin
                            if employe.Get(emplyee) then begin
                                emplyee := employe.FullName();
                                fullname := employe.FullName();
                                jobbtitle := employe."Job Title";
                            end
                        end;
                    }
                    // field(text100; text100)
                    // {
                    //     ApplicationArea = All;
                    // }
                    // field(jobbtitle; jobbtitle)
                    // {
                    //     ApplicationArea = All;
                    // }
                }
            }
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

    trigger OnInitReport()
    begin
        CompanyInformationRLU.get();
        CompanyInformationRLU.CalcFields(Picture);

        // if preview = true then begin
        //     Newno := NoseriesMGT.GetNextNo(noseries, 0D, true)
        // end;
    end;

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        CompanyInformationRLU: Record "Company Information";
        NoseriesManagement: Codeunit NoSeriesManagement;
        Newno: Code[20];
        ShipingMark: Text[100];
        emplyee: Text[100];
        fullname: text[100];
        text100: Text;
        jobbtitle: text[50];
        tanggalttd: Date;
        _No: Code[20];
        Numberseries: Code[20];
        Running: Boolean;


    procedure SetParm(No_: Code[20])
    begin
        _No := No_;
    end;

    local procedure ItemDesc(): Text[100]
    var
        ItemVariant: Record "Item Variant";
    begin
        ItemVariant.SetRange(Code, line."Variant Code");
        ItemVariant.FindSet();
        repeat
        until ItemVariant.Next() = 0;
        exit(ItemVariant.Description)
    end;

    local procedure Customercode(): Code[20]
    var

        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("No.", line."Source No.");
        SalesHeader.FindSet();
        repeat
        until SalesHeader.Next() = 0;
        exit(SalesHeader."Sell-to Customer No.")
    end;

    local procedure Viadesc(): Text[50]
    var
        SalesHeader: Record "Sales Header";
        RLUDefaultCode: Record "RLU Default Code";
    begin
        SalesHeader.SetRange("No.", line."Source No.");
        if SalesHeader.FindSet() then begin
            repeat
            until SalesHeader.Next() = 0;
            RLUDefaultCode.SetRange(Code, SalesHeader."RLU Via");
            RLUDefaultCode.FindSet();
            repeat
            until RLUDefaultCode.Next() = 0;
            exit(RLUDefaultCode.Description)
        end;
    end;


    local procedure ContainerNo(): Text[25]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", line."Source No.");
        SalesHeader.FindFirst();
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.FindFirst();
        exit(SalesLine."Container No")
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
        SalesHeader.SetRange("No.", line."Source No.");
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

    local procedure ItemReference(): Code[50]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", line."Source No.");
        SalesHeader.FindSet();
        repeat
        until SalesHeader.Next() = 0;
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        exit(SalesLine."Item Reference No.")
    end;

    local procedure PackageType(): Code[25]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", line."Source No.");
        SalesHeader.FindSet();
        repeat
        until SalesHeader.Next() = 0;
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.FindSet();
        repeat
        until SalesLine.Next() = 0;
        exit(SalesLine."RLU Package Type")
    end;


    local procedure PackageTypeDesc(): text[50]
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        RLUDefaultCode: Record "RLU Default Code";
    begin
        SalesHeader.SetRange("No.", line."Source No.");
        SalesHeader.FindSet();
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        repeat
        until SalesHeader.Next() = 0;
        if SalesLine.FindSet() then begin
            RLUDefaultCode.SetRange(Code, SalesLine."RLU Package Type");
            repeat
            until SalesLine.Next() = 0;
            if RLUDefaultCode.FindSet() then
                repeat
                until RLUDefaultCode.Next() = 0;
            exit(RLUDefaultCode.Description)
        end;
    end;

    local procedure GrossWeight(): Decimal
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", line."Source No.");
        SalesHeader.FindFirst();
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
        if SalesLine.FindFirst() then begin
            SalesLine.CalcSums("Gross Weight");
            exit(SalesLine."Gross Weight")
        end;
    end;

    local procedure NetWeight(): Decimal
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange("No.", line."Source No.");
        SalesHeader.FindFirst();
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
        if not SalesLine.IsEmpty then begin
            SalesLine.CalcSums("Net Weight");
            exit(SalesLine."Net Weight")
        end;
    end;


    local procedure Lot_No(): Code[50]
    var
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        // SalesHeader.SetFilter("Document Type", '%1|%2', Header."Document Type"::Invoice, Header."Document Type"::Order);
        SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", SalesShipmentHeader."Order No.");
        SalesHeader.SetRange("No.", Header."No.");
        if SalesHeader.FindSet() then
            repeat
            until SalesHeader.Next() = 0;
        SalesLine.SetFilter("Document Type", '%1|%2', Salesline."Document Type"::Invoice, SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", Line."Source No.");
        SalesLine.SetRange("Line No.", Line."Line No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then
            repeat
            until SalesLine.Next() = 0;
        RegisteredWhseActivityLine.SetRange("Source No.", Line."Source No.");
        RegisteredWhseActivityLine.SetRange("Action Type", RegisteredWhseActivityLine."Action Type"::Take);
        if RegisteredWhseActivityLine.FindSet() then
            repeat
            until RegisteredWhseActivityLine.Next() = 0;
        exit(RegisteredWhseActivityLine."Lot No.");
    end;
}