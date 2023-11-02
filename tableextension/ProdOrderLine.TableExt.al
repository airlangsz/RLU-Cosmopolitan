tableextension 50116 "Prod. Order Line" extends "Prod. Order Line"
{
    procedure InitFinishedGoodType(ProdOrderLine: Record "Prod. Order Line")
    var
        RLUFinishedGoodsType: Page "RLU Finished Goods Type";
        LotNo: Code[50];
        AvailableQty: Decimal;
        QtyAvailErr: Label 'There is no more lot with variant %1 available', Comment = '%1 = Varint Code';
    begin
        Clear(LotNo);
        Clear(AvailableQty);
        LotNo := GetLotNo(ProdOrderLine);
        AvailableQty := GetAvailableQTYGetLotNo(ProdOrderLine, LotNo);
        if AvailableQty <= 0 then
            Error(QtyAvailErr, ProdOrderLine."Variant Code");
        RLUFinishedGoodsType.InitializeData(ProdOrderLine."Item No.", ProdOrderLine."Variant Code", LotNo, AvailableQty, ProdOrderLine."Location Code", ProdOrderLine."Bin Code");
        if RLUFinishedGoodsType.RunModal() = Action::OK then
            RLUFinishedGoodsType.CreateItemJnlLine();
    end;

    procedure GetLotNo(ProdOrderLine: Record "Prod. Order Line"): Code[50]
    var
        ReservationEntry: Record "Reservation Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ReservationEntry.Reset();
        ReservationEntry.SetRange("Source Type", Database::"Prod. Order Line");
        ReservationEntry.SetRange("Item No.", ProdOrderLine."Item No.");
        ReservationEntry.SetRange("Source Prod. Order Line", ProdOrderLine."Line No.");
        if ReservationEntry.FindFirst() then
            exit(ReservationEntry."Lot No.")
        else begin
            ItemLedgerEntry.Reset();
            ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
            ItemLedgerEntry.SetRange("Order No.", ProdOrderLine."Prod. Order No.");
            ItemLedgerEntry.SetRange("Item No.", ProdOrderLine."Item No.");
            ItemLedgerEntry.SetRange("Variant Code", ProdOrderLine."Variant Code");
            ItemLedgerEntry.SetRange("Location Code", ProdOrderLine."Location Code");
            if ItemLedgerEntry.FindLast() then
                exit(ItemLedgerEntry."Lot No.");
        end;
    end;

    procedure GetAvailableQTYGetLotNo(ProdOrderLine: Record "Prod. Order Line"; Lot_No: Code[50]): Decimal
    var
        CCSQAInventoryOverview: Record "CCS QA Inventory Overview";
    begin
        CCSQAInventoryOverview.Reset();
        CCSQAInventoryOverview.SetRange("Item No.", ProdOrderLine."Item No.");
        CCSQAInventoryOverview.SetRange("Location Code", ProdOrderLine."Location Code");
        CCSQAInventoryOverview.SetRange("Lot No.", Lot_No);
        CCSQAInventoryOverview.SetRange("Variant Code", ProdOrderLine."Variant Code");
        if CCSQAInventoryOverview.FindLast() then
            exit(CCSQAInventoryOverview.Quantity);
    end;
}
