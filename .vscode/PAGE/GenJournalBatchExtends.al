pageextension 50218 GenJournalBatchExtends extends "General Journal Batches"
{
    layout
    {
        addafter("No. Series")
        {
            field("Cashier Table"; "Cashier Table")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cashier Table';
            }
        }

        /*addbefore(Code)
        {
            field("Short Code"; "Short Code")
            {

            }
        }
        // Add changes to page layout here
        addafter("Unit of Measure Code")
        {
           

        }
        modify("Total Absence (Base)")
        {
            Visible = false;
        }*/
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}