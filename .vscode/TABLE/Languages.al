table 50051 Languages
{
    Caption = 'Languages';
    LookupPageID = "Language";
    DrillDownPageId = Language;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
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
    }


}

