pageextension 50102 GeneralLedgerSetup extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Show Amounts")
        {
            field("Is Simple Page"; "Is Simple Page")
            {
                ApplicationArea = all;
            }
            field("Path for fiscal printer"; "Path for fiscal printer")
            {
                ApplicationArea = all;
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