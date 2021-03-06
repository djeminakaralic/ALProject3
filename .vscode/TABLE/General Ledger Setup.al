tableextension 50097 GeneralLedgerSetup extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Print VAT specification"; Boolean)
        {
            Caption = 'Print VAT specification';
        }

        field(50004; "Travel No. Series"; Code[10])
        {
            Caption = 'Travel No. Series';
        }
        field(50005; "Is Simple Page"; Boolean)
        {
            Caption = 'Is Simple Page';
        }
        field(50006; "Path for fiscal printer"; Text[250])
        {
            Caption = 'Path for fiscal printer';
        }

    }

    var
        myInt: Integer;
}