page 50111 "RLU Finished Goods Type"
{
    ApplicationArea = All;
    Caption = 'Finished Goods Type';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ItemNo; ItemNo)
                {
                    Caption = 'Item No.';
                    ToolTip = 'Item No.';
                    Editable = false;
                }
                field(Variant; Variant)
                {
                    Caption = 'Variant';
                    ToolTip = 'Variant';
                    Editable = false;
                }
                field(LotNo; LotNo)
                {
                    Caption = 'Lot No.';
                    ToolTip = 'Lot No.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LotNoInformation: Record "Lot No. Information";
                        LotNoInformationList: Page "Lot No. Information List";
                    begin
                        LotNoInformation.Reset();
                        LotNoInformation.SetRange("Item No.", ItemNo);
                        if LotNoInformation.FindSet() then begin
                            LotNoInformationList.SetRecord(LotNoInformation);
                            LotNoInformationList.LookupMode(true);
                            LotNoInformationList.SetTableView(LotNoInformation);
                            LotNoInformationList.SetSelectionFilter(LotNoInformation);
                            if LotNoInformationList.RunModal() = Action::LookupOK then begin
                                LotNoInformationList.GetRecord(LotNoInformation);
                                LotNo := LotNoInformation."Lot No.";
                            end;
                        end;
                    end;
                }
                field(AvailableQty; AvailableQty)
                {
                    Caption = 'Available Qty';
                    ToolTip = 'Available Qty';
                    Editable = false;
                }
                field(NewVariant; NewVariant)
                {
                    Caption = 'New Variant';
                    ToolTip = 'New Variant';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemVariant: Record "Item Variant";
                        ItemVariantPage: Page "Item Variants";
                    begin
                        ItemVariant.Reset();
                        ItemVariant.SetRange("Item No.", ItemNo);
                        if ItemVariant.FindSet() then begin
                            ItemVariantPage.SetRecord(ItemVariant);
                            ItemVariantPage.LookupMode(true);
                            ItemVariantPage.SetTableView(ItemVariant);
                            if ItemVariantPage.RunModal() = Action::LookupOK then begin
                                ItemVariantPage.GetRecord(ItemVariant);
                                NewVariant := ItemVariant.Code;
                            end;
                        end;
                    end;
                }
                field(QtyToHandle; QtyToHandle)
                {
                    Caption = 'Qty To Handle';
                    ToolTip = 'Qty To Handle';
                    trigger OnValidate()
                    var
                        QtyErr: Label 'Qty to Handle cannot be more than Available Qty';
                    begin
                        if QtyToHandle > AvailableQty then
                            Error(QtyErr);
                    end;
                }
                field(Location; Location)
                {
                    Caption = 'Location';
                    ToolTip = 'Location';
                    Visible = false;
                }
                field(BinCode; BinCode)
                {
                    Caption = 'Bin Code';
                    ToolTip = 'Bin Code';
                    Visible = false;
                }
            }
        }
    }

    var
        ItemNo: Code[20];
        Variant: Code[10];
        LotNo: Code[50];
        AvailableQty: Decimal;
        NewVariant: Code[10];
        QtyToHandle: Decimal;
        Location: Code[10];
        BinCode: Code[20];

    procedure InitializeData(Item_No: Code[20]; Variant_: Code[10]; Lot_No: Code[50]; Available_Qty: Decimal; LocationCode: Code[10]; Bin: Code[20])
    begin
        ItemNo := Item_No;
        Variant := Variant_;
        LotNo := Lot_No;
        AvailableQty := Available_Qty;
        BinCode := Bin;
        Location := LocationCode;
    end;

    procedure CreateItemJnlLine()
    var
        ItemJournalLine: Record "Item Journal Line";
        CCSQASetup: Record "CCS QA Setup";
        ItemJournalBatch: Record "Item Journal Batch";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        LineNo: Integer;
        DocNo: Code[20];
    begin
        CCSQASetup.Get();
        CCSQASetup.TestField("Journal Template Name");
        CCSQASetup.TestField("Journal Batch Name");
        ClearJnLine(CCSQASetup."Journal Template Name", CCSQASetup."Journal Batch Name");
        LineNo := 10000;

        if (ItemNo <> '') and (QtyToHandle <> 0) then begin
            Clear(DocNo);
            ItemJournalBatch.Get(CCSQASetup."Journal Template Name", CCSQASetup."Journal Batch Name");
            DocNo := NoSeriesManagement.GetNextNo(ItemJournalBatch."No. Series", Today, false);
            ItemJournalLine.Init();
            ItemJournalLine."Journal Template Name" := CCSQASetup."Journal Template Name";
            ItemJournalLine."Journal Batch Name" := CCSQASetup."Journal Batch Name";
            ItemJournalLine."Line No." := LineNo;
            ItemJournalLine.Validate("Posting Date", Today());
            ItemJournalLine."Document No." := DocNo;
            ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
            ItemJournalLine.Validate("Item No.", ItemNo);
            ItemJournalLine.Validate("Variant Code", Variant);
            ItemJournalLine.Validate("Location Code", Location);
            ItemJournalLine.Validate("Bin Code", BinCode);
            ItemJournalLine.Validate(Quantity, QtyToHandle);
            ItemJournalLine.Insert();
            CreateReservationEntry(ItemJournalLine);

            ItemJournalLine.Init();
            ItemJournalLine."Journal Template Name" := CCSQASetup."Journal Template Name";
            ItemJournalLine."Journal Batch Name" := CCSQASetup."Journal Batch Name";
            ItemJournalLine."Line No." := LineNo + 10000;
            ItemJournalLine.Validate("Posting Date", Today());
            ItemJournalLine."Document No." := DocNo;
            ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt.";
            ItemJournalLine.Validate("Item No.", ItemNo);
            if NewVariant <> '' then
                ItemJournalLine.Validate("Variant Code", NewVariant)
            else
                ItemJournalLine.Validate("Variant Code", Variant);
            ItemJournalLine.Validate("Location Code", Location);
            ItemJournalLine.Validate("Bin Code", BinCode);
            ItemJournalLine.Validate(Quantity, QtyToHandle);
            ItemJournalLine.Insert();
            CreateReservationEntry(ItemJournalLine);
            Codeunit.Run(Codeunit::"Item Jnl.-Post", ItemJournalLine);
        end;
    end;

    local procedure ClearJnLine(JTemplate: Code[20]; JBatch: Code[20])
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        ItemJournalLine.Reset();
        ItemJournalLine.SetRange("Journal Template Name", JTemplate);
        ItemJournalLine.SetRange("Journal Batch Name", JBatch);
        if ItemJournalLine.FindSet() then
            ItemJournalLine.Delete();
    end;

    local procedure CreateReservationEntry(ItemJournalLine: Record "Item Journal Line")
    var
        TempReservationEntry: Record "Reservation Entry" temporary;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ReservationStatus: Enum "Reservation Status";
    begin
        Item.Get(ItemJournalLine."Item No.");
        if Item."Item Tracking Code" <> '' then
            ItemTrackingCode.Get(Item."Item Tracking Code")
        else
            exit;
        TempReservationEntry.Init();
        TempReservationEntry."Source Type" := Database::"Item Journal Line";
        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt." then
            TempReservationEntry."Source Subtype" := ItemJournalLine."Entry Type".AsInteger()
        else
            if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." then
                TempReservationEntry."Source Subtype" := ItemJournalLine."Entry Type".AsInteger();
        TempReservationEntry."Source ID" := ItemJournalLine."Journal Template Name";
        TempReservationEntry."Source Batch Name" := ItemJournalLine."Journal Batch Name";
        TempReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
        TempReservationEntry."Item No." := ItemJournalLine."Item No.";
        TempReservationEntry."Variant Code" := ItemJournalLine."Variant Code";
        TempReservationEntry."Location Code" := ItemJournalLine."Location Code";
        TempReservationEntry.Description := ItemJournalLine.Description;
        TempReservationEntry."Lot No." := LotNo;
        TempReservationEntry."Package No." := ItemJournalLine."Package No.";
        TempReservationEntry."Variant Code" := ItemJournalLine."Variant Code";
        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt." then begin
            TempReservationEntry.Quantity := ItemJournalLine.Quantity;
            TempReservationEntry."Quantity (Base)" := ItemJournalLine."Quantity (Base)";
            TempReservationEntry."Qty. to Handle (Base)" := ItemJournalLine.Quantity;
            TempReservationEntry."Qty. to Invoice (Base)" := ItemJournalLine.Quantity;
            TempReservationEntry.Positive := true;
        end
        else
            if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." then begin
                TempReservationEntry.Quantity := -ItemJournalLine.Quantity;
                TempReservationEntry."Quantity (Base)" := -ItemJournalLine."Quantity (Base)";
                TempReservationEntry."Qty. to Handle (Base)" := -ItemJournalLine.Quantity;
                TempReservationEntry."Qty. to Invoice (Base)" := -ItemJournalLine.Quantity;
            end;
        TempReservationEntry."Reservation Status" := TempReservationEntry."Reservation Status"::Prospect;
        TempReservationEntry.Insert(true);

        CreateReservEntry.SetDates(0D, 0D);
        CreateReservEntry.CreateReservEntryFor(
          Database::"Item Journal Line", ItemJournalLine."Entry Type".AsInteger(),
          ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name", 0, ItemJournalLine."Line No.", ItemJournalLine."Qty. per Unit of Measure",
          ItemJournalLine.Quantity, ItemJournalLine.Quantity * ItemJournalLine."Qty. per Unit of Measure", TempReservationEntry);
        CreateReservEntry.CreateEntry(
          ItemJournalLine."Item No.", ItemJournalLine."Variant Code", ItemJournalLine."Location Code", ItemJournalLine.Description, 0D, ItemJournalLine."Posting Date", 0, ReservationStatus::Prospect);
    end;
}