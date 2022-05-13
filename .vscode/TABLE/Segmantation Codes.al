table 50207 "Segmentation Codes"
{
    Caption = 'Segmentation Codes';
    /*DrillDownPageID = 99000806;
    LookupPageID = 99000806;*/


    fields
    {
        field(1; "Code"; Code[30])
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
    }

    fieldgroups
    {
    }
}

