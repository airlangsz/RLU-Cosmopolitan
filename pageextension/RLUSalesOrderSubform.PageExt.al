pageextension 50100 "RLU Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("RLU DRC Percentage"; Rec."RLU DRC Percentage")
            {
                ApplicationArea = All;
                ToolTip = 'DRC %-tage';
            }
            field("RLU Dry Quantity"; Rec."RLU Dry Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Dry Based Quantity Amount';
            }
        }
        addafter("Unit Price")
        {
            field("RLU Dry Unit Price"; Rec."RLU Dry Unit Price")
            {
                ApplicationArea = All;
                ToolTip = 'Dry Based Price Amount';
            }
        }
        addafter("No.")
        {
            field("RLU SMPT Lot No"; Rec."RLU SMPT Lot No")
            {
                ApplicationArea = All;
                ToolTip = 'SMPT Lot No';
            }
            field("RLU MKC Lot No"; Rec."RLU MKC Lot No")
            {
                ApplicationArea = All;
                ToolTip = 'MKC Lot No';
            }
            field("RLU Package Type"; Rec."RLU Package Type")
            {
                ApplicationArea = All;
                ToolTip = 'Package Type';

                trigger OnValidate()
                var
                    defaultcode: Record "RLU Default Code";
                begin
                    defaultcode.SetRange(Code, Rec."RLU Package Type");
                    if defaultcode.FindSet() then begin
                        "KRE Weight Packing" := defaultcode.Description;
                        repeat
                        until defaultcode.Next() = 0;
                        Evaluate(Rec."RLU Weight Packing1", "KRE Weight Packing");
                        Rec.Modify();
                    end;
                    CurrPage.Update();
                end;
            }
            field("RLU Weight Packing1"; Rec."RLU Weight Packing1")
            {
                ApplicationArea = All;
                Caption = 'Weight Packing (kgs)';
                ToolTip = 'Weight Packing';
            }

            // field("RLU Weight Packing"; Rec."RLU Weight Packing")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Weight Packing (kgs)';

            //     trigger OnValidate()
            //     var
            //         myInt: Integer;
            //     begin
            //         // peking := Rec."RLU Weight Packing";
            //     end;
            // }
            field("RLU Seal No"; Rec."RLU Seal No")
            {
                ApplicationArea = All;
                ToolTip = 'Seal No';
            }
            field("Pallet Quantity"; Rec."Pallet Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Pallet Quantity';

                trigger OnValidate()
                var
                // defaultcode: Record "RLU Default Code";
                begin
                    Rec."Gross Weight" := (Rec."Pallet Quantity" * Rec."RLU Weight Packing1") + Rec.Quantity;
                    CurrPage.Update();
                end;
            }

            field("Container No"; Rec."Container No")
            {
                ApplicationArea = All;
                ToolTip = 'Container No';
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                ItemCharge: Record "Item Charge";
            begin
                if Rec."Type" = Rec.Type::"Charge (Item)" then
                    if ItemCharge.Get(Rec."No.") then
                        if ItemCharge."Discount Package" = true then
                            Rec."Discount Package" := true
                        else
                            Rec."Discount Package" := false;
                CurrPage.Update();
            end;
        }
        modify(Description)
        {
            trigger OnAfterValidate()
            var
                ItemCharge: Record "Item Charge";
            begin
                if Rec."Type" = Rec.Type::"Charge (Item)" then
                    if ItemCharge.Get(Rec."No.") then
                        if ItemCharge."Discount Package" = true then
                            Rec."Discount Package" := true
                        else
                            Rec."Discount Package" := false;
                CurrPage.Update();
            end;
        }
    }
    actions
    {
        addafter("O&rder")
        {
            group("Lot No")
            {
                Caption = 'Lot No';
                Image = LotInfo;

                action("Generate Lot No")
                {
                    Caption = 'Generate Lot No';
                    ToolTip = 'Generate Lot No';
                    ApplicationArea = All;
                    Image = Lot;

                    trigger OnAction()
                    begin
                        Rec.GenerateLotNo(Rec);
                    end;
                }
            }
        }
    }
    // local procedure UpWeightPacking(): Text[50]
    // var
    //     defaultcode: Record "RLU Default Code";
    //     SH: Record "Sales Header";
    //     SL: record "Sales Line";

    // begin
    //     defaultcode.Reset();
    //     defaultcode.SetRange(Code, Rec."RLU Package Type");
    //     if defaultcode.FindSet() then begin
    //         rec.Init();
    //         Rec."RLU Weight Packing" := defaultcode.Description;
    //     end
    // // end;
    // local procedure Codetointeger(var peking: integer): text[50]
    // var
    //     myInt: Integer;
    //     sl: Record "Sales Line";
    //     weight: Integer;
    // begin
    //     sl.SetRange("Document No.", Rec."Document No.");
    //     sl.SetRange("Document Type", Rec."Document Type");
    //     if sl.FindSet() then begin
    //         Evaluate(weight, Rec."RLU Weight Packing");
    //         exit(weight)
    //     end;
    // end;

    var
        "KRE Weight Packing": text[50];
}
