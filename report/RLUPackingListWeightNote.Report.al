report 50104 "RLU Packing List Weight Note"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    Caption = 'Packing List /Weight Note Report';

    dataset
    {
        dataitem(SalesOrder; "Sales Cr.Memo Header")
        {
            column(Picture; CompanyInformation.Picture) { }
            column(No_; "No.") { }
            column(Bill_to_Contact_No_; "Bill-to Contact No.") { }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }

        actions
        {
            area(processing)
            {
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './app/src/rdl/RLUPackingListWeightNote.rdl';
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