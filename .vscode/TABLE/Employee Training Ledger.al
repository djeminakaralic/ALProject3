table 50057 "Employee Training Ledger"
{
    Caption = 'Employee Training Ledger';


    fields
    {

        field(1; Code; Integer)
        {
            AutoIncrement = true;
            Caption = 'Code';


        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(3; Code2; Integer)
        {
            Caption = 'Training time entry code';
            TableRelation = "Training Time Entry".Code;
        }
        field(4; Name; Text[250])
        {
            Caption = 'Traning Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Time Entry".Name where(Code = field(Code2)));

        }
        field(5; Type; Option)
        {
            OptionMembers = Interni,Eksterni;
            Caption = 'Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Time Entry".Type where(Code = field(Code2)));

        }
        field(6; Location; Text[250])
        {
            Caption = 'Location';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Time Entry".Location where(Code = field(Code2)));

        }
        field(7; Month; Text[50])
        {
            Caption = 'Month';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Time Entry".Month where(Code = field(Code2)));
        }

        field(8; "Start date of certificate"; Date)
        {
            Caption = 'Start date of certificate';

        }
        field(9; "End date of certificate"; Date)
        {
            Caption = 'End dateo of certificate';
            trigger OnValidate()
            begin
                if ("End date of certificate" < "Start date of certificate") then
                    Error('"End date" can not be before "Start date."');
            end;

        }
        field(10; Attended; Boolean)
        {

            Caption = 'Attended';

        }
        field(11; "Mandatory"; Boolean)
        {
            Caption = 'Mandatory';

        }
        field(12; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."First Name" where("No." = field("Employee No.")));
        }
        field(13; "Employee Last Name"; Text[50])
        {
            Caption = 'Employee Last Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Last Name" where("No." = field("Employee No.")));

        }
        field(14; Grade; Integer)
        {
            Caption = 'Grade';
        }
        field(15; Status; Option)
        {
            OptionMembers = "In progress",Finished,"In preparation";
            Caption = 'Status';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Time Entry".Status where(Code = field(Code2)));

        }

    }
    keys
    {
        key(Key1; Code2)
        {
        }
    }

}


