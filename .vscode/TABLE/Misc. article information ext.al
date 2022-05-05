tableextension 50121 MiscExten extends "Misc. Article Information"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(50001; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
        }
        field(50002; "Emp. Contract Ledg. Entry No."; Integer)
        {
            //ĐK AutoIncrement = false;
            Caption = 'Emp. Contract Ledg. Entry No.';
        }
        field(50003; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50004; Active; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger".Active WHERE("No." = FIELD("Emp. Contract Ledg. Entry No."),
                                                                          "Org. Structure" = FIELD("Org Shema"),
                                                                          Active = CONST(TRUE),
                                                                          "Employee No." = FIELD("Employee No.")));
            Caption = 'Active';

        }
    }

    var
        myInt: Integer;
}