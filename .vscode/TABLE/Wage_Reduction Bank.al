table 50008 "Wage/Reduction Bank"
{
    // //

    Caption = 'Wage/Reduction Bank';
    DrillDownPageID = "Wage/Reduction Banks";
    LookupPageID = "Wage/Reduction Banks";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; City; Text[30])
        {
            Caption = 'City';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

