table 50063 "Points per Disability Status"
{
    Caption = 'Points per Disability Status';

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            NotBlank = false;
        }
        field(4; Points; Integer)
        {
            Caption = 'Points';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

