table 50219 "Payment Type"
{
    Caption = 'Vrsta uplate';
    DrillDownPageID = "Payment Type";
    LookupPageID = "Payment Type";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[300])
        {
            Caption = 'Description';
        }
    }


    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}