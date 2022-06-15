table 50057 "Employee Training Ledger"
{
    Caption = 'Employee Training Ledger';
    LookupPageId = "Employee Trainings Ledger";
    DrillDownPageId = "Employee Trainings Ledger";


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
        field(3; Code2Entry; Integer)
        {
            Caption = 'Training time entry code';
            TableRelation = "Training Time Entry".Code;
            trigger OnValidate()
            begin
                TC.Reset();
                TC.SETFILTER(Code, '%1', Code2Entry);
                IF TC.FIND('-') THEN begin
                    Status := TC.Status;

                    TrainingCatalogue.reset;
                    TrainingCatalogue.SetFilter(TrainingCatalogue.Code, '%1', TC.Code2);
                    if TrainingCatalogue.FindFirst() then begin
                        Code3Catalogue := TrainingCatalogue.Code;
                        Name := TrainingCatalogue.Name;
                        Type := TrainingCatalogue.Type;
                        TypeOF := TrainingCatalogue.TypeOF;
                        "Type of name" := TrainingCatalogue."Type of name";

                        Location := TrainingCatalogue.Location;
                        Month := TrainingCatalogue.Month;

                    end;



                end;


            end;

        }
        field(4; Code3Catalogue; Integer)
        {
            Caption = 'Training Catalogue Code';

        }
        field(5; Name; Text[250])
        {
            Caption = 'Traning Name';


        }
        field(6; Type; Option)
        {
            OptionMembers = Interni,Eksterni;
            Caption = 'Type';


        }
        field(7; Location; Text[250])
        {
            Caption = 'Location';

        }
        field(8; Month; Text[50])
        {
            Caption = 'Month';

        }

        field(9; "Start date of certificate"; Date)
        {
            Caption = 'Start date of certificate';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Time Entry"."End date" where(Code = field(Code2Entry)));

        }
        field(10; "End date of certificate"; Date)
        {
            Caption = 'End dateo of certificate';
            trigger OnValidate()
            begin
                if ("End date of certificate" < "Start date of certificate") then
                    Error('"End date" can not be before "Start date."');
            end;

        }
        field(11; Attended; Boolean)
        {

            Caption = 'Attended';

        }
        field(12; "Mandatory"; Boolean)
        {
            Caption = 'Mandatory';

        }
        field(13; "Employee Name"; Text[50])
        {
            Caption = 'Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."First Name" where("No." = field("Employee No.")));
        }
        field(14; "Employee Last Name"; Text[50])
        {
            Caption = 'Employee Last Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Last Name" where("No." = field("Employee No.")));

        }
        field(15; Grade; Integer)
        {
            Caption = 'Grade';
        }
        field(16; Status; Option)
        {
            OptionMembers = "In progress",Finished,"In preparation";
            Caption = 'Status';


        }
        field(22; TypeOF; code[20])
        {
            Caption = 'Vrsta treninga';
            TableRelation = "Training Type";
        }
        field(23; "Type of name"; code[20])
        {
            Caption = 'Naziv vrste treninga';
            TableRelation = "Training Type";
        }


    }
    keys
    {
        key(Key1; Code)
        {
        }
    }
    var
        TC: Record "Training Time Entry";
        TrainingCatalogue: record "Training Catalogue";


}


