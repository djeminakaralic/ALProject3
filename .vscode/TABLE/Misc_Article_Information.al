tableextension 50085 Misc_Article_Information extends "Misc. Article Information"
{
    fields
    {
        field(50000; Amount; integer)
        {
            Caption = 'Amount';
        }
        field(50001; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
        }
        field(50002; "Emp. Contract Ledg. Entry No."; integer)
        {
            Caption = 'Emp. Contract Ledg. Entry No.';
        }




    }

    var
        myInt: Integer;
}