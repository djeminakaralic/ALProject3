tableextension 51111 Test2 extends "Document Attachment"
{
    fields
    {
        // Add changes to table fields here
        field(20; "Content"; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}