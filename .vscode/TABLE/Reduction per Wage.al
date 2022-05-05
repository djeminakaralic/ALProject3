table 50024 "Reduction per Wage"
{
    Caption = 'Reduction per Wage';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; "Reduction No."; Code[20])
        {
            Caption = 'Reduction No.';
        }
        field(10; "Wage Header No."; Code[20])
        {
            Caption = 'Wage Header No.';
            TableRelation = "Wage Header";
        }
        field(11; "Wage Header Entry No."; Integer)
        {
            Caption = 'Wage Header Entry No.';
        }
        field(15; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(20; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(25; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(30; "Date of Calculation"; Date)
        {
            Caption = 'Date of Calculation';
        }
        field(35; Locked; Boolean)
        {
            Caption = 'Locked';
        }
        field(40; Type; Code[10])
        {
            Caption = 'Type';
        }
        field(45; SGC; Code[10])
        {
        }
        field(46; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
        field(47; "Year of Wage"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup ("Wage Header"."Year Of Wage" WHERE("No." = FIELD("Wage Header No.")));
            Caption = 'Year of Wage';

        }
        field(48; "Month of Wage"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup ("Wage Header"."Month Of Wage" WHERE("No." = FIELD("Wage Header No.")));
            Caption = 'Month of Wage';

        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Reduction No.", "Wage Header No.", Locked)
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Wage Header No.", Type)
        {
            SumIndexFields = Amount;
        }
        key(Key4; SGC, "Wage Header No.", Type)
        {
            SumIndexFields = Amount;
        }
        key(Key5; "Wage Header No.", "Employee No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
        fieldgroup("FieldGroup"; "Wage Header No.", "Month of Wage", "Year of Wage")
        {
        }
    }

    trigger OnInsert()
    begin
        "User ID" := USERID;

        E.GET("Employee No.");
        SGC := E."Statistics Group Code";
    end;

    trigger OnModify()
    begin
        "User ID" := USERID;

        E.GET("Employee No.");
        SGC := E."Statistics Group Code";
    end;

    var
        E: Record "Employee";
}

