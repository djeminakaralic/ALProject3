table 50099 "Work Performance"
//ED 01 START
{
    Caption = 'Work Performance';
    DrillDownPageID = "Work Performance";
    LookupPageID = "Work Performance";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.GET("Employee No.");
                "First Name" := Employee."First Name";
                "Last Name" := Employee."Last Name";

                SetGrade("Quality of performed work");
                RealQualityGrade := RealOptionGrade;
                SetGrade("Scope of performed work");
                RealScopeGrade := RealOptionGrade;
                SetGrade("Deadline for completion of work");
                RealDeadlineGrade := RealOptionGrade;
                SetGrade("Attitude towards work obligations");
                RealAttitudeGrade := RealOptionGrade;
                Grade := (RealQualityGrade + RealScopeGrade + RealDeadlineGrade + RealAttitudeGrade) / 4;
            end;
        }
        field(3; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(4; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(5; "Quality of performed work"; Option)
        {
            Caption = 'Quality of performed work';
            OptionMembers = "1","2","3","3.5","4","4.5","5";

            trigger OnValidate()
            begin
                SetGrade("Quality of performed work"); //zovem proceduru da prepozna koji je option
                RealQualityGrade := RealOptionGrade; //smjestam taj decimalni broj

                Grade := (RealQualityGrade + RealScopeGrade + RealDeadlineGrade + RealAttitudeGrade) / 4;
                CalculateIncrease(Rec."Quality of performed work", Rec."Scope of performed work", Rec."Deadline for completion of work", Rec."Attitude towards work obligations", Rec.Grade);
            end;
        }
        field(6; "Scope of performed work"; Option)
        {
            Caption = 'Scope of performed work';
            OptionMembers = "1","2","3","3.5","4","4.5","5";

            trigger OnValidate()
            begin
                SetGrade("Scope of performed work"); //zovem proceduru da prepozna koji je option
                RealScopeGrade := RealOptionGrade; //smjestam taj decimalni broj

                Grade := (RealQualityGrade + RealScopeGrade + RealDeadlineGrade + RealAttitudeGrade) / 4;
                CalculateIncrease(Rec."Quality of performed work", Rec."Scope of performed work", Rec."Deadline for completion of work", Rec."Attitude towards work obligations", Rec.Grade);
            end;
        }
        field(7; "Deadline for completion of work"; Option)
        {
            Caption = 'Deadline for completion of work';
            OptionMembers = "1","2","3","3.5","4","4.5","5";

            trigger OnValidate()
            begin
                SetGrade("Deadline for completion of work"); //zovem proceduru da prepozna koji je option
                RealDeadlineGrade := RealOptionGrade; //smjestam taj decimalni broj

                Grade := (RealQualityGrade + RealScopeGrade + RealDeadlineGrade + RealAttitudeGrade) / 4;
                CalculateIncrease(Rec."Quality of performed work", Rec."Scope of performed work", Rec."Deadline for completion of work", Rec."Attitude towards work obligations", Rec.Grade);
            end;
        }
        field(8; "Attitude towards work obligations"; Option)
        {
            Caption = 'Attitude towards work obligations';
            OptionMembers = "1","2","3","3.5","4","4.5","5";

            trigger OnValidate()
            begin
                SetGrade("Attitude towards work obligations"); //zovem proceduru da prepozna koji je option
                RealAttitudeGrade := RealOptionGrade; //smjestam taj decimalni broj

                Grade := (RealQualityGrade + RealScopeGrade + RealDeadlineGrade + RealAttitudeGrade) / 4;
                CalculateIncrease(Rec."Quality of performed work", Rec."Scope of performed work", Rec."Deadline for completion of work", Rec."Attitude towards work obligations", Rec.Grade);
            end;
        }
        field(9; "Grade"; Decimal)
        {
            Caption = 'Grade';
        }
        field(10; "Increase in basic salary(%)"; Decimal)
        {
            Caption = 'Increase in basic salary(%)';
        }
        field(11; Approved; Boolean)
        {
            Caption = 'Approved';

            trigger OnValidate()
            begin
                if Approved then begin

                end;
            end;
        }

    }

    keys
    {
        key(PrimaryKey; "Employee No.", "Entry No.")
        {

        }
    }

    var
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record "Employee";
        BlockedErr: Label 'You cannot register absence because the employee is blocked due to privacy.';
        EmployeeAbsenceReg: Record "Employee Absence Reg";
        EmployeeAbsence: Record "Employee Absence";
        WageSetup: Record "Wage Setup";
        RealOptionGrade: Decimal;
        RealQualityGrade: Decimal;
        RealScopeGrade: Decimal;
        RealDeadlineGrade: Decimal;
        RealAttitudeGrade: Decimal;
        Text001: Label 'Starting Date field cannot be blank.';
        Text002: Label 'Starting Date field cannot be after Ending Date field.';
        Text003: Label 'Ending Date field cannot be before Starting Date field.';
        Text004: Label 'Ending Date field cannot be blank.';
        Text005: Label 'A leave for this period already exists.';
        Text006: Label 'Selected record has already been approved.';
        Text007: Label 'Cause of absence field cannot be blank.';
        VisibleHours: Boolean;

    trigger OnInsert()
    begin
        /*if rec."Cause of Absence Code" = '' then
            Error(Text007);

        EmployeeAbsenceReg.Reset();
        EmployeeAbsenceReg.SetCurrentKey("Entry No.");
        if EmployeeAbsenceReg.FindLast then
            "Entry No." := EmployeeAbsenceReg."Entry No." + 1
        else begin
            "Entry No." := 1;
        end;*/
    end;

    trigger OnDelete()
    begin

    end;

    procedure CalculateIncrease(CurrQuality: Integer; CurrScope: Integer; CurrDeadline: Integer; CurrAttitude: Integer; CurrGrade: Decimal)
    begin
        if CurrQuality <= 2 then
            Rec."Increase in basic salary(%)" := 0
        else
            if CurrScope <= 2 then
                Rec."Increase in basic salary(%)" := 0
            else
                if CurrDeadline <= 2 then
                    Rec."Increase in basic salary(%)" := 0
                else
                    if CurrAttitude <= 2 then
                        Rec."Increase in basic salary(%)" := 0
                    else
                        Rec."Increase in basic salary(%)" := (CurrGrade - 3) * 10;
    end;

    procedure SetGrade(SentOption: Integer)   //on validate bilo koje ocjene moram prepoznati koja je to ocjena iz option
    begin
        if SentOption = 0 then
            RealOptionGrade := 1.00
        else
            if SentOption = 1 then
                RealOptionGrade := 2.00
            else
                if SentOption = 2 then
                    RealOptionGrade := 3.00
                else
                    if SentOption = 3 then
                        RealOptionGrade := 3.50
                    else
                        if SentOption = 4 then
                            RealOptionGrade := 4.00
                        else
                            if SentOption = 5 then
                                RealOptionGrade := 4.50
                            else
                                RealOptionGrade := 5.00
    end;
    //ED 01 END
}





