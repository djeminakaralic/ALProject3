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
            CalcFormula = Count("Bank Account" WHERE("No." = FILTER('BANK-01|BANK-02|BANK-03|BANK-04|BANK-05|BANK-06|BANK-07|BANK-08|BANK-09')));
            Caption = 'Bank Accounts';
        }
        field(5; "CZK"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account" WHERE("No." = FILTER('BANK-10|BANK-11|BANK-12|BANK-13|BANK-14|BANK-15|BANK-16|BANK-17|BANK-18')));
            Caption = 'Centri za kupce';
        }
        field(6; "Cash Receipt Journal"; Text[50])
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

