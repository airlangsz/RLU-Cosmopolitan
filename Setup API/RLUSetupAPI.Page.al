page 50113 RLUSetupApi
{
    ApplicationArea = Basic, Suite;
    Caption = 'Setup API';
    DataCaptionExpression = '';
    // DeleteAllowed = false;
    // InsertAllowed = false;
    PageType = Card;
    SourceTable = RLUSetupAPi;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            field(ApiName; Rec.ApiName)
            {
                ApplicationArea = All;
                // ExtendedDatatype = Masked;
                MultiLine = true;
                ToolTip = 'For APi URL';
            }

            field(SecretKey; Rec.SecretKey)
            {
                ApplicationArea = All;
                // ExtendedDatatype = Masked;
                MultiLine = true;
                ToolTip = 'For API key';
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {
            //     ApplicationArea = All;

            //     trigger OnAction();
            //     begin

            //     end;
            // }
        }
    }
}