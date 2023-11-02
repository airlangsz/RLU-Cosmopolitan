report 50108 "RLU Trial Balance Management"
{
    DefaultLayout = RDLC;
    RDLCLayout = './app/src/rdl/RLUTrialBalanceManagement.rdl';
    AdditionalSearchTerms = 'year closing,close accounting period,close fiscal year';
    ApplicationArea = Basic, Suite;
    Caption = 'Trial Balance Management';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.") where(isTax = filter(false));
            // RequestFilterFields = "Audit Type Filter";
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000_Lbl, PeriodText))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(StartDate; StartDate)
            { }
            column(EndDate; EndDate)
            { }
            column(GLFilter; GLFilter)
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(Account_No; Account_No)
            {
            }
            column(Account_desc; Account_desc)
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(G_L_Account___No__; "G/L Account"."No.")
            {
            }

            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
            {
            }

            column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
            {
            }
            column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLinkReference = "G/L Account";
                DataItemLink = "G/L Account No." = field("No.");
                DataItemTableView = SORTING("Global Dimension 1 Code") ORDER(Ascending);
                column(G_L_Account_No_; "G/L Entry"."G/L Account No.")
                {
                }
                column(Beginning_Balance; sum_amount)
                { }
                column(G_L_Account___Net_Change_; sum_amount)
                {
                }
                column(G_L_Account___Net_Change__Control22; -sum_amount)
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Net_Change_End; sum_amount)
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; Beginning_Balance + sum_amount)
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; Beginning_Balance + (-sum_amount))
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_End; Beginning_Balance + (sum_amount))
                {
                    AutoFormatType = 1;
                }
                column(TP; "Global Dimension 1 Code")
                {
                }
                column(TP_Description; "Dim Name")
                {
                }
                column(Posting_Date; "Posting Date")
                { }
                column(TypeAudit; TypeAudit)
                { }
                column(Audit_Type_Filter; Audit_Type_Filter_)
                { }

                trigger OnAfterGetRecord()
                begin
                    GeneralLedgerSetup.FindFirst();
                    if DimensionValue.Get(GeneralLedgerSetup."Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code") then
                        "Dim Name" := DimensionValue.Name;

                    if Audit_Type_Filter_ <> Audit_Type_Filter_::" " then
                        if Audit_Type_Filter_ = "G/L Entry".TypeAudit then
                            sum_amount := "G/L Entry".Amount
                        else
                            sum_amount := 0
                    else
                        sum_amount := "G/L Entry".Amount;

                end;

                trigger OnPreDataItem()
                begin

                    "G/L Entry".SetFilter("Posting Date", ' <= %1', EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if ChangeGroupNo then begin
                    PageGroupNo += 1;
                    ChangeGroupNo := false;
                end;

                ChangeGroupNo := "New Page";
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 0;
                ChangeGroupNo := false;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Filters';
                    field(StartingDate; StartDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date when you want the report to start.';
                    }
                    field(EndingDate; EndDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the date when you want the report to end.';
                    }
                    field(Account_Type_; Account_Type)
                    {
                        ApplicationArea = All;
                        Caption = 'Account AI / ADM';
                        OptionCaption = ' ,COA AI,COA ADM';
                        ToolTip = 'Account AI / ADM';
                        ShowMandatory = true;
                    }

                    field(Audit_Type_Filter; Audit_Type_Filter_)
                    {
                        ApplicationArea = All;
                        Caption = 'Audit Type Filter';
                        OptionCaption = ' ,Audited,Unaudited';
                        ToolTip = 'Audit Type Filter';
                        ShowMandatory = true;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        "G/L Account".SecurityFiltering(SecurityFilter::Filtered);
        GLFilter := "G/L Account".GetFilters;
        PeriodText := Format(StartDate, 0, '<Day,2>/<Month,2>/<Year>') + 's/d' + Format(EndDate, 0, '<Day,2>/<Month,2>/<Year>');
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        sum_amount: Decimal;
        Beginning_Balance: Decimal;
        StartDate: Date;
        EndDate: Date;
        Audit_Type_Filter_: Option " ","Audited","Unaudited";
        "Dim Name": Text[100];
        Account_Type: Option " ","COA AI","COA ADM";
        Account_No: Code[20];
        Account_desc: Text[100];
        Text000_Lbl: Label '';
        GLFilter: Text;
        PeriodText: Text[30];
        Trial_BalanceCaptionLbl: Label 'Trial Balance Management';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Net_ChangeCaptionLbl: Label 'Net Change';
        BalanceCaptionLbl: Label 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: Label 'Name';
        G_L_Account___Net_Change_CaptionLbl: Label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: Label 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: Label 'Debit';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: Label 'Credit';
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
}

