table 50045 "Indirect Wage Addition Type"
{
    Caption = 'Indirect Wage Addition Type';

    fields
    {
        field(1;"Code";Code[10])
        {
            Caption = 'Code';
        }
        field(2;Description;Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

