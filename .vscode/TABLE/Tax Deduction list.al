table 50210 "Tax deduction list"
{
    DrillDownPageID = "Tax Deduction Lists";
    LookupPageID = "Tax Deduction Lists";

    fields
    {
        field(1; Pk; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Entity Code"; Code[20])
        {
            Caption = 'Entitet';
        }
        field(3; "Valid Year"; Integer)
        {
            Caption = 'Godina';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Iznos';
        }
        field(5; Active; Boolean)
        {
            Caption = 'Aktivan';
        }
        field(6; Month; Integer)
        {
            Caption = 'Mjesec';
        }
    }

    keys
    {
        key(Key1; "Valid Year", "Entity Code", Amount)
        {
        }
    }

    fieldgroups
    {
    }
}

