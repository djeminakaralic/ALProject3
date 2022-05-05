tableextension 50138 ItemCategory extends "Item Category"
{
    fields
    {
        // Add changes to table fields here
        field(50003; "Min. Item Profiit"; Decimal)
        {
            Caption = 'Min. Item Profiit';
        }
    }

    var
        myInt: Integer;
}