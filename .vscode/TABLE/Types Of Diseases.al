table 50174 "Types Of Diseases"
{
    Caption = 'Types Of Diseases';
    DrillDownPageID = "Types Of Diseases";
    LookupPageID = "Types Of Diseases";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }
}

