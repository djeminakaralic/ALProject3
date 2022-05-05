table 50063 "Points per Disability Status"
{
    Caption = 'Points per Disability Status';

    fields
    {
        field(1;"No.";Code[10])
        {
            Caption = 'No.';
        }
        field(2;Description;Text[50])
        {
            Caption = 'Description';
            InitValue = '5';
            NotBlank = false;
        }
        field(4;Points;Decimal)
        {
            Caption = 'Points';
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }
}

