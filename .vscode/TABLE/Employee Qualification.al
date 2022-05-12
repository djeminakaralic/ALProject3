tableextension 50067 EmployeeQualification extends "Employee Qualification"

{
    //LookupPageId = Employee_Qualifications_HR;
    //DrillDownPageId = Employee_Qualifications_HR;

    fields
    {
        // Add changes to table fields here
        field(50000; Active; Boolean)
        {

        }
        field(50001; Switch; Option)
        {
            OptionMembers = " ","Computer Knowledge",Languages,Certification;
        }
        field(50002; "Computer Knowledge Code"; Code[10])
        {
            Caption = 'Computer Knowledge Code';
            TableRelation = "Computer Knowledge"."Program Code";

            trigger OnValidate()
            begin
                IF "Computer Knowledge Code" <> '' THEN BEGIN
                    ComputerKnowledge.RESET;
                    ComputerKnowledge.SETFILTER("Program Code", "Computer Knowledge Code");
                    IF ComputerKnowledge.FINDFIRST THEN
                        "Computer Knowledge Description" := ComputerKnowledge.Description;
                END
                ELSE
                    "Computer Knowledge Description" := '';
            end;
        }
        field(50003; "Computer Knowledge Description"; Text[100])
        {
            Caption = 'Computer Knowledge Description';
            Editable = false;
        }
        field(50004; "Language Code"; Code[10])
        {
            Caption = 'Language code';
            TableRelation = Languages.Code;

            trigger OnValidate()
            begin
                IF "Language Code" <> '' THEN BEGIN
                    Languages.RESET;
                    Languages.SETFILTER(Code, "Language Code");
                    IF Languages.FINDFIRST THEN
                        "Language Name" := Languages.Description;
                END
                ELSE
                    "Language Name" := '';
            end;
        }
        field(50005; "Language Level"; Option)
        {
            Caption = 'Level';
            OptionCaption = 'Basic,Medium,Advanced,Active';
            OptionMembers = Basic,Medium,Advanced,Active;
        }
        field(50006; "Language Name"; Text[50])
        {
            Caption = 'Language Name';
            Editable = false;
        }
        field(50007; "Exam Passed"; Boolean)
        {
            Caption = 'Exam Passed';
        }
        field(50008; "Decision No."; Code[30])
        {
            Caption = 'Decision No.';
        }
        field(50009; Status; enum "Employee Status"
        )
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';

        }
        field(50011; "Employee First Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Name';
            Editable = false;

        }
        field(50012; "Employee Last Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Last Name';
            Editable = false;

        }
        field(41; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false
        ;
        }

        field(42; "Sector Description"; Text[250])
        {
            Caption = 'Sector Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false;
        }
        field(43; "Department Category"; Text[250])
        {
            Caption = 'Department Category';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false;
        }
        field(44; "Group Description"; Text[250])
        {
            Caption = 'Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false;
        }
        field(45; "Team Description"; Text[250])
        {
            Caption = 'Team Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Team Description" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false;
        }


    }

    var
        myInt: Integer;
        Text000: Label 'You cannot delete employee qualification information if there are comments associated with it.';
        Qualification: Record "Qualification";
        Employee: Record "Employee";
        EmployeeQualification: Record "Employee Qualification";
        Languages: Record "Languages";
        ComputerKnowledge: Record "Computer Knowledge";
        Text001: Label 'Start Date must have value.';
        Text002: Label 'End Date must not be before Start date.';
        UserPersonalization: Record "User Personalization";
}