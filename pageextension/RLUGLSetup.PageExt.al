pageextension 50109 "RLU GL Setup" extends "General Ledger Setup"
{
    layout
    {
        addafter(Control1900309501)
        {
            group("Matrix Dimensions")
            {
                field("Matrix Dimension 1"; Rec.MatrixDimension1Code)
                {
                    ApplicationArea = All;
                    Caption = 'Matrix Dimension 1';
                    ToolTip = 'Matrix Dimension 1';
                    TableRelation = "Dimension".Code;
                }
                field("Matrix Dimension 2"; Rec.MatrixDimension2Code)
                {
                    ApplicationArea = All;
                    Caption = 'Matrix Dimension 2';
                    ToolTip = 'Matrix Dimension 2';
                    TableRelation = "Dimension".Code;
                }
                field("Matrix Dimension 3"; Rec.MatrixDimension3Code)
                {
                    ApplicationArea = All;
                    Caption = 'Matrix Dimension 3';
                    ToolTip = 'Matrix Dimension 3';
                    TableRelation = "Dimension".Code;
                    Editable = true;
                }
                field("Matrix Dimension 4"; Rec.MatrixDimension4Code)
                {
                    ApplicationArea = All;
                    Caption = 'Matrix Dimension 4';
                    ToolTip = 'Matrix Dimension 4';
                    TableRelation = "Dimension".Code;
                    Editable = true;
                }
                field("Matrix Dimension 5"; Rec.MatrixDimension5Code)
                {
                    ApplicationArea = All;
                    Caption = 'Matrix Dimension 5';
                    ToolTip = 'Matrix Dimension 5';
                    TableRelation = "Dimension".Code;
                    Editable = true;
                }
                field("Matrix Dimension 6"; Rec.MatrixDimension6Code)
                {
                    ApplicationArea = All;
                    Caption = 'Matrix Dimension 6';
                    ToolTip = 'Matrix Dimension 6';
                    TableRelation = "Dimension".Code;
                    Editable = true;
                }
                field("Matrix Dimension 7"; Rec.MatrixDimension7Code)
                {
                    ApplicationArea = All;
                    Caption = 'Matrix Dimension 7';
                    ToolTip = 'Matrix Dimension 7';
                    TableRelation = "Dimension".Code;
                    Editable = true;
                }
                field("Matrix Dimension 8"; Rec.MatrixDimension8Code)
                {
                    ApplicationArea = All;
                    Caption = 'Matrix Dimension 8';
                    ToolTip = 'Matrix Dimension 8';
                    TableRelation = "Dimension".Code;
                    Editable = true;
                }
            }
        }

        addafter("Control VAT Period")
        {
            field("Allo Journal"; Rec."Allo Journal")
            {
                ApplicationArea = All;
                Caption = 'Allocation Journal';
                ToolTip = 'Allocation Journal';
                ShowMandatory = true;
            }
        }
    }
}