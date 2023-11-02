page 50108 "RLU Allocation Transaction"
{
    Caption = 'Allocation Transaction Card';
    PageType = Card;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "RLU Allocation Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Allo Trans No"; Rec."Allo Trans No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date From"; Rec."Date From")
                {
                    ApplicationArea = All;
                }
                field("Date To"; Rec."Date To")
                {
                    ApplicationArea = All;
                }
                field("Allo Code"; Rec."Allo Code")
                {
                    ApplicationArea = All;
                }
                field("Allo Description"; Rec."Allo Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Total Basis Balance"; Rec."Total Basis Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Hectare Area"; Rec."Total Hectare Area")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            part(RLUAllocationBasis; "RLU Allocation Basis")
            {
                ApplicationArea = All;
                SubPageLink = "Allo Trans No" = FIELD("Allo Trans No");
                UpdatePropagation = Both;
            }

            part(RLUAllocationHectareArea; "RLU Allocation Hectare Area")
            {
                ApplicationArea = Suite;
                SubPageLink = "Allo Trans No" = FIELD("Allo Trans No");
                UpdatePropagation = Both;
            }

            part(RLUAllocationResultDetail; "RLU Allocation Result Detail")
            {
                ApplicationArea = Suite;
                SubPageLink = "Allo Trans No" = FIELD("Allo Trans No");
                UpdatePropagation = Both;
            }

            part(RLUAllocationResultSummary; "RLU Allocation Result Summary")
            {
                ApplicationArea = Suite;
                SubPageLink = "Allo Trans No" = FIELD("Allo Trans No");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Process)
            {
                Caption = 'Process';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Process';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if not CONFIRM('This action will process Allocation Transaction. Are you sure to continue?') then exit;
                    if Rec.Status <> Rec.Status::Posted then begin
                        RLUAllocationTransaction.ProcessAllocationTransaction(Rec);
                        RLUAllocationTransaction.ProcessAllocationSummaryDetail(Rec);
                    end
                end;
            }
            action(Delete)
            {
                Caption = 'Delete';
                ApplicationArea = All;
                Image = Delete;
                ToolTip = 'Delete';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if not CONFIRM('This action will delete Allocation Transaction. Are you sure to continue?') then exit;
                    if Rec.Status <> Rec.Status::Posted then
                        RLUAllocationTransaction.DeleteAllocationTransaction(Rec);

                end;
            }
            action(Posting)
            {
                Caption = 'Posting';
                ApplicationArea = All;
                Image = Post;
                ToolTip = 'Posting';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if not CONFIRM('This action will posting Allocation Transaction. Are you sure to continue?') then exit;
                    if Rec.Status <> Rec.Status::Open then
                        RLUAllocationTransaction.PostAllocationTransaction(Rec);
                end;
            }

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Status := Rec.Status::Open;
    end;

    var
        RLUAllocationTransaction: Codeunit "RLU Allocation Transaction";
}
