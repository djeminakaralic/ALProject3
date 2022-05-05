table 50093 "Job description"
{
    Caption = 'Job description';
    DrillDownPageID = "Job description";

    fields
    {
        field(1; "Job position ID"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Job description ID';
        }
        field(2; "Job position"; Text[250])
        {
            Caption = 'Job position';
            Editable = true;
        }
        field(3; "Req. qualifications and skills"; Text[250])
        {
            Caption = 'Req. qualifications and skills';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(5; "Job position Code"; Code[20])
        {
            Caption = 'Job position Code';
        }
        field(6; Manager; Code[20])
        {
            Caption = 'Manager';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                IF Manager <> '' THEN BEGIN
                    IF T_Employee.GET(Manager) THEN
                        "Manager Name" := T_Employee."First Name" + ' ' + T_Employee."Last Name";
                END;
            end;
        }
        field(7; "Manager Name"; Text[61])
        {
            Caption = 'Manager Name';
            Editable = false;
        }
        field(8; "Perpose of job"; Text[250])
        {
            Caption = 'Perpose of job';
        }
    }

    keys
    {
        key(Key1; "Job position ID", "Job position Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF "Job position Code"<>'' THEN BEGIN
          IF T_Position.GET("Job position Code") THEN
            "Job position":=T_Position."Position ID";
           END;*/

    end;

    var
        T_Position: Record "Position";
        T_Employee: Record "Employee";
}

