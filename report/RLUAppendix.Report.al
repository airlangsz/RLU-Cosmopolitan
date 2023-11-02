report 50403 "RLU Appendix"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './app/src/rdl/RLUAppendix.rdl';
    Caption = 'CERTIFICATE OF ANALYSIS : Appendix';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(Picture; CompanyInformation.Picture) { }
            column(Address; CompanyInformation.Address) { }
            column(No_; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(Work_Description; "Work Description") { }
            // column(){ }
            // column(){ }
            // column(){ }
            // column(){ }
            trigger OnPreDataItem()
            var
            begin

            end;

        }
    }

    trigger OnInitReport()
    begin
        CompanyInformation.get();
        CompanyInformation.CalcFields(Picture);

    end;

    var
        CompanyInformation: Record "Company Information";
}