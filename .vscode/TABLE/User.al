tableextension 50149 UserSetup extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(5001; "Wage Allowed"; Boolean)
        {
            Caption = 'Wage Allowed';
        }
    }

    var
        myInt: Integer;
}