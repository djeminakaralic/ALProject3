tableextension 50167 BaseCalendarChange extends "Base Calendar Change"
{


    fields
    {
        // Add chafienges to table fields here
        field(50000; "Paid Holiday"; Boolean)
        {
            Caption = 'Paid Holiday';
        }
    }


    var
        myInt: Integer;
}