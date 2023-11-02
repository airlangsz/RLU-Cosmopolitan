pageextension 50108 "RLU Job GL Journal" extends "Job G/L Journal"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            field(BlockCode; Rec.BlockCode)
            {
                Caption = 'Block Code';
                ToolTip = 'Block Code';
                ApplicationArea = All;
                TableRelation = "RLU Matrix Dimension"."Block Code";

                trigger OnValidate()
                var
                    MatDim: Record "RLU Matrix Dimension";
                begin
                    if Rec.BlockCode <> '' then begin
                        MatDim.Reset();
                        MatDim.SetRange("Block Code", Rec.BlockCode);
                        if MatDim.FindLast() then
                            Rec.Validate("Dimension Set ID", MatDim.DimSetId);
                    end;
                end;
            }
        }
    }
}