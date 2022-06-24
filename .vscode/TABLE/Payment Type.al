table 50219 "Payment Type"
{
    Caption = 'Vrsta uplate';
    DrillDownPageID = "Payment Type";
    LookupPageID = "Payment Type";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[300])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}



/*        



enum 50225 "Payment Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "1")
    {
        Caption = '1';
    }
    value(1; "2")
    {
        Caption = '2';
    }
    value(2; "3")
    {
        Caption = '3';
    }
    value(3; "6")
    {
        Caption = '6';
    }
    value(4; "7")
    {
        Caption = '7';
    }
    value(5; "8")
    {
        Caption = '8';
    }
    value(6; "9")
    {
        Caption = '9';
    }
    value(7; "10")
    {
        Caption = '10';
    }
    value(8; "11")
    {
        Caption = '11';
    }
    value(9; "12")
    {
        Caption = '12';
    }
    value(10; "15")
    {
        Caption = '15';
    }
    value(11; "18")
    {
        Caption = '18';
    }
    value(12; "20")
    {
        Caption = '20';
    }
    value(13; "24")
    {
        Caption = '24';
    }

    //1,2,3,6,7,8,9,10,11,12,15,18,20,24


}*/
