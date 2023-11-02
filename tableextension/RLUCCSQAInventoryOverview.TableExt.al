tableextension 50115 "RLU CCS QA Inventory Overview" extends "CCS QA Inventory Overview"
{
    procedure InitFinishedGoodType(CCSQAInventoryOverview: Record "CCS QA Inventory Overview")
    var
        RLUFinishedGoodsType: Page "RLU Finished Goods Type";
    begin
        RLUFinishedGoodsType.InitializeData(CCSQAInventoryOverview."Item No.", CCSQAInventoryOverview."Variant Code", CCSQAInventoryOverview."Lot No.",
                                            CCSQAInventoryOverview.Quantity, CCSQAInventoryOverview."Location Code", CCSQAInventoryOverview."Bin Code");
        if RLUFinishedGoodsType.RunModal() = Action::OK then
            RLUFinishedGoodsType.CreateItemJnlLine();
    end;
}
