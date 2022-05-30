table 50126 "Points per Experience Years"
{
    Caption = 'Points Per Experience Years';

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;

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

    trigger OnInsert()
    begin
        //PointsPerEY.Reset();
        //PointsPerEY.SetFilter();

    end;


    /*WA.SetFilter("Entry No.", '<>%1', 0);
            IF WA.FindLast() THEN
                WageAddition."Entry No." := WA."Entry No." + 1
            else
                WageAddition."Entry No." := 1;*/


    var
        PointsPerEY: Record "Points per Experience Years";
}

