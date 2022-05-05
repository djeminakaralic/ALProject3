table 50189 "Vacation setup history"
{
    Caption = 'Vacation setup history';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Vacation Code"; Code[10])
        {
            Caption = 'Vacation Code';
            TableRelation = "Cause of Absence".Code;
        }
        field(3; "Min. of Previous Exp. (Years)"; Integer)
        {
            Caption = 'Min. of Previous Exp. (Years)';
        }
        field(4; "Days for previous exp."; Integer)
        {
            Caption = 'Days for previous exp.';
        }
        field(5; "Min. of Curr. Exp. (Years)"; Integer)
        {
            Caption = 'Min. of Previous Exp. (Years)';
        }
        field(6; "Days for current exp."; Integer)
        {
            Caption = 'Days for current exp.';
        }
        field(7; "Base Days"; Integer)
        {
            Caption = 'Base (Days)';
        }
        field(8; "Vacation Validation Date"; Date)
        {
            Caption = 'Vacation Validation Date';

            trigger OnValidate()
            begin

                //Year:=DATE2DMY("Vacation Validation Date",3);
            end;
        }
        field(9; "Vacation Descision Date"; Date)
        {
            Caption = 'Vacation Descision Date';
        }
        field(10; Year; Integer)
        {
            Caption = 'Year Of Vacation';
        }
        field(50000; "Paid Candelmas Code"; Code[10])
        {
            Caption = 'Cause of Paid Candelmas  Absence Code';
            TableRelation = "Cause of Absence";
        }
        field(50001; "Paid Candelmas Quantity"; Integer)
        {
            Caption = 'Paid Candelmas Quantity';
        }
        field(50002; "Unpaid Candelmas Code"; Code[10])
        {
            Caption = 'Cause of Unpaid Candelmas  Absence Code';
            TableRelation = "Cause of Absence";
        }
        field(50003; "Unpaid Candelmas Quantity"; Integer)
        {
            Caption = 'Unaid Candelmas Quantity';
        }
        field(50004; "Paid Absence Code"; Code[10])
        {
            Caption = 'Paid Absence Code';
            TableRelation = "Cause of Absence".Code;
        }
        field(50005; "Paid Absence Quantity"; Integer)
        {
            Caption = 'Paid Absence Quantity';
        }
        field(50006; "Vacation Code Last Year"; Code[10])
        {
            Caption = 'Vacation Code';
            TableRelation = "Cause of Absence".Code;
        }
        field(50007; "Base Days RS"; Integer)
        {
            Caption = 'Base (Days) entity RS ';
        }
        field(50008; "Base Days BD"; Integer)
        {
            Caption = 'Base (Days) entity BD ';
        }
        field(50009; "Days FBIH"; Integer)
        {
            Caption = 'Days FBIH';
        }
        field(50010; "Days RS"; Integer)
        {
            Caption = 'Dani između dva prekida radnog odnosa (RS)';
        }
        field(50011; "Days BD"; Integer)
        {
            Caption = '<Dani između dva prekida radnog odnosa (BD)>';
        }
    }

    keys
    {
        key(Key1; "Primary Key", Year)
        {
        }
    }

    fieldgroups
    {
    }
}

