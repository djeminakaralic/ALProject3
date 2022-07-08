table 51067 "Apoeni"
{
    Caption = 'Apoeni';
    DrillDownPageID = "Award Category List";
    LookupPageID = "Award Category List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; Quantity; Integer)
        {
            Caption = 'Quantity';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

