pageextension 50107 "RLU Job Journal" extends "Job Journal"
{
    layout
    {
        addafter(Description)
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