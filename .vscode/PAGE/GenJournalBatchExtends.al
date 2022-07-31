pageextension 50218 GenJournalBatchExtends extends "General Journal Batches"
{
    layout
    {
        addafter("No. Series")
        {
            field("Cashier Table"; "Cashier Table")
            {
                ApplicationArea = all;
                Caption = 'Cashier Table';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}