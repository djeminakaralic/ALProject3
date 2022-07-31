tableextension 50152 BankAccount extends "Bank Account"
{

    //ED

    fields
    {
        field(50000; "No Report"; Boolean)
        {
            Caption = 'No Report';
        }
        field(50001; "Transit G/L account"; Code[10])
        {
            Caption = 'Transit G/L account';
            TableRelation = "G/L Account";
        }
        field(50002; "No. series for Payment"; Code[20])
        {
            Caption = 'Brojčana serija za uplate';
        }

    }

    var
        myInt: Integer;
}