report 50100 "RLU Certificate Analysis"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(DataItemName; "Sales Header")
        {
            column(No_; "No.")
            {

            }


            column(Picture; CompanyInformation.Picture) { }
            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyAddres; CompanyInformation.Address) { }
            column(CompanyCity; CompanyInformation.City) { }

            trigger OnPreDataItem();
            begin
                CompanyInformation.Get()
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './app/src/rdl/RLUCertificateOfAnalysis.rdl';
        }
    }

    var
        CompanyInformation: Record "Company Information";
}