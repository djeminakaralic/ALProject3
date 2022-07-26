table 50128 "Cashier Cue"
{
    Caption = 'Cashier Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Customers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer);
            Caption = 'Customers';

        }
        field(3; "All Bank Accounts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account");
            Caption = 'All Bank Accounts';
        }
        field(4; "Bank Accounts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account" WHERE("No." = FILTER('BANK*')));
            Caption = 'Bank Accounts';
        }
        field(5; "CZK"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account" WHERE("No." = FILTER('CZK*')));
            Caption = 'Centri za kupce';
        }
        field(6; "Cash Receipt Journal"; Text[100])
        {
            Caption = 'Cash Receipt Journal';
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

