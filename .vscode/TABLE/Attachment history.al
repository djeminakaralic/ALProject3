table 50153 "Attachment History"
{
    Caption = 'Attachment History';
    //Đk DrillDownPageID = 51036;
    //ĐK LookupPageID = 51036;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            Editable = false;
            //ĐK test novi
        }
        field(2; Attachment; Text[250])
        {
            Caption = 'Attachment';
        }
        field(3; "Mail ID"; Integer)
        {
            Caption = 'Mail ID';
            TableRelation = "Mail History"."No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
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
