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
                if Rec.Approved then
                    Error(Text002);

                Employee.GET("Employee No.");
                "First Name" := Employee."First Name";
                "Last Name" := Employee."Last Name";
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
        field(12; "Month Of Performance"; Integer)
        {
            Caption = 'Month Of Performance';

            trigger OnValidate()
            begin
                if Rec.Approved then
                    Error(Text002);

                if Rec."Month Of Performance" < 1 then
                    Error(Text003);

                if rec."Month Of Performance" > 12 then
                    Error(Text003);
            end;
        }
        field(13; "Year Of Performance"; Integer)
        {
            Caption = 'Year Of Performance';

            trigger OnValidate()
            begin
                if Rec.Approved then
                    Error(Text002);
            end;
        }
        field(5; "Quality of performed work"; Option)
        {
            Caption = 'Quality of performed work';
            OptionMembers = "1.00","2.00","3.00","3.50","4.00","4.50","5.00";

            trigger OnValidate()
            begin

                if Rec.Approved then
                    Error(Text002);

                SetGrade("Quality of performed work"); //zovem proceduru da prepozna koji je option
                RealQualityGrade := RealOptionGrade; //smjestam taj decimalni broj
                SetGrade("Scope of performed work"); //isti je postupak za preostale 3 ocjene
                RealScopeGrade := RealOptionGrade;
                SetGrade("Deadline for completion of work");
                RealDeadlineGrade := RealOptionGrade;
                SetGrade("Attitude towards work obligations");
                RealAttitudeGrade := RealOptionGrade;

                Grade := (RealQualityGrade + RealScopeGrade + RealDeadlineGrade + RealAttitudeGrade) / 4;
                CalculateIncrease(RealQualityGrade, RealScopeGrade, RealDeadlineGrade, RealAttitudeGrade, Rec.Grade);
            end;
        }
        field(6; "Scope of performed work"; Option)
        {
            Caption = 'Scope of performed work';
            OptionMembers = "1.00","2.00","3.00","3.50","4.00","4.50","5.00";

            trigger OnValidate()
            begin

                if Rec.Approved then
                    Error(Text002);

                SetGrade("Quality of performed work");
                RealQualityGrade := RealOptionGrade;
                SetGrade("Scope of performed work");
                RealScopeGrade := RealOptionGrade;
                SetGrade("Deadline for completion of work");
                RealDeadlineGrade := RealOptionGrade;
                SetGrade("Attitude towards work obligations");
                RealAttitudeGrade := RealOptionGrade;

                Grade := (RealQualityGrade + RealScopeGrade + RealDeadlineGrade + RealAttitudeGrade) / 4;
                CalculateIncrease(RealQualityGrade, RealScopeGrade, RealDeadlineGrade, RealAttitudeGrade, Rec.Grade);
            end;
        }
        field(7; "Deadline for completion of work"; Option)
        {
            Caption = 'Deadline for completion of work';
            OptionMembers = "1.00","2.00","3.00","3.50","4.00","4.50","5.00";

            trigger OnValidate()
            begin

                if Rec.Approved then
                    Error(Text002);


                SetGrade("Quality of performed work");
                RealQualityGrade := RealOptionGrade;
                SetGrade("Scope of performed work");
                RealScopeGrade := RealOptionGrade;
                SetGrade("Deadline for completion of work");
                RealDeadlineGrade := RealOptionGrade;
                SetGrade("Attitude towards work obligations");
                RealAttitudeGrade := RealOptionGrade;

                Grade := (RealQualityGrade + RealScopeGrade + RealDeadlineGrade + RealAttitudeGrade) / 4;
                CalculateIncrease(RealQualityGrade, RealScopeGrade, RealDeadlineGrade, RealAttitudeGrade, Rec.Grade);
            end;


        }
        field(8; "Attitude towards work obligations"; Option)
        {
            Caption = 'Attitude towards work obligations';
            OptionMembers = "1.00","2.00","3.00","3.50","4.00","4.50","5.00";

            trigger OnValidate()
            begin

                if Rec.Approved then
                    Error(Text002);

                SetGrade("Quality of performed work");
                RealQualityGrade := RealOptionGrade;
                SetGrade("Scope of performed work");
                RealScopeGrade := RealOptionGrade;
                SetGrade("Deadline for completion of work");
                RealDeadlineGrade := RealOptionGrade;
                SetGrade("Attitude towards work obligations");
                RealAttitudeGrade := RealOptionGrade;

                Grade := (RealQualityGrade + RealScopeGrade + RealDeadlineGrade + RealAttitudeGrade) / 4;
                CalculateIncrease(RealQualityGrade, RealScopeGrade, RealDeadlineGrade, RealAttitudeGrade, Rec.Grade);
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
                    //prvo provjeriti postoji li u tabeli odobren učinak za ovog zaposlenog, ovu godinu i ovaj mjesec
                    WorkPerformance.Reset();
                    WorkPerformance.SetFilter("Employee No.", '%1', Rec."Employee No.");
                    WorkPerformance.SetFilter("Month Of Performance", '%1', Rec."Month Of Performance");
                    WorkPerformance.SetFilter("Year Of Performance", '%1', Rec."Year Of Performance");
                    WorkPerformance.SetFilter(Approved, '%1', true);
                    if WorkPerformance.FindFirst() then
                        Error(Text001);

                    //trebam provjeriti postoji li ovaj tip dodatka
                    //kriteriji za podudaranje: procentualni tip kalkulacije, simulacija, isti iznos u %
                    WageAdditionType.Reset();
                    WageAdditionType.SetFilter(Incentive, '%1', true);
                    WageAdditionType.SetFilter("Default Amount", '%1', Rec."Increase in basic salary(%)");
                    WageAdditionType.SetFilter("Calculation Type", '%1', 0);
                    IF WageAdditionType.FindFirst() then begin
                        FoundType := WageAdditionType.Code;
                        Message('Pronašao!');
                    end
                    else begin

                        WageAdditionType.Reset();//Tipovi dodataka na plate
                        //ako ne postoji radim insert u tabelu wage addition type 
                        //ovdje nema entry no, samo ima code kao key 
                        WageAdditionType.Init();
                        WageAdditionType."Default Amount" := Rec."Increase in basic salary(%)"; //standardni iznos
                        WageAdditionType.Description := WorkPerformance.TableCaption; //opis
                        WageAdditionType."Calculation Type" := 0; //procentualni tip kalkulacije
                        WageAdditionType."Incentive" := true; //stimulacija
                        WageAdditionType."Taxable" := true; //obračunaj poreze
                        WageAdditionType."Add. Taxable" := true; //obračunaj doprinose
                        WageAdditionType."Calculate Deduction" := true; //računaj kao dio neta za obustave
                        WageAdditionType."Calculate Experience" := true; //računaj kao dio staža
                        //FoundType := WageAdditionType.Code;
                        WageAdditionType.Insert();
                        Message('Nisam pronašao!');
                    end;

                    WageAdditionType.Reset();
                    WageAdditionType.Get(FoundType);

                    WageAddition.Init(); //Lista dodataka na plate
                    WageAddition."Wage Addition Type" := FoundType;
                    WageAddition."Employee No." := Rec."Employee No.";
                    WageAddition."First Name" := Rec."First Name";
                    WageAddition."Last Name" := Rec."Last Name";
                    WageAddition."Year of Wage" := Rec."Year Of Performance";
                    WageAddition."Month of Wage" := Rec."Month Of Performance";
                    WageAddition.Description := WageAdditionType.Description;

                    WageAmounts.Reset();


                    WageAddition.Insert();
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
        Employee: Record "Employee";
        WorkPerformance: Record "Work Performance";
        BlockedErr: Label 'You cannot register absence because the employee is blocked due to privacy.';
        WageAdditionType: Record "Wage Addition Type";
        WageAddition: Record "Wage Addition";
        WageAmounts: Record "Wage Amounts";
        RealOptionGrade: Decimal;
        RealQualityGrade: Decimal;
        RealScopeGrade: Decimal;
        RealDeadlineGrade: Decimal;
        RealAttitudeGrade: Decimal;
        LastEntry: Integer;
        FoundType: Code[10];
        Text001: Label 'Work performance for the selected employee and selected month has already been entered.';
        Text002: Label 'Selected record has already been approved.';
        Text003: Label 'The entered month is not valid.';


    trigger OnInsert()
    begin
        WorkPerformance.Reset();
        WorkPerformance.SetCurrentKey("Entry No.");
        if WorkPerformance.FindLast() then
            "Entry No." := WorkPerformance."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    trigger OnDelete()
    begin

    end;

    procedure CalculateIncrease(CurrQuality: Decimal; CurrScope: Decimal; CurrDeadline: Decimal; CurrAttitude: Decimal; CurrGrade: Decimal)
    begin
        if CurrQuality = 3 then
            if CurrScope = 3 then
                if CurrDeadline = 3 then
                    if CurrAttitude = 3 then
                        rec."Increase in basic salary(%)" := 0;

        if CurrQuality < 3 then
            Rec."Increase in basic salary(%)" := 0
        else
            if CurrScope < 3 then
                Rec."Increase in basic salary(%)" := 0
            else
                if CurrDeadline < 3 then
                    Rec."Increase in basic salary(%)" := 0
                else
                    if CurrAttitude < 3 then
                        Rec."Increase in basic salary(%)" := 0
                    else
                        Rec."Increase in basic salary(%)" := (CurrGrade - 3) * 10;
    end;

    procedure SetGrade(SentOption: Integer) //on validate bilo koje ocjene moram prepoznati koja je to decimalna ocjena iz option
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
                                RealOptionGrade := 5.00;
    end;
    //ED 01 END
}





