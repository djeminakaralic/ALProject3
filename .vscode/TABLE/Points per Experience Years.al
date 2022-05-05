table 50126 "Points per Experience Years"
{
    Caption = 'Points Per Experience Years';

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = false;
            Caption = 'No';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Vacation; Integer)
        {
            Caption = 'Vacation';
        }
        field(4; UpperLimit; Integer)
        {
            Caption = 'Upper Limit';
        }
        field(5; LowerLimit; Integer)
        {
            Caption = 'Lower Limit';
        }
        field(6; UpperLimit2; Text[30])
        {
            Caption = 'UpperLimit2';
        }
        field(7; LowerLimit2; Text[30])
        {
            Caption = 'LowerLimit2';
        }
        field(8; "Today Min"; Date)
        {
        }
        field(9; "Today Max"; Date)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }
}

