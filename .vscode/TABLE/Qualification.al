tableextension 50130 Qualification extends Qualification
{
    fields
    {
        // Add changes to table fields here
        field(5000; "Description 2"; Text[300])
        {
            Caption = 'Description 2';

        }
    }





    var
        myInt: Integer;
        Item: record "Item";


}